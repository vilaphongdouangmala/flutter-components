import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/shared/common/localization/localization_keys.dart';
import 'package:monthol_mobile/shared/components/app_button.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';
import 'package:signature/signature.dart';

Future<void> showSignatureDialog(
  BuildContext context, {
  required Function(Uint8List signatureBytes) onConfirm,
}) async {
  final SignatureDialogCtrl controller = Get.put(SignatureDialogCtrl());
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
            child: SignatureDialog(
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

class SignatureDialog extends StatelessWidget {
  const SignatureDialog({
    super.key,
    required this.onConfirm,
    required this.controller,
  });

  final Function(Uint8List signatureBytes) onConfirm;
  final SignatureDialogCtrl controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 48),
      width: context.contextWidth() * 0.8,
      height: context.contextHeight() * 0.7,
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
              AppText(
                LocalizationKeys().commonCustomerSignature,
                textAlign: TextAlign.center,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Signature(
              controller: controller.signatureController,
              width: context.contextWidth() * 0.6,
              backgroundColor: AppColor.primaryWhite,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(
            height: 1,
            color: AppColor.primaryTextColor,
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
                    if (controller.signatureController.isEmpty) return;
                    final Uint8List? signatureBytes =
                        await controller.signatureController.toPngBytes();

                    if (signatureBytes == null) return;
                    onConfirm(signatureBytes);

                    if (context.mounted) {
                      controller.onCloseDialog(context);
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

class SignatureDialogCtrl extends GetxController with StateMixin {
  final signatureController = SignatureController();

  void onCloseDialog(BuildContext context) {
    Get.delete<SignatureDialogCtrl>();
    Navigator.of(context).pop();
  }
}
