import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizer extends StatelessWidget {
  const AppSkeletonizer({
    super.key,
    required this.child,
    required this.enabled,
    this.justifyMultiLineText = false,
    this.textBoneBorderRadius,
  });
  final Widget child;
  final bool enabled;
  final bool justifyMultiLineText;
  final TextBoneBorderRadius? textBoneBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      justifyMultiLineText: justifyMultiLineText,
      textBoneBorderRadius: textBoneBorderRadius,
      effect: const ShimmerEffect(
        duration: Duration(
          milliseconds: 1500,
        ),
        baseColor: AppColor.lightGrey,
        highlightColor: AppColor.extraLightGrey,
      ),
      child: child,
    );
  }
}
