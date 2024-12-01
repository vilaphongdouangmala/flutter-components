import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/features/customer/controllers/customer_screen_ctrl.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';
import 'package:monthol_mobile/shared/common/constants/car_data_constants.dart';
import 'package:monthol_mobile/shared/common/constants/common_constants.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/common/utils/file_utils.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_file_image.dart';
import 'package:monthol_mobile/shared/components/app_input.dart';
import 'package:monthol_mobile/shared/components/app_network_image.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/components/app_toastification.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:monthol_mobile/shared/models/car_data_model.dart';
import 'package:monthol_mobile/shared/models/license_plate_model.dart';
import 'package:monthol_mobile/shared/services/remote/license_plate_service.dart';

Future<void> showAddEditLicensePlateDialog(
  BuildContext context, {
  LicensePlateResponseModel? licensePlate,
}) async {
  final controller =
      Get.put(AddEditLicensePlateDialogCtrl(licensePlate: licensePlate));
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
            child: AddEditLicensePlateDialogLayout(
              licensePlate: licensePlate,
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

class AddEditLicensePlateDialogLayout extends StatelessWidget {
  const AddEditLicensePlateDialogLayout({
    super.key,
    required this.controller,
    this.licensePlate,
  });

  final LicensePlateResponseModel? licensePlate;
  final AddEditLicensePlateDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36),
      width: context.contextWidth() * 0.5,
      constraints: BoxConstraints(
        maxHeight: context.contextHeight() * 0.9,
      ),
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AddEditLicensePlateDialogHeader(),
          SizedBox(height: context.contextHeight() * 0.03),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AddEditLicensePlateDialogForm(
                    controller: controller,
                  ),
                  SizedBox(height: context.contextHeight() * 0.03),
                  AddEditLicensePlateDialogActions(
                    controller: controller,
                  ),
                  SizedBox(height: context.contextHeight() * 0.01),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddEditLicensePlateDialogHeader extends StatelessWidget {
  const AddEditLicensePlateDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(
                LocalizationKeys().licensePlateCarInformation,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColor.darkBlue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Divider(
          color: AppColor.darkGrey,
          thickness: 1,
          height: 2,
        ),
      ],
    );
  }
}

class AddEditLicensePlateDialogForm extends StatelessWidget {
  const AddEditLicensePlateDialogForm({
    super.key,
    required this.controller,
  });

  final AddEditLicensePlateDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      controller.onImagePicked(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: context.contextHeight() * 0.2,
                        constraints: BoxConstraints(
                          minWidth: context.contextWidth() * 0.3,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Obx(
                          () => controller.pickImage.value != null
                              ? AppFileImage(
                                  fileImage:
                                      File(controller.pickImage.value!.path),
                                  fit: BoxFit.cover,
                                )
                              : controller.licensePlate?.carData.photo != null
                                  ? AppNetworkImage(
                                      imageUrl: controller
                                          .licensePlate!.carData.photo!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.car_crash_outlined,
                                      size: context.contextWidth() * 0.10,
                                      color: AppColor.darkGrey,
                                    ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          LocalizationKeys().licensePlateColor,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemCount: CarDataConstants.colors.length,
                            itemBuilder: (context, index) {
                              final color = CarDataConstants.colors[index];
                              return InkWell(
                                onTap: () {
                                  controller.selectedColor.value = color;
                                },
                                child: Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                      color: color.color,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: controller.selectedColor.value ==
                                                color
                                            ? AppColor.primaryGreen
                                            : AppColor.primaryWhite,
                                        width: 4,
                                      ),
                                    ),
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().licensePlateCarLicense,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppInput(
                              controller: controller.thaiPrefixController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: AppInput(
                              controller: controller.numberController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: AppInput(
                              controller: controller.provinceController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateCarType,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.carTypeController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateCarFuel,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.fuelTypeController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateBrand,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.brandController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateModel,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.modelController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateModelYear,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.modelYearController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              LocalizationKeys().licensePlateVIN,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppInput(
                              controller: controller.vinController,
                              borderRadius: controller.inputBorderRadius,
                              textBoxHeight: controller.inputHeight,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.contextHeight() * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppText(
                                  LocalizationKeys().licensePlateFrontTire,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 4),
                                AppInput(
                                  controller:
                                      controller.frontTireSizeController,
                                  borderRadius: controller.inputBorderRadius,
                                  textBoxHeight: controller.inputHeight,
                                  hintText: LocalizationKeys().licensePlateSize,
                                ),
                                const SizedBox(height: 4),
                                AppInput(
                                  controller:
                                      controller.frontTirePressureController,
                                  borderRadius: controller.inputBorderRadius,
                                  textBoxHeight: controller.inputHeight,
                                  hintText:
                                      LocalizationKeys().licensePlatePressure,
                                )
                              ],
                            ),
                            SizedBox(height: context.contextHeight() * 0.015),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppText(
                                  LocalizationKeys().licensePlateRearTire,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 4),
                                AppInput(
                                  controller: controller.rearTireSizeController,
                                  borderRadius: controller.inputBorderRadius,
                                  textBoxHeight: controller.inputHeight,
                                  hintText: LocalizationKeys().licensePlateSize,
                                ),
                                const SizedBox(height: 4),
                                AppInput(
                                  controller:
                                      controller.rearTirePressureController,
                                  borderRadius: controller.inputBorderRadius,
                                  textBoxHeight: controller.inputHeight,
                                  hintText:
                                      LocalizationKeys().licensePlatePressure,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Image.asset(
                          AssetConstants.carLayout,
                          width: context.contextWidth() * 0.10,
                          height: context.contextHeight() * 0.28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEditLicensePlateDialogActions extends StatelessWidget {
  const AddEditLicensePlateDialogActions({
    super.key,
    required this.controller,
  });

  final AddEditLicensePlateDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Obx(
        () => Row(
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
                borderRadius: controller.inputBorderRadius,
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
            SizedBox(width: context.contextWidth() * 0.1),
            Expanded(
              child: AppButton(
                isLoading: controller.loading.value,
                text: controller.isEditMode
                    ? LocalizationKeys().commonSave.toUpperCase()
                    : LocalizationKeys().commonCreate.toUpperCase(),
                textStyle: AppTheme.primaryTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.brightGreen,
                ),
                borderRadius: controller.inputBorderRadius,
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
                  controller.onSubmit(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEditLicensePlateDialogCtrl extends GetxController with StateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LicensePlateService licensePlateService = LicensePlateService();

  final TextEditingController thaiPrefixController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController modelYearController = TextEditingController();
  final TextEditingController vinController = TextEditingController();
  final TextEditingController frontTireSizeController = TextEditingController();
  final TextEditingController frontTirePressureController =
      TextEditingController();
  final TextEditingController rearTireSizeController = TextEditingController();
  final TextEditingController rearTirePressureController =
      TextEditingController();
  final Rx<File?> pickImage = Rx<File?>(null);
  final Rx<CarDataColorModel> selectedColor = Rx<CarDataColorModel>(
    CarDataConstants.colors.first,
  );

  final LicensePlateResponseModel? licensePlate;
  final double inputBorderRadius = 5;
  final double inputHeight = 40;

  RxBool loading = false.obs;

  AddEditLicensePlateDialogCtrl({this.licensePlate});

  @override
  void onInit() {
    initForm();
    super.onInit();
  }

  void initForm() {
    if (isEditMode) {
      thaiPrefixController.text = licensePlate!.thaiPrefix;
      numberController.text = licensePlate!.number;
      provinceController.text = licensePlate!.regionalCode;
      carTypeController.text = licensePlate!.carData.type;
      fuelTypeController.text = licensePlate!.carData.fuelType;
      brandController.text = licensePlate!.carData.brand ?? '';
      modelController.text = licensePlate!.carData.model ?? '';
      modelYearController.text = licensePlate!.carData.modelYear ?? '';
      vinController.text = licensePlate!.carData.vin ?? '';

      if (licensePlate?.carData.color != null) {
        selectedColor.value =
            CarDataConstants.getColorByValue(licensePlate!.carData.color!) ??
                CarDataConstants.colors.first;
      }

      // frontTireSizeController.text = licensePlate!.carData.frontTireSize ?? '';
      // frontTirePressureController.text =
      //     licensePlate!.carData.frontTirePressure ?? '';
      // rearTireSizeController.text = licensePlate!.carData.rearTireSize ?? '';
      // rearTirePressureController.text =
      //     licensePlate!.carData.rearTirePressure ?? '';
    }
  }

  Future<bool> validateForm() async {
    await Future.delayed(CommonConstants.commonValidationWaitTime);
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> onSubmit(BuildContext context) async {
    if (!await validateForm()) return;

    if (context.mounted) {
      if (isEditMode) {
        await onUpdateLicensePlate(context);
      } else {
        await onCreateLicensePlate(context);
      }
    }
  }

  Future<void> onImagePicked(BuildContext context) async {
    await FileUtils.showFileAttachmentDialog(
      context: context,
      isMultipleGalleryAllowed: false,
      pickFileDisabled: true,
      takeVideoDisabled: true,
      onFileSelected: (files) {
        if (files.isNotEmpty) {
          pickImage.value = files.first;
        }
      },
    );
  }

  Future<void> onCreateLicensePlate(
    BuildContext context,
  ) async {
    try {
      loading.value = true;
      final CreateEditLicensePlateModel createEditLicensePlateModel =
          await getLicensePlateModelFromForm();
      // call the API to create a new customer
      final request = licensePlateService.createLicensePlate(
        createEditLicensePlateModel,
      );
      await licensePlateService.returnResponse(
        request,
        onSuccess: (json) async {
          await reloadCustomerDetails();
          loading.value = false;
          showAppToastAlert(
            title: LocalizationKeys().commonCreatedSuccessfully,
            alertType: AlertType.success,
          );
          if (context.mounted) {
            onCloseDialog(context);
          }
        },
        onUnsuccess: (errorResponseData) {
          loading.value = false;
          debugPrint('Error: $errorResponseData');
        },
      );
    } catch (e) {
      loading.value = false;
      debugPrint('Error: $e');
    }
  }

  Future<void> onUpdateLicensePlate(
    BuildContext context,
  ) async {
    try {
      loading.value = true;
      final CreateEditLicensePlateModel createEditLicensePlateModel =
          await getLicensePlateModelFromForm();
      // call the API to create a new license plate
      final request = licensePlateService.updateLicensePlate(
        createEditLicensePlateModel,
      );
      await licensePlateService.returnResponse(
        request,
        onSuccess: (json) async {
          await reloadCustomerDetails();
          loading.value = false;
          showAppToastAlert(
            title: LocalizationKeys().commonSavedSuccessfully,
            alertType: AlertType.success,
          );
          if (context.mounted) {
            onCloseDialog(context);
          }
        },
        onUnsuccess: (errorResponseData) {
          loading.value = false;
          debugPrint('Error: $errorResponseData');
          showAppToastAlert(
            title: LocalizationKeys().commonError,
            alertType: AlertType.error,
          );
        },
      );
    } catch (e) {
      loading.value = false;
      debugPrint('Error: $e');
      showAppToastAlert(
        title: LocalizationKeys().commonError,
        alertType: AlertType.error,
      );
    }
  }

  Future<CreateEditLicensePlateModel> getLicensePlateModelFromForm() async {
    return CreateEditLicensePlateModel(
      id: licensePlate?.id,
      thaiPrefix: thaiPrefixController.text,
      number: numberController.text,
      regionalCode: provinceController.text,
      customerId: selectedCustomerId,
      carData: CreateEditCarDataModel(
        type: carTypeController.text,
        fuelType: fuelTypeController.text,
        brand: brandController.text,
        model: modelController.text,
        modelYear: modelYearController.text,
        vin: vinController.text,
        attributes: {},
        color: selectedColor.value.value,
        photo: pickImage.value != null
            ? await FileUtils.convertFileAsBase64(pickImage.value!)
            : null,
        // frontTireSize: frontTireSizeController.text,
        // frontTirePressure: frontTirePressureController.text,
        // rearTireSize: rearTireSizeController.text,
        // rearTirePressure: rearTirePressureController.text,
      ),
    );
  }

  void onCloseDialog(BuildContext context) {
    Navigator.of(context).pop();
    Get.delete<AddEditLicensePlateDialogCtrl>();
  }

  Future<void> reloadCustomerDetails() async {
    if (Get.isRegistered<CustomerScreenCtrl>()) {
      await Get.find<CustomerScreenCtrl>().getCustomerDetails(
        selectedCustomerId,
      );
    }
  }

  get isEditMode => licensePlate != null;
  get selectedCustomerId => Get.isRegistered<CustomerScreenCtrl>()
      ? Get.find<CustomerScreenCtrl>().selectedCustomer.value?.id
      : null;
}
