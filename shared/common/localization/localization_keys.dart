import 'package:easy_localization/easy_localization.dart';

class LocalizationKeys {
  LocalizationKeys.init();
  static final LocalizationKeys _instance = LocalizationKeys.init();

  factory LocalizationKeys() {
    // if (local != UserConfig.locale.languageCode) {
    //   local = UserConfig.locale.languageCode;
    //   _instance = LocalizationKeys.init();
    // }

    return _instance;
  }

  // format:
  // variable name: module + text variable
  // variable value: 'module.text-variable'.tr()
  String commonCancel = 'COMMON.CANCEL'.tr();
  String commonCreate = 'COMMON.CREATE'.tr();
  String commonSave = 'COMMON.SAVE'.tr();
  String commonDone = 'COMMON.DONE'.tr();
  String commonDownload = 'COMMON.DOWNLOAD'.tr();
  String commonNoResults = 'COMMON.NO-RESULTS'.tr();
  String commonCreatedSuccessfully = 'COMMON.CREATED-SUCCESSFULLY'.tr();
  String commonSavedSuccessfully = 'COMMON.SAVED-SUCCESSFULLY'.tr();
  String commonConfirm = 'COMMON.CONFIRM'.tr();
  String commonWarning = 'COMMON.WARNING'.tr();
  String commonError = 'COMMON.ERROR'.tr();
  String commonRemarks = 'COMMON.REMARKS'.tr();
  String commonAddRemarks = 'COMMON.ADD-REMARKS'.tr();
  String commonInvalidDate = 'COMMON.INVALID-DATE'.tr();
  String commonThb = 'COMMON.THB'.tr();
  String commonPercent = 'COMMON.PERCENT'.tr();
  String commonCamera = 'CUSTOMER.CAMERA'.tr();
  String commonTakePhoto = 'COMMON.TAKE-PHOTO'.tr();
  String commonTakeVideo = 'COMMON.TAKE-VIDEO'.tr();
  String commonGallery = 'COMMON.GALLERY'.tr();
  String commonFile = 'COMMON.FILE'.tr();
  String commonSend = 'COMMON.SEND'.tr();
  String commonSentAnImage = 'COMMON.SENT-AN-IMAGE'.tr();
  String commonSentAVideo = 'COMMON.SENT-A-VIDEO'.tr();
  String commonSentAFile = 'COMMON.SENT-A-FILE'.tr();
  String commonAgreeTCandPrivacyPolicy =
      'COMMON.AGREE-TC-AND-PRIVACY-POLICY'.tr();
  String commonCustomerSignature = 'COMMON.CUSTOMER-SIGNATURE'.tr();
  String commonNoPhotoSelected = 'COMMON.NO-PHOTO-SELECTED'.tr();

  String customerScreenTitle = 'CUSTOMER.SCREEN-TITLE'.tr();
  String searchScreenTitle = 'SEARCH.SCREEN-TITLE'.tr();
  String settingsScreenTitle = 'SETTINGS.SCREEN-TITLE'.tr();

  String customerNewCustomer = 'CUSTOMER.NEW-CUSTOMER'.tr();
  String customerSearchCustomerOrLicense =
      'CUSTOMER.SEARCH-CUSTOMER-OR-LICENSE'.tr();
  String customerWithLine = 'CUSTOMER.WITH-LINE'.tr();
  String customerNoLine = 'CUSTOMER.NO-LINE'.tr();
  String customerSearchMessages = 'CUSTOMER.SEARCH-MESSAGES'.tr();
  String customerCustomerInformation = 'CUSTOMER.CUSTOMER-INFORMATION'.tr();
  String customerFirstName = 'CUSTOMER.FIRST-NAME'.tr();
  String customerLastName = 'CUSTOMER.LAST-NAME'.tr();
  String customerPhone = 'CUSTOMER.PHONE'.tr();
  String customerFirstNameRequired = 'CUSTOMER.FIRST-NAME-REQUIRED'.tr();
  String customerLastNameRequired = 'CUSTOMER.LAST-NAME-REQUIRED'.tr();
  String customerPhoneRequired = 'CUSTOMER.PHONE-REQUIRED'.tr();
  String customerFirstNameInvalid = 'CUSTOMER.FIRST-NAME-INVALID'.tr();
  String customerLastNameInvalid = 'CUSTOMER.LAST-NAME-INVALID'.tr();
  String customerPhoneInvalid = 'CUSTOMER.PHONE-INVALID'.tr();
  String customerAddress = 'CUSTOMER.ADDRESS'.tr();
  String customerDistrict = 'CUSTOMER.DISTRICT'.tr();
  String customerProvince = 'CUSTOMER.PROVINCE'.tr();
  String customerSubDistrict = 'CUSTOMER.SUB-DISTRICT'.tr();
  String customerOthers = 'CUSTOMER.OTHERS'.tr();
  String customerHouseNumber = 'CUSTOMER.HOUSE-NUMBER'.tr();
  String customerTaxId = 'CUSTOMER.TAX-ID'.tr();
  String customerTaxIdInvalid = 'CUSTOMER.TAX-ID-INVALID'.tr();
  String customerCarInformation = 'CUSTOMER.CAR-INFORMATION'.tr();
  String customerNoCarInformation = 'CUSTOMER.NO-CAR-INFORMATION'.tr();
  String customerTypeAMessage = 'CUSTOMER.TYPE-A-MESSAGE'.tr();

  String licensePlateLicensePlateInformation =
      'LICENSE-PLATE.LICENSE-PLATE-INFORMATION'.tr();
  String licensePlateCarInformation = 'LICENSE-PLATE.CAR-INFORMATION'.tr();
  String licensePlateColor = 'LICENSE-PLATE.COLOR'.tr();
  String licensePlateCarLicense = 'LICENSE-PLATE.CAR-LICENSE'.tr();
  String licensePlateBrand = 'LICENSE-PLATE.BRAND'.tr();
  String licensePlateModel = 'LICENSE-PLATE.MODEL'.tr();
  String licensePlateModelYear = 'LICENSE-PLATE.MODEL-YEAR'.tr();
  String licensePlateCarType = 'LICENSE-PLATE.CAR-TYPE'.tr();
  String licensePlateCarFuel = 'LICENSE-PLATE.CAR-FUEL'.tr();
  String licensePlateVIN = 'LICENSE-PLATE.VIN'.tr();
  String licensePlateFrontTire = 'LICENSE-PLATE.FRONT-TIRE'.tr();
  String licensePlateRearTire = 'LICENSE-PLATE.REAR-TIRE'.tr();
  String licensePlateSize = 'LICENSE-PLATE.SIZE'.tr();
  String licensePlatePressure = 'LICENSE-PLATE.PRESSURE'.tr();
  String licensePlateDeleteConfirmation =
      'LICENSE-PLATE.DELETE-CONFIRMATION'.tr();
  String licensePlateSelectCar = 'LICENSE-PLATE.SELECT-CAR'.tr();
  String licensePlatePleaseSelectOneCar =
      'LICENSE-PLATE.PLEASE-SELECT-ONE-CAR'.tr();

  String staffCustomerService = 'STAFF.CUSTOMER-SERVICE'.tr();
  String staffSelectCustomerService = 'STAFF.SELECT-CUSTOMER-SERVICE'.tr();
  String staffAddStaff = 'STAFF.ADD-STAFF'.tr();
  String staffPleaseSelectOneStaff = 'STAFF.PLEASE-SELECT-ONE-STAFF'.tr();

  String orderOrderCreation = 'ORDER.ORDER-CREATION'.tr();
  String orderCreateOrder = 'ORDER.CREATE-ORDER'.tr();
  String orderQueue = 'ORDER.QUEUE'.tr();
  String orderCustomerAndCarInformation =
      'ORDER.CUSTOMER-AND-CAR-INFORMATION'.tr();
  String orderCustomerService = 'ORDER.CUSTOMER-SERVICE'.tr();
  String orderMechanic = 'ORDER.MECHANIC'.tr();
  String orderInspector = 'ORDER.INSPECTOR'.tr();
  String orderAppointment = 'ORDER.APPOINTMENT'.tr();
  String orderAppointmentDropOff = 'ORDER.APPOINTMENT-DROP-OFF'.tr();
  String orderAppointmentPickUp = 'ORDER.APPOINTMENT-PICK-UP'.tr();
  String orderSelectAppointmentDropOff =
      'ORDER.SELECT-APPOINTMENT-DROP-OFF'.tr();
  String orderSelectAppointmentPickUp = 'ORDER.SELECT-APPOINTMENT-PICK-UP'.tr();
  String orderPaymentMethod = 'ORDER.PAYMENT-METHOD'.tr();
  String orderPaymentMethodCash = 'ORDER.PAYMENT-METHOD-CASH'.tr();
  String orderPaymentMethodCreditDebitCard =
      'ORDER.PAYMENT-METHOD-CREDIT-DEBIT-CARD'.tr();
  String orderPaymentMethodPromptPay = 'ORDER.PAYMENT-METHOD-PROMPT-PAY'.tr();
  String orderPaymentMethodOthers = 'ORDER.PAYMENT-METHOD-OTHERS'.tr();
  String orderOrderDetails = 'ORDER.ORDER-DETAILS'.tr();
  String orderOrderDetailsNo = 'ORDER.ORDER-DETAILS-NO'.tr();
  String orderOrderDetailsName = 'ORDER.ORDER-DETAILS-NAME'.tr();
  String orderOrderDetailsServiceType = 'ORDER.ORDER-DETAILS-SERVICE-TYPE'.tr();
  String orderOrderDetailsQuantity = 'ORDER.ORDER-DETAILS-QUANTITY'.tr();
  String orderOrderDetailsPrice = 'ORDER.ORDER-DETAILS-PRICE'.tr();
  String orderOrderDetailsDiscount = 'ORDER.ORDER-DETAILS-DISCOUNT'.tr();
  String orderOrderDetailsTotal = 'ORDER.ORDER-DETAILS-TOTAL'.tr();
  String orderOrderAddItem = 'ORDER.ADD-ITEM'.tr();
  String orderDiscount = 'ORDER.DISCOUNT'.tr();
  String orderDiscountPrice = 'ORDER.DISCOUNT-PRICE'.tr();
  String orderNormalPrice = 'ORDER.NORMAL-PRICE'.tr();
  String orderReducedPrice = 'ORDER.REDUCED-PRICE'.tr();
  String orderEnterDiscountPrice = 'ORDER.ENTER-DISCOUNT-PRICE'.tr();
  String orderPreInspection = 'ORDER.PRE-INSPECTION'.tr();
  String orderCarCondition = 'ORDER.CAR-CONDITION'.tr();
  String orderWheelCover = 'ORDER.WHEEL-COVER'.tr();
  String orderSpareTire = 'ORDER.SPARE-TIRE'.tr();
  String orderCurrentMileage = 'ORDER.CURRENT-MILEAGE'.tr();
  String orderNextOilServiceMileage = 'ORDER.NEXT-OIL-SERVICE-MILEAGE'.tr();
  String orderFuelLevel = 'ORDER.FUEL-LEVEL'.tr();
  String orderWarningLight = 'ORDER.WARNING-LIGHT'.tr();
  String orderCarInspectionConsent = 'ORDER.CAR-INSPECTION-CONSENT'.tr();
  String orderSkipSafetyCheck = 'ORDER.SKIP-SAFETY-CHECK'.tr();
  String orderConsentForm = 'ORDER.CONSENT-FORM'.tr();
  String orderCarConditionBad = 'ORDER.CAR-CONDITION-BAD'.tr();
  String orderCarConditionNormal = 'ORDER.CAR-CONDITION-NORMAL'.tr();
  String orderCarConditionGood = 'ORDER.CAR-CONDITION-GOOD'.tr();
  String preInspectionPurposeOfInspectionTitle =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.PURPOSE-OF-INSPECTION.TITLE'
          .tr();
  String preInspectionPurposeOfInspectionDescription =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.PURPOSE-OF-INSPECTION.DESCRIPTION'
          .tr();
  String preInspectionScopeOfInspectionTitle =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.SCOPE-OF-INSPECTION.TITLE'
          .tr();
  String preInspectionScopeOfInspectionPointOne =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.SCOPE-OF-INSPECTION.POINT-ONE'
          .tr();
  String preInspectionScopeOfInspectionPointTwo =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.SCOPE-OF-INSPECTION.POINT-TWO'
          .tr();
  String preInspectionScopeOfInspectionPointThree =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.SCOPE-OF-INSPECTION.POINT-THREE'
          .tr();
  String preInspectionScopeOfInspectionPointFour =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.SCOPE-OF-INSPECTION.POINT-FOUR'
          .tr();
  String preInspectionConsentAndAuthorizationTitle =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.CONSENT-AND-AUTHORIZATION.TITLE'
          .tr();
  String preInspectionConsentAndAuthorizationDescription =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.CONSENT-AND-AUTHORIZATION.DESCRIPTION'
          .tr();
  String preInspectionAgreementTitle =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.AGREEMENT.TITLE'.tr();
  String preInspectionAgreementDescription =
      'ORDER.CONSENT-FORM-DETAILS.PRE-INSPECTION.AGREEMENT.DESCRIPTION'.tr();
}
