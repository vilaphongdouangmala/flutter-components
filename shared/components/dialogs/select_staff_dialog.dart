import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/common/enums/common_enums.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_icon_button.dart';
import 'package:monthol_mobile/shared/components/app_input.dart';
import 'package:monthol_mobile/shared/components/app_skeletonizer.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/components/app_toastification.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:monthol_mobile/shared/models/common_model.dart';
import 'package:monthol_mobile/shared/models/staff_model.dart';
import 'package:monthol_mobile/shared/services/remote/staff_service.dart';

Future<void> showSelectStaffDialog(
  BuildContext context, {
  required Function(
    StaffResponseModel customerService,
  ) onSelectedStaff,
}) async {
  final controller = Get.put(SelectStaffDialogCtrl());
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
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
            child: SelectStaffDialog(
              controller: controller,
              onSelectedStaff: onSelectedStaff,
            ),
          ),
        ),
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
  ).then((_) {
    if (Get.isRegistered<SelectStaffDialogCtrl>()) {
      Get.delete<SelectStaffDialogCtrl>();
    }
  });
}

class SelectStaffDialog extends StatelessWidget {
  const SelectStaffDialog({
    super.key,
    required this.controller,
    required this.onSelectedStaff,
  });

  final SelectStaffDialogCtrl controller;
  final Function(
    StaffResponseModel customerService,
  ) onSelectedStaff;

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
            LocalizationKeys().staffSelectCustomerService,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          Expanded(
            child: Obx(
              () => AppSkeletonizer(
                enabled: controller.loading.value,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  controller: controller.scrollController,
                  itemCount: controller.staffListViewLength,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: !controller.isAddStaffRow(index) &&
                                  controller.paginatedStaffs.value
                                          .results[index] ==
                                      controller.selectedStaff.value
                              ? AppColor.primaryGrey.withOpacity(0.3)
                              : AppColor.primaryWhite,
                        ),
                        child: InkWell(
                          onTap: controller.isAddStaffRow(index)
                              ? null
                              : () {
                                  controller.onSelectedStaff(
                                    controller
                                        .paginatedStaffs.value.results[index],
                                  );
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            child: controller.isAddStaffRow(index)
                                ? AddEditCustomerServiceItem(
                                    controller: controller,
                                    addEditController:
                                        controller.newStaffNameController,
                                    onAddEdit: () {
                                      controller.onAddStaff();
                                    },
                                    onCancel: () {
                                      controller.isAddMode.value = false;
                                    },
                                  )
                                : CustomerServiceItem(
                                    controller: controller,
                                    index: index,
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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AppButton(
                  icon: Icons.add,
                  iconSize: 28,
                  text: LocalizationKeys().staffAddStaff.toUpperCase(),
                  textStyle: AppTheme.primaryTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                    controller.onAddStaffButtonTap();
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
                    controller.onSaveselectedStaff(
                      context,
                      onSelectedStaff: onSelectedStaff,
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

class AddEditCustomerServiceItem extends StatelessWidget {
  const AddEditCustomerServiceItem({
    super.key,
    required this.controller,
    required this.addEditController,
    required this.onAddEdit,
    required this.onCancel,
  });

  final SelectStaffDialogCtrl controller;
  final TextEditingController addEditController;
  final Function onAddEdit;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 10,
          child: AppInput(
            controller: addEditController,
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppIconButton(
                icon: Icons.check,
                iconColor: AppColor.brightGreen,
                isNoContainer: true,
                onPressed: () {
                  onAddEdit();
                },
              ),
              const SizedBox(width: 16),
              AppIconButton(
                icon: Icons.close,
                iconColor: AppColor.primaryRed,
                isNoContainer: true,
                onPressed: () {
                  onCancel();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomerServiceItem extends StatelessWidget {
  const CustomerServiceItem({
    super.key,
    required this.controller,
    required this.index,
  });

  final SelectStaffDialogCtrl controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.paginatedStaffs.value.results[index].isEditMode.value
          ? AddEditCustomerServiceItem(
              controller: controller,
              addEditController: controller
                  .paginatedStaffs.value.results[index].editNameController,
              onAddEdit: () {
                controller.onEditStaff(
                    controller.paginatedStaffs.value.results[index]);
              },
              onCancel: () {
                controller.paginatedStaffs.value.results[index].isEditMode
                    .value = false;
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 10,
                  child: AppText(
                    controller.paginatedStaffs.value.results[index].name,
                    fontSize: 16,
                    overFlow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppIconButton(
                        assetIcon: AssetConstants.editIcon,
                        iconColor: AppColor.darkBlue,
                        isNoContainer: true,
                        onPressed: () {
                          controller.onEditStaffButtonTap(
                            controller.paginatedStaffs.value.results[index],
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      AppIconButton(
                        assetIcon: AssetConstants.trashIcon,
                        iconColor: AppColor.darkBlue,
                        isNoContainer: true,
                        onPressed: () {
                          controller.onDeleteStaffButtonTap(
                            controller.paginatedStaffs.value.results[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class SelectStaffDialogCtrl extends GetxController with StateMixin {
  final StaffService staffService = StaffService();

  final newStaffNameController = TextEditingController();
  final scrollController = ScrollController();

  RxBool loading = false.obs;
  RxBool isAddMode = false.obs;

  Rx<PaginationModel<StaffResponseModel>> paginatedStaffs =
      Rx<PaginationModel<StaffResponseModel>>(
    PaginationModel<StaffResponseModel>(
      results: [
        ...StaffResponseModel.getSkeletonList(),
      ],
      count: 0,
      next: null,
      previous: null,
    ),
  );

  Rx<StaffResponseModel?> selectedStaff = Rx<StaffResponseModel?>(null);

  @override
  void onInit() {
    getStaffs();
    super.onInit();
  }

  @override
  void onClose() {
    newStaffNameController.dispose();
    super.onClose();
  }

  Future<void> getStaffs({
    RefreshLoadingType refreshLoadingType = RefreshLoadingType.normal,
  }) async {
    try {
      loading.value = true;
      if (refreshLoadingType == RefreshLoadingType.normal) {
        paginatedStaffs.value = PaginationModel<StaffResponseModel>(
          results: [
            ...StaffResponseModel.getSkeletonList(),
          ],
          count: 0,
          next: null,
          previous: null,
        );
      }
      final request = staffService.getStaffs();
      await staffService.returnResponse(
        request,
        onSuccess: (response) {
          if (refreshLoadingType == RefreshLoadingType.normal) {
            paginatedStaffs.value =
                PaginationModel<StaffResponseModel>.fromJson(
              response,
              (json) => StaffResponseModel.fromJson(json),
            );
          } else {
            paginatedStaffs.value =
                PaginationModel.updatePaginationModel<StaffResponseModel>(
              paginatedStaffs.value,
              PaginationModel<StaffResponseModel>.fromJson(
                response,
                (json) => StaffResponseModel.fromJson(json),
              ),
            );
          }
          loading.value = false;
        },
        onUnsuccess: (errorResponseData) {
          loading.value = false;
          debugPrint("Get Staffs Error: $errorResponseData");
        },
      );
    } catch (e) {
      debugPrint("Get Staffs Error: $e");
    }
  }

  void onSelectedStaff(
    StaffResponseModel selectedStaff,
  ) {
    this.selectedStaff.value = selectedStaff;
  }

  void onCloseDialog(BuildContext context) {
    Navigator.of(context).pop();
    Get.delete<SelectStaffDialogCtrl>();
  }

  void onSaveselectedStaff(
    context, {
    required Function(StaffResponseModel customerService) onSelectedStaff,
  }) {
    if (selectedStaff.value == null) {
      showAppToastAlert(
        title: LocalizationKeys().staffPleaseSelectOneStaff,
        alertType: AlertType.error,
      );
      return;
    }
    onSelectedStaff(selectedStaff.value!);
    onCloseDialog(context);
  }

  void onAddStaffButtonTap() {
    selectedStaff.value = null;
    isAddMode.value = true;
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void onAddStaff() {
    isAddMode.value = false;
    newStaffNameController.clear();
  }

  void onEditStaffButtonTap(StaffResponseModel staff) {
    selectedStaff.value = null;
    staff.editNameController.text = staff.name;
    staff.isEditMode.value = true;
  }

  void onEditStaff(StaffResponseModel staff) {
    // TODO: CALL API
    staff.isEditMode.value = false;
  }

  void onDeleteStaffButtonTap(StaffResponseModel staff) {}

  int get staffListViewLength => isAddMode.value
      ? paginatedStaffs.value.results.length + 1
      : paginatedStaffs.value.results.length;
  bool isAddStaffRow(index) =>
      index == paginatedStaffs.value.results.length && isAddMode.value;
}
