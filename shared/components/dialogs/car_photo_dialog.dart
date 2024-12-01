import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/common/utils/file_utils.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_file_image.dart';
import 'package:monthol_mobile/shared/components/app_svg_icon.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/components/app_toastification.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:monthol_mobile/shared/models/common_model.dart';

Future<void> showCarPhotoDialog(
  BuildContext context, {
  required Function(List<File> photos) onConfirm,
}) async {
  final CarPhotoDialogCtrl controller = Get.put(CarPhotoDialogCtrl());
  await showGeneralDialog(
    context: context,
    barrierColor: AppColor.dialogBarrierColor,
    transitionDuration: AppTransition.popupAnimationDuration,
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: CarPhotoDialog(
              onConfirm: onConfirm,
              controller: controller,
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
  );
}

class CarPhotoDialog extends StatelessWidget {
  const CarPhotoDialog({
    super.key,
    required this.onConfirm,
    required this.controller,
  });

  final Function(List<File> photos) onConfirm;
  final CarPhotoDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 48),
      width: context.contextWidth() * 0.8,
      height: context.contextHeight() * 0.82,
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          controller.photos.length + 1,
                          (index) {
                            return PhotoListItem(
                              index: index,
                              controller: controller,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: controller.previewPhoto.value != null
                        ? AppFileImage(
                            fileImage: controller.previewPhoto.value!,
                          )
                        : Center(
                            child: AppText(
                              LocalizationKeys().commonNoPhotoSelected,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppButton(
                  text: LocalizationKeys().commonCancel.toUpperCase(),
                  textStyle: AppTheme.primaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.sageGreen,
                  ),
                  borderWidth: 3,
                  borderColor: AppColor.sageGreen,
                  borderRadius: 5,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryBlack.withOpacity(0.25),
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                    ),
                  ],
                  backgroundColor: AppColor.primaryWhite,
                  height: 55,
                  onPressed: () {
                    controller.onCloseDialog(context);
                  },
                ),
              ),
              SizedBox(width: context.contextWidth() * 0.3),
              Expanded(
                child: AppButton(
                  text: LocalizationKeys().commonConfirm.toUpperCase(),
                  textStyle: AppTheme.primaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.brightGreen,
                  ),
                  borderRadius: 5,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryBlack.withOpacity(0.25),
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                    ),
                  ],
                  backgroundColor: AppColor.primaryGreen,
                  height: 55,
                  onPressed: () {
                    controller.onConfirm(
                      context,
                      onParentConfirm: onConfirm,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final CarPhotoDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: context.contextWidth() * 0.08,
          width: context.contextWidth() * 0.12,
          decoration: BoxDecoration(
            color: AppColor.primaryGrey,
            boxShadow: !controller.isAddPhotoIndex(index) &&
                    controller.photos[index].isSelected.value
                ? [
                    const BoxShadow(
                      color: AppColor.brightGreen,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
          child: InkWell(
            onTap: !controller.isAddPhotoIndex(index)
                ? () {
                    controller.onPhotoSelected(index);
                  }
                : () {
                    controller.onTakePhoto();
                  },
            child: !controller.isAddPhotoIndex(index)
                ? AppFileImage(
                    fileImage: controller.photos[index].value,
                  )
                : const Center(
                    child: AppSvgIcon(
                      svgAsset: AssetConstants.cameraIcon,
                      size: 28,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class CarPhotoDialogCtrl extends GetxController with StateMixin {
  RxList<SelectableModel<File>> photos = <SelectableModel<File>>[].obs;
  Rx<File?> previewPhoto = Rx<File?>(null);

  Future<void> onTakePhoto() async {
    if (maxPhotosTaken) return;
    File? photo = await FileUtils.takePhoto();
    if (photo == null) return;
    photos.add(SelectableModel(value: photo));
    previewPhoto.value = photo;
  }

  void onCloseDialog(BuildContext context) {
    Get.delete<CarPhotoDialogCtrl>();
    Navigator.of(context).pop();
  }

  void onConfirm(
    BuildContext context, {
    required Function(List<File> photos) onParentConfirm,
  }) {
    if (selectedPhotos.isEmpty) {
      showAppToastAlert(
        title: LocalizationKeys().commonNoPhotoSelected,
        alertType: AlertType.error,
      );
      return;
    }
    onParentConfirm(selectedPhotos);
    if (context.mounted) {
      onCloseDialog(context);
    }
  }

  List<File> get selectedPhotos {
    return photos
        .where((photo) => photo.isSelected.value)
        .map((photo) => photo.value)
        .toList();
  }

  void onPhotoSelected(int index) {
    final SelectableModel<File> selectedPhoto = photos[index];
    final isSelectingAction = !selectedPhoto.isSelected.value;
    if (isSelectingAction && maxPhotosSelected) return;
    previewPhoto.value = photos[index].value;
    photos[index].isSelected.value = !photos[index].isSelected.value;
  }

  bool isAddPhotoIndex(int index) {
    return index == photos.length;
  }

  bool get maxPhotosSelected {
    return photos.where((photo) => photo.isSelected.value).length >= 4;
  }

  bool get maxPhotosTaken {
    return photos.length >= 10;
  }
}
