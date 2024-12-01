import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';

Future<void> showConfirmationDialog(
  BuildContext context, {
  required Function onConfirm,
  required String title,
  String? description,
  IconData? icon,
  Color? iconColor,
}) async {
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
            child: ConfirmationDialog(
              onConfirm: onConfirm,
              title: title,
              description: description,
              icon: icon,
              iconColor: iconColor,
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

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    this.description,
    this.icon,
    this.iconColor,
  });

  final Function onConfirm;
  final String title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 48),
      width: context.contextWidth() * 0.5,
      height: context.contextHeight() * 0.4,
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 56,
                  color: iconColor ?? AppColor.primaryTextColor,
                ),
              const SizedBox(height: 24),
              AppText(
                title,
                textAlign: TextAlign.center,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              if (description != null)
                AppText(
                  description!,
                  textAlign: TextAlign.center,
                ),
            ],
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
                    Navigator.of(context).pop();
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
                  onPressed: () async {
                    await onConfirm();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
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
