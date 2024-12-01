import 'dart:ui';

import 'package:monthol_mobile/shared/configs/theme_configs.dart';

enum AlertType {
  success,
  error,
  warning,
  info,
}

extension AlertTypeExtension on AlertType {
  Color get color {
    switch (this) {
      case AlertType.success:
        return AppColor.darkGreen;
      case AlertType.error:
        return AppColor.primaryRed;
      case AlertType.warning:
        return AppColor.primaryYellow;
      case AlertType.info:
        return AppColor.ceruleanBlue;
    }
  }
}
