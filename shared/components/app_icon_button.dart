import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/components/app_svg_icon.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final Color iconColor;
  final double size;
  final VoidCallback? onPressed;
  final double padding;
  final double borderRadius;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final bool isNoContainer;

  const AppIconButton({
    super.key,
    this.icon,
    this.assetIcon,
    this.iconColor = AppColor.primaryTextColor,
    this.size = 24,
    this.onPressed,
    this.padding = 6,
    this.borderRadius = 99,
    this.backgroundColor = AppColor.primaryWhite,
    this.boxShadow,
    this.isNoContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: isNoContainer
          ? iconWidget(
              iconColor: iconColor,
              size: size,
              icon: icon,
              assetIcon: assetIcon,
            )
          : Container(
              decoration: BoxDecoration(
                color: onPressed != null
                    ? backgroundColor
                    : AppColor.extraLightGrey,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: boxShadow,
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: iconWidget(
                  iconColor: iconColor,
                  size: size,
                  icon: icon,
                  assetIcon: assetIcon,
                ),
              ),
            ),
    );
  }
}

Widget iconWidget({
  IconData? icon,
  String? assetIcon,
  required Color iconColor,
  required double size,
}) {
  // assert that only one of icon or assetIcon is provided
  assert(icon != null || assetIcon != null);
  return icon != null
      ? Icon(
          icon,
          color: iconColor,
          size: size,
        )
      : AppSvgIcon(
          svgAsset: assetIcon!,
          size: size,
          iconColor: iconColor,
        );
}
