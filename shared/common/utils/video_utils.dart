import 'package:monthol_mobile/shared/common/utils/file_utils.dart';

class VideoUtils {
  static isNetworkVideoUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || uri.path.isEmpty) {
      return false;
    }

    final extension = uri.pathSegments.last.split('.').last.toLowerCase();
    return FileUtils.allowedVideoExtensions.contains(extension);
  }

  static isBase64Video(String base64String) {
    final base64Regex =
        RegExp(r'^data:video\/(mp4|mov);base64,[A-Za-z0-9+/]+={0,2}$');
    return base64Regex.hasMatch(base64String);
  }
}
