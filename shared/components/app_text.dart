import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow? overFlow;
  final Color? color;
  final List<Shadow>? shadows;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final bool? softWrap;
  final double? height;
  const AppText(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16,
    this.overFlow,
    this.color,
    this.shadows,
    this.textAlign,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.softWrap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme.primaryTextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColor.primaryTextColor,
        shadows: shadows,
        decoration: decoration,
        height: height,
      ),
      overflow: overFlow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
