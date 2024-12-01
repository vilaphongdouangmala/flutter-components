import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppLoading extends StatelessWidget {
  final Color loadingColor;
  final bool isOverlay;
  final double strokeWidth;
  const AppLoading({
    super.key,
    this.loadingColor = AppColor.lightGreyTextColor,
    this.isOverlay = false,
    this.strokeWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return isOverlay
        ? Stack(
            children: [
              const Opacity(
                opacity: 1,
                child: ModalBarrier(
                    dismissible: false, color: Color.fromARGB(88, 0, 0, 0)),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: loadingColor,
                  strokeWidth: strokeWidth,
                ),
              ),
            ],
          )
        : CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: strokeWidth,
          );
  }
}
