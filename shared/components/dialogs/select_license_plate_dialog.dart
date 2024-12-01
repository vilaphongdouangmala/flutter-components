import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/features/customer/controllers/customer_screen_ctrl.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/components/app_toastification.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:monthol_mobile/shared/models/customer_model.dart';
import 'package:monthol_mobile/shared/models/license_plate_model.dart';
import 'package:monthol_mobile/shared/services/local/shared_data_service.dart';

Future<void> showSelectLicensePlateDialog(
  BuildContext context, {
  required Function(
    LicensePlateResponseModel selectedLicensePlate,
  ) onSelectedLicensePlate,
}) async {
  final controller = Get.put(SelectLicensePlateDialogCtrl());
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
            child: SelectLicensePlateDialog(
              controller: controller,
              onSelectedLicensePlate: onSelectedLicensePlate,
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

class SelectLicensePlateDialog extends StatelessWidget {
  const SelectLicensePlateDialog({
    super.key,
    required this.controller,
    required this.onSelectedLicensePlate,
  });

  final SelectLicensePlateDialogCtrl controller;
  final Function(
    LicensePlateResponseModel selectedLicensePlate,
  ) onSelectedLicensePlate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 48,
      ),
      width: context.contextWidth() * 0.5,
      height: context.contextHeight() * 0.65,
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          AppText(
            LocalizationKeys().licensePlateSelectCar,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.customerLicensePlates.length,
              itemBuilder: (BuildContext context, int index) {
                LicensePlateResponseModel licensePlate =
                    controller.customerLicensePlates[index];
                return Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: controller.selectedLicensePlate.value?.id ==
                              licensePlate.id
                          ? AppColor.primaryGrey.withOpacity(0.3)
                          : AppColor.primaryWhite,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.selectLicensePlate(licensePlate);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: AppText(
                                licensePlate.getFullLicenseInfo(),
                                fontSize: 16,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                licensePlate.carData.brand ?? '-',
                                fontSize: 16,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                licensePlate.carData.model ?? '-',
                                fontSize: 16,
                                textAlign: TextAlign.end,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColor.primaryGrey,
                );
              },
            ),
          ),
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
              SizedBox(width: context.contextWidth() * 0.1),
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
                    controller.onSaveSelectedLicensePlate(
                      context,
                      onSelectedLicensePlate: onSelectedLicensePlate,
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

class SelectLicensePlateDialogCtrl extends GetxController with StateMixin {
  Rx<LicensePlateResponseModel?> selectedLicensePlate =
      Rx<LicensePlateResponseModel?>(null);

  RxList<LicensePlateResponseModel> customerLicensePlates =
      <LicensePlateResponseModel>[].obs;

  @override
  void onInit() {
    getSelectedCustomerLicensePlate();
    super.onInit();
  }

  void getSelectedCustomerLicensePlate() {
    selectedLicensePlate.value = null;
    if (!Get.isRegistered<CustomerScreenCtrl>()) return;

    CustomerResponseModel? selectedCustomer =
        Get.find<CustomerScreenCtrl>().selectedCustomer.value;

    if (selectedCustomer == null) return;

    customerLicensePlates.value =
        Get.find<CustomerScreenCtrl>().selectedCustomer.value!.licensePlates;
  }

  void selectLicensePlate(LicensePlateResponseModel licensePlate) {
    selectedLicensePlate.value = licensePlate;
  }

  void onSaveSelectedLicensePlate(
    BuildContext context, {
    required Function(
      LicensePlateResponseModel selectedLicensePlate,
    ) onSelectedLicensePlate,
  }) {
    if (selectedLicensePlate.value == null) {
      showAppToastAlert(
        title: LocalizationKeys().licensePlatePleaseSelectOneCar,
        alertType: AlertType.error,
      );
      return;
    }
    SharedDataService().selectedLicensePlate.value = selectedLicensePlate.value;
    if (selectedLicensePlate.value != null) {
      onSelectedLicensePlate(selectedLicensePlate.value!);
    }
    onCloseDialog(context);
  }

  void onCloseDialog(BuildContext context) {
    Navigator.of(context).pop();
    Get.delete<SelectLicensePlateDialogCtrl>();
  }
}
