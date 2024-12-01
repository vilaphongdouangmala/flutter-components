import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/features/customer/controllers/customer_screen_ctrl.dart';
import 'package:monthol_mobile/shared/common/constants/common_constants.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_dropdown.dart';
import 'package:monthol_mobile/shared/components/app_input.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/components/app_toastification.dart';
import 'package:monthol_mobile/shared/components/dialogs/add_edit_license_plate_dialog.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/configs/user_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:monthol_mobile/shared/models/address_model.dart';
import 'package:monthol_mobile/shared/models/common_model.dart';
import 'package:monthol_mobile/shared/models/customer_model.dart';
import 'package:monthol_mobile/shared/services/remote/address_service.dart';
import 'package:monthol_mobile/shared/services/remote/customer_service.dart';

Future<void> showAddEditCustomerDialog(
  BuildContext context, {
  CustomerResponseModel? customer,
}) async {
  final AddEditCustomerDialogCtrl controller =
      Get.put(AddEditCustomerDialogCtrl(customer: customer));
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
            child: AddEditCustomerDialogLayout(
              customer: customer,
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

class AddEditCustomerDialogLayout extends StatelessWidget {
  const AddEditCustomerDialogLayout({
    super.key,
    this.customer,
    required this.controller,
  });

  final CustomerResponseModel? customer;
  final AddEditCustomerDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      width: context.contextWidth() * 0.5,
      height: context.contextHeight() * 0.8,
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AddEditCustomerDialogHeader(),
          SizedBox(height: context.contextHeight() * 0.05),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddEditCustomerDialogForm(
                    controller: controller,
                  ),
                  SizedBox(height: context.contextHeight() * 0.03),
                  AddEditCustomerDialogActions(
                    controller: controller,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddEditCustomerDialogHeader extends StatelessWidget {
  const AddEditCustomerDialogHeader({
    super.key,
  });

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
                LocalizationKeys().customerCustomerInformation,
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

class AddEditCustomerDialogForm extends StatelessWidget {
  const AddEditCustomerDialogForm({
    super.key,
    required this.controller,
  });

  final AddEditCustomerDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().customerFirstName,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => AppInput(
                          controller: controller.firstNameController,
                          borderRadius: controller.inputBorderRadius,
                          textBoxHeight: 40,
                          validate: controller.firstNameError.value.isEmpty,
                          validationText: controller.firstNameError.value,
                          focusNode: controller.firstNameFocusNode,
                          onTapOutside: () {
                            controller.validateFirstName();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().customerLastName,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => AppInput(
                          controller: controller.lastNameController,
                          borderRadius: controller.inputBorderRadius,
                          textBoxHeight: 40,
                          validate: controller.lastNameError.value.isEmpty,
                          validationText: controller.lastNameError.value,
                          focusNode: controller.lastNameFocusNode,
                          onTapOutside: () {
                            controller.validateLastName();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.contextHeight() * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().customerPhone,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => AppInput(
                          controller: controller.mobilePhoneController,
                          borderRadius: controller.inputBorderRadius,
                          textBoxHeight: 40,
                          validate: controller.mobilePhoneError.value.isEmpty,
                          validationText: controller.mobilePhoneError.value,
                          focusNode: controller.mobilePhoneFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onTapOutside: () {
                            controller.validateMobilePhone();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().customerTaxId,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => AppInput(
                          controller: controller.taxIdController,
                          borderRadius: controller.inputBorderRadius,
                          textBoxHeight: 40,
                          validate: controller.taxIdError.value.isEmpty,
                          validationText: controller.taxIdError.value,
                          focusNode: controller.taxIdFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onTapOutside: () {
                            controller.validateTaxId();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.contextHeight() * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        LocalizationKeys().customerAddress,
                        fontWeight: FontWeight.w600,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AppText(
                                    LocalizationKeys().customerProvince,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AppDropdown<ProvinceResponseModel>(
                                    value: controller.selectedProvince.value,
                                    items: (filter, loadProps) {
                                      return controller
                                          .paginatedProvinces.value.results
                                          .map((item) => item)
                                          .toList();
                                    },
                                    itemLabel: (itemLabel) {
                                      return itemLabel.nameEn;
                                    },
                                    onChanged: (value) {
                                      controller.selectedProvince.value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.contextHeight() * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AppText(
                                    LocalizationKeys().customerDistrict,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AppInput(
                                    controller: controller.districtController,
                                    borderRadius: controller.inputBorderRadius,
                                    textBoxHeight: 40,
                                    hintText:
                                        LocalizationKeys().customerDistrict,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.contextHeight() * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AppText(
                                    LocalizationKeys().customerSubDistrict,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AppInput(
                                    controller:
                                        controller.subDistrictController,
                                    borderRadius: controller.inputBorderRadius,
                                    textBoxHeight: 40,
                                    hintText:
                                        LocalizationKeys().customerSubDistrict,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.contextHeight() * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: AppText(
                                    LocalizationKeys().customerOthers,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AppInput(
                                    controller: controller.othersController,
                                    borderRadius: controller.inputBorderRadius,
                                    textBoxHeight: 40,
                                    hintText:
                                        LocalizationKeys().customerHouseNumber,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.contextHeight() * 0.015,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddEditCustomerDialogActions extends StatelessWidget {
  const AddEditCustomerDialogActions({
    super.key,
    required this.controller,
  });

  final AddEditCustomerDialogCtrl controller;

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

class AddEditCustomerDialogCtrl extends GetxController with StateMixin {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  final taxIdController = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final subDistrictController = TextEditingController();
  final othersController = TextEditingController();

  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString mobilePhoneError = ''.obs;
  RxString taxIdError = ''.obs;

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode mobilePhoneFocusNode = FocusNode();
  final FocusNode taxIdFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final double inputBorderRadius = 5;
  RxBool loading = false.obs;

  final CustomerResponseModel? customer;
  final CustomerService customerService = CustomerService();
  final AddressService addressService = AddressService();

  Rx<PaginationModel<ProvinceResponseModel>> paginatedProvinces =
      PaginationModel<ProvinceResponseModel>(
    results: [],
    count: 0,
    next: null,
    previous: null,
  ).obs;
  Rx<ProvinceResponseModel?> selectedProvince =
      Rx<ProvinceResponseModel?>(null);
  RxBool provincesLoading = false.obs;

  AddEditCustomerDialogCtrl({
    required this.customer,
  });

  @override
  void onInit() {
    initForm();
    getProvinces();
    super.onInit();
  }

  Future<void> getProvinces() async {
    try {
      provincesLoading.value = true;
      final request = addressService.getProvinces();
      await addressService.returnResponse(
        request,
        onSuccess: (res) {
          final PaginationModel<ProvinceResponseModel> fetchedProvinces =
              PaginationModel<ProvinceResponseModel>.fromJson(
            res,
            (json) => ProvinceResponseModel.fromJson(json),
          );
          paginatedProvinces.value =
              PaginationModel.updatePaginationModel<ProvinceResponseModel>(
            paginatedProvinces.value,
            fetchedProvinces,
          );
          provincesLoading.value = false;
        },
        onUnsuccess: (errorResponseData) {
          debugPrint('Error: $errorResponseData');
          provincesLoading.value = false;
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
      provincesLoading.value = false;
    }
  }

  void initForm() {
    if (customer != null) {
      firstNameController.text = customer!.firstName;
      lastNameController.text = customer!.lastName;
      mobilePhoneController.text = customer!.mobilePhoneNumber ?? '';
      taxIdController.text = customer!.taxId ?? '';
      provinceController.text = customer!.address?.province ?? '';
      districtController.text = customer!.address?.district ?? '';
      subDistrictController.text = customer!.address?.subDistrict ?? '';
      othersController.text = customer!.address?.addressLine ?? '';
    }
  }

  void validateFirstName() {
    if (firstNameController.text.isEmpty) {
      firstNameError.value = LocalizationKeys().customerFirstNameRequired;
      return;
    }
    firstNameError.value = '';
  }

  void validateLastName() {
    if (lastNameController.text.isEmpty) {
      lastNameError.value = LocalizationKeys().customerLastNameRequired;
    }
    lastNameError.value = '';
  }

  void validateMobilePhone() {
    if (mobilePhoneController.text.isEmpty) {
      mobilePhoneError.value = LocalizationKeys().customerPhoneRequired;
      return;
    }

    if (mobilePhoneController.text.length != 10 ||
        !mobilePhoneController.text.isNumericOnly) {
      mobilePhoneError.value = LocalizationKeys().customerPhoneInvalid;
      return;
    }
    mobilePhoneError.value = '';
  }

  void validateTaxId() {
    if (!taxIdController.text.isNumericOnly ||
        (taxIdController.text.length != 13 &&
            taxIdController.text.length != 18)) {
      taxIdError.value = LocalizationKeys().customerTaxIdInvalid;
    } else {
      taxIdError.value = '';
    }
  }

  Future<bool> validateForm() async {
    validateFirstName();
    validateLastName();
    validateMobilePhone();
    validateTaxId();
    await Future.delayed(CommonConstants.commonValidationWaitTime);
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> onSubmit(BuildContext context) async {
    if (!await validateForm()) return;
    if (context.mounted) {
      if (isEditMode) {
        await onUpdateCustomer(context);
      } else {
        await onCreateCustomer(context);
      }
    }
  }

  Future<void> onCreateCustomer(
    BuildContext context,
  ) async {
    try {
      loading.value = true;
      final CreateEditCustomerModel createEditCustomerModel =
          getCustomerModelFromForm();
      // call the API to create a new customer
      final request = customerService.createCustomer(createEditCustomerModel);
      await customerService.returnResponse(
        request,
        onSuccess: (json) async {
          loading.value = false;
          // get the customer details
          final CustomerResponseModel createdCustomer =
              CustomerResponseModel.fromJson(json);
          await reloadCustomerDetailsAndMessages(createdCustomer.id);
          showAppToastAlert(
            title: LocalizationKeys().commonCreatedSuccessfully,
            alertType: AlertType.success,
          );
          if (context.mounted) {
            onCloseDialog(context);
            // show the license plate create dialog on success
            showAddEditLicensePlateDialog(context);
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

  Future<void> onUpdateCustomer(
    BuildContext context,
  ) async {
    try {
      if (customer == null) return;
      loading.value = true;
      final CreateEditCustomerModel createEditCustomerModel =
          getCustomerModelFromForm();
      // call the API to create a new customer
      final request = customerService.updateCustomer(createEditCustomerModel);
      await customerService.returnResponse(
        request,
        onSuccess: (json) async {
          await reloadCustomerDetails(customer!.id);
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

  CreateEditCustomerModel getCustomerModelFromForm() {
    return CreateEditCustomerModel(
      id: customer?.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobilePhoneNumber: mobilePhoneController.text,
      taxId: taxIdController.text,
      address: BaseCustomerAddressModel(
        addressLine: othersController.text,
        district: districtController.text,
        province: provinceController.text,
        subDistrict: subDistrictController.text,
      ),
      dealer: UserConfigs.session!.user.dealer,
    );
  }

  void onCloseDialog(BuildContext context) {
    Navigator.of(context).pop();
    Get.delete<AddEditCustomerDialogCtrl>();
  }

  Future<void> reloadCustomerDetails(int selectedCustomerId) async {
    if (Get.isRegistered<CustomerScreenCtrl>()) {
      await Get.find<CustomerScreenCtrl>().getCustomerDetails(
        selectedCustomerId,
      );
    }
  }

  Future<void> reloadCustomerDetailsAndMessages(int selectedCustomerId) async {
    if (Get.isRegistered<CustomerScreenCtrl>()) {
      await Get.find<CustomerScreenCtrl>().getCustomerDetailsAndMessages(
        selectedCustomerId,
      );
    }
  }

  get isEditMode => customer != null;
}
