import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final TextStyle textStyle;
  final double borderRadius;
  final bool isLoading;
  final Color loadingIndicatorColor;
  final EdgeInsets padding;
  final IconData? icon;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;

  AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
    this.backgroundColor = AppColor.primaryGreen,
    this.borderRadius = 10.0,
    this.isLoading = false,
    this.loadingIndicatorColor = AppColor.primaryGrey,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.icon,
    this.iconSize,
    TextStyle? textStyle,
  }) : textStyle = textStyle ?? AppTheme.primaryTextStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: onPressed != null ? backgroundColor : AppColor.lightGrey,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null ? boxShadow : null,
        border: borderColor == null || borderWidth == null
            ? null
            : Border.all(
                color: borderColor!,
                width: borderWidth!,
              ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors
              .transparent, // Use transparent to show the BoxDecoration color
          shadowColor: Colors.transparent, // Prevent default shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? CircularProgressIndicator(
                color: loadingIndicatorColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: iconSize ?? ((textStyle.fontSize ?? 16) + 8),
                      color: textStyle.color,
                    ),
                    const SizedBox(width: 8.0),
                  ],
                  AppText(
                    text,
                    color: onPressed != null
                        ? textStyle.color
                        : AppColor.primaryGrey,
                    fontSize: textStyle.fontSize ?? 16,
                    fontWeight: textStyle.fontWeight ?? FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  if (icon != null) const SizedBox(width: 8.0),
                ],
              ),
      ),
    );
  }
}
