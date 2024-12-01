import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

enum PaymentMethod {
  cash,
  promptPay,
  creditDebitCard,
  others,
}

extension PaymentMethodExtension on PaymentMethod {
  String get title {
    switch (this) {
      case PaymentMethod.cash:
        return LocalizationKeys().orderPaymentMethodCash;
      case PaymentMethod.promptPay:
        return LocalizationKeys().orderPaymentMethodPromptPay;
      case PaymentMethod.creditDebitCard:
        return LocalizationKeys().orderPaymentMethodCreditDebitCard;
      case PaymentMethod.others:
        return LocalizationKeys().orderPaymentMethodOthers;
      default:
        return '';
    }
  }

  static PaymentMethod fromValue(int value) {
    switch (value) {
      case 0:
        return PaymentMethod.cash;
      case 1:
        return PaymentMethod.promptPay;
      case 2:
        return PaymentMethod.creditDebitCard;
      case 3:
        return PaymentMethod.others;
      default:
        return PaymentMethod.cash;
    }
  }
}

enum InspectionCondition {
  bad,
  normal,
  good,
}

extension InspectionConditionExtension on InspectionCondition {
  String get title {
    switch (this) {
      case InspectionCondition.bad:
        return LocalizationKeys().orderCarConditionBad;
      case InspectionCondition.normal:
        return LocalizationKeys().orderCarConditionNormal;
      case InspectionCondition.good:
        return LocalizationKeys().orderCarConditionGood;
      default:
        return '';
    }
  }

  static InspectionCondition fromValue(int value) {
    switch (value) {
      case 0:
        return InspectionCondition.bad;
      case 1:
        return InspectionCondition.normal;
      case 2:
        return InspectionCondition.good;
      default:
        throw Exception('Invalid value');
    }
  }

  IconData get icon {
    switch (this) {
      case InspectionCondition.bad:
        return Icons.cancel_outlined;
      case InspectionCondition.normal:
        return Icons.error_outline_rounded;
      case InspectionCondition.good:
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.close;
    }
  }

  Color get iconColor {
    switch (this) {
      case InspectionCondition.bad:
        return AppColor.brightRed;
      case InspectionCondition.normal:
        return AppColor.primaryYellow;
      case InspectionCondition.good:
        return AppColor.brightGreen;
      default:
        return AppColor.primaryTextColor;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case InspectionCondition.bad:
        return AppColor.lightRed;
      case InspectionCondition.normal:
        return AppColor.lightYellow;
      case InspectionCondition.good:
        return AppColor.primaryGreen;
      default:
        return AppColor.extraLightGrey;
    }
  }
}
