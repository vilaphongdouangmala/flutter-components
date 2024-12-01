import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/shared/common/enums/media_enum.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/common/utils/image_utils.dart';
import 'package:monthol_mobile/shared/common/utils/video_utils.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_file_image.dart';
import 'package:monthol_mobile/shared/components/app_icon_button.dart';
import 'package:monthol_mobile/shared/components/app_loading.dart';
import 'package:monthol_mobile/shared/components/app_network_image.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:video_player/video_player.dart';

Future<void> showMediaPlayerDialog({
  required BuildContext context,
  required MediaPlayerType mediaPlayerType,
  required String mediaPath,
  Function? onConfirm,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return MediaPlayerDialog(
        context: context,
        onConfirm: onConfirm,
        mediaPlayerType: mediaPlayerType,
        mediaPath: mediaPath,
      );
    },
  );
}

class MediaPlayerDialog extends StatelessWidget {
  final BuildContext context;
  final Function? onConfirm;
  final MediaPlayerType mediaPlayerType;
  final String mediaPath;

  const MediaPlayerDialog({
    super.key,
    required this.context,
    required this.mediaPlayerType,
    required this.mediaPath,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final MediaPlayerDialogController controller = Get.put(
      MediaPlayerDialogController(
        mediaPlayerType: mediaPlayerType,
        mediaPath: mediaPath,
      ),
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 36.0,
          horizontal: 48.0,
        ),
        width: context.contextWidth() * 0.8,
        height: context.contextHeight() * 0.9,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRect(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColor.primaryGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: () {
                        switch (mediaPlayerType) {
                          case MediaPlayerType.image:
                            return MediaImagePlayer();
                          case MediaPlayerType.video:
                            return MediaVideoPlayer();
                          default:
                            return Container();
                        }
                      }(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    AppButton(
                      text: LocalizationKeys().commonDone,
                      textStyle: AppTheme.primaryTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        if (onConfirm != null) {
                          onConfirm?.call();
                        }
                        Navigator.of(context).pop();
                        if (controller.videoPlayerController.value != null) {
                          controller.videoPlayerController.value!.dispose();
                        }
                        Get.delete<MediaPlayerDialogController>();
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 16,
              top: 16,
              child: AppIconButton(
                onPressed: () {},
                icon: Icons.download_for_offline,
                size: 42,
                backgroundColor: AppColor.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaImagePlayer extends StatelessWidget {
  MediaImagePlayer({
    super.key,
  });

  final controller = Get.find<MediaPlayerDialogController>();

  @override
  Widget build(BuildContext context) {
    return ImageUtils.isNetworkImageUrl(controller.mediaPath)
        ? AppNetworkImage(
            imageUrl: controller.mediaPath,
            fit: BoxFit.contain,
          )
        : AppFileImage(
            fileImage: File(
              controller.mediaPath,
            ),
            fit: BoxFit.contain,
          );
  }
}

class MediaVideoPlayer extends StatelessWidget {
  MediaVideoPlayer({
    super.key,
  });

  final controller = Get.find<MediaPlayerDialogController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !controller.loading.value &&
              controller.videoPlayerController.value!.value.isInitialized
          ? GestureDetector(
              onTap: controller.onPlayPause,
              child: Center(
                child: AspectRatio(
                  aspectRatio:
                      controller.videoPlayerController.value!.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(
                        controller.videoPlayerController.value!,
                      ),
                      if (!controller.isPlaying.value)
                        Center(
                          child: ElevatedButton(
                            onPressed: controller.onPlayPause,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColor.primaryWhite,
                              backgroundColor: Colors.transparent,
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.play_arrow,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          : const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AppLoading(),
                ),
              ],
            ),
    );
  }
}

class MediaPlayerDialogController extends GetxController with StateMixin {
  Rx<VideoPlayerController?> videoPlayerController =
      Rx<VideoPlayerController?>(null);
  final MediaPlayerType mediaPlayerType;
  final String mediaPath;
  RxBool isPlaying = false.obs;
  RxBool loading = false.obs;

  MediaPlayerDialogController({
    required this.mediaPlayerType,
    required this.mediaPath,
  });

  @override
  void onInit() {
    super.onInit();
    if (mediaPlayerType == MediaPlayerType.video) {
      initializeVideoPlayer();
    }
  }

  Future<void> initializeVideoPlayer() async {
    loading.value = true;
    if (VideoUtils.isNetworkVideoUrl(mediaPath)) {
      print('mediaPath network');
      print(mediaPath);
      videoPlayerController.value = VideoPlayerController.networkUrl(
        Uri.parse(mediaPath),
      );
    } else {
      print('mediaPath but file');
      print(mediaPath);
      videoPlayerController.value = VideoPlayerController.file(
        File(mediaPath),
      );
    }
    await videoPlayerController.value!.setLooping(false);
    await videoPlayerController.value!.initialize();
    await videoPlayerController.value!.play();
    loading.value = false;
    isPlaying.value = true;
  }

  void onPlayPause() {
    if (isPlaying.value) {
      videoPlayerController.value!.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController.value!.play();
      isPlaying.value = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.value?.dispose();
  }
}
