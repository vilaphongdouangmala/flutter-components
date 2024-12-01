import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileUtils {
  static const allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
  ];

  static const allowedVideoExtensions = [
    'mp4',
    'mov',
  ];

  static const allowedFileExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
  ];

  static const allowedExtensions = [
    ...allowedImageExtensions,
    ...allowedVideoExtensions,
    ...allowedFileExtensions,
  ];

  static Future<File?> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile;
    try {
      imageFile = await picker.pickImage(source: ImageSource.camera);
      if (imageFile == null) {
        return null;
      }
      return File(imageFile.path);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<File?> takeVideo() async {
    final picker = ImagePicker();
    XFile? videoFile;
    try {
      videoFile = await picker.pickVideo(source: ImageSource.camera);
      if (videoFile == null) {
        return null;
      }
      return File(videoFile.path);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<File?> pickImage(ImageSource source) async {
    final ImagePicker pickerImage = ImagePicker();
    XFile? imageFile;
    try {
      imageFile = await pickerImage.pickImage(source: source);
      if (imageFile == null) {
        return null;
      }
      return File(imageFile.path);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<File?> pickVideo() async {
    final picker = ImagePicker();
    XFile? videoFile;
    try {
      videoFile = await picker.pickVideo(source: ImageSource.gallery);
      if (videoFile == null) {
        return null;
      }
      return File(videoFile.path);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<List<File>?> pickMultipleMedias() async {
    final ImagePicker picker = ImagePicker();
    try {
      // pick multiple images and videos.
      final List<XFile> medias = await picker.pickMultipleMedia();
      return medias.map((e) => File(e.path)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<List<File>?> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: FileUtils.allowedFileExtensions,
      );
      if (result == null) {
        return null;
      }
      return result.paths.map((path) => File(path!)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<File?> downloadFile(
    String url, {
    String? fileName,
  }) async {
    final appStorage = await getApplicationDocumentsDirectory();
    fileName = fileName ?? const Uuid().v4();
    final fileExtension = url.split('.').last.toLowerCase();
    final file = File('${appStorage.path}/$fileName.$fileExtension');
    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<void> previewFile(
    filePath, {
    Function? onDownloaded,
  }) async {
    if (FileUtils.isBase64File(filePath)) {
      final base64String = filePath.split(',').last;
      final file = File('${(await getTemporaryDirectory()).path}/temp_file');
      await file.writeAsBytes(base64Decode(base64String));
      onDownloaded?.call();
      await OpenFile.open(file.path);
    } else {
      final fileName = FileUtils.getFileName(filePath);
      File? file = await downloadFile(filePath, fileName: fileName);
      onDownloaded?.call();
      if (file == null) return;
      await OpenFile.open(file.path);
    }
  }

  static Future<void> showFileAttachmentDialog({
    required BuildContext context,
    required Function(List<File> pickedFileList) onFileSelected,
    bool takePhotoDisabled = false,
    bool takeVideoDisabled = false,
    bool pickFileDisabled = false,
    bool pickGalleryDisabled = false,
    bool isMultipleGalleryAllowed = true,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            if (!takePhotoDisabled)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final photo = await takePhoto();
                  if (photo != null) {
                    onFileSelected([photo]);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                  LocalizationKeys().commonTakePhoto,
                ),
              ),
            if (!takeVideoDisabled)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final video = await takeVideo();
                  if (video != null) {
                    onFileSelected([video]);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                  LocalizationKeys().commonTakeVideo,
                ),
              ),
            if (!pickGalleryDisabled && isMultipleGalleryAllowed)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final List<File>? pickedMedias = await pickMultipleMedias();
                  if (pickedMedias != null) {
                    onFileSelected(pickedMedias);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                  LocalizationKeys().commonGallery,
                ),
              ),
            if (!pickGalleryDisabled && !isMultipleGalleryAllowed)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final File? pickedMedia =
                      await pickImage(ImageSource.gallery);
                  if (pickedMedia != null) {
                    onFileSelected([pickedMedia]);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                  LocalizationKeys().commonGallery,
                ),
              ),
            if (!pickFileDisabled)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final List<File>? pickedFiles = await pickFiles();
                  if (pickedFiles != null) {
                    onFileSelected(pickedFiles);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: AppText(
                  LocalizationKeys().commonFile,
                ),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: AppText(
              LocalizationKeys().commonCancel,
            ),
          ),
        );
      },
    );
  }

  static String getFileExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  static String getFileName(String path) {
    return path.split('/').last;
  }

  static Future<Uint8List> convertFileAsBinary(File file) async {
    return await file.readAsBytes();
  }

  static Future<String> convertFileAsBase64(File file) async {
    return base64Encode(await file.readAsBytes());
  }

  static Uint8List convertBase64AsBinary(String base64String) {
    return base64Decode(base64String);
  }

  static isNetworkFileUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || uri.path.isEmpty) {
      return false;
    }

    final extension = uri.pathSegments.last.split('.').last.toLowerCase();
    return allowedFileExtensions.contains(extension);
  }

  static isBase64File(String base64String) {
    final base64Regex = RegExp(
        r'^data:application\/(pdf|doc|docx|xls|xlsx);base64,[A-Za-z0-9+/]+={0,2}$');
    return base64Regex.hasMatch(base64String);
  }
}
