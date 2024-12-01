import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/enums/alert_enums.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:toastification/toastification.dart';

void showAppToastAlert({
  required String title,
  AlertType alertType = AlertType.info,
  bool showIcon = true,
  IconData? iconData,
  Duration duration = const Duration(seconds: 2),
}) {
  toastification.show(
    title: AppText(
      title,
      fontSize: 16,
    ),
    style: ToastificationStyle.minimal,
    icon: iconData == null
        ? Icon(
            Icons.info,
            color: alertType.color,
            size: 28,
          )
        : Icon(
            iconData,
            color: alertType.color,
            size: 28,
          ),
    primaryColor: alertType.color,
    autoCloseDuration: duration,
  );
}
