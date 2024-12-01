import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String hintText;
  final double hintTextFontSize;
  final double? contentPadding;
  final int? maxLines;
  final Icon? icon;
  final Widget? surfixWidget;
  final Widget? prefixWidget;
  final Color backgroundColor;
  final bool enabled;
  final Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final bool isObsecure;
  final bool validate;
  final String? validationText;
  final List<TextInputFormatter> inputFormatters;
  final bool readonly;
  final bool tapOutsideUnfocus;
  final double? textBoxHeight;
  final Function()? onTap;
  final Function()? onTapOutside;
  final bool isOutlined;
  final double verticalPadding;
  final double horizontalPadding;
  final int? maxLength;
  final bool hasCounterText;
  final String? labelText;
  final bool autofocus;
  final List<BoxShadow>? boxShadow;
  final bool isUnderlined;
  final bool isAlignTop;
  final bool isNoBorders;
  final bool validationBoxShadow;
  final FocusNode? focusNode;
  final Color? titleColor;
  final double borderRadius;
  final double titlePaddingLeft;
  final EdgeInsets scrollPadding;
  final TextAlign textAlign;
  final double borderWidth;
  final Color hintTextColor;
  final Color readonlyBackgroundColor;
  final Color borderColor;

  const AppInput({
    super.key,
    this.hintText = "",
    required this.controller,
    this.title,
    this.icon,
    this.maxLines = 1,
    this.surfixWidget,
    this.prefixWidget,
    this.backgroundColor = AppColor.primaryWhite,
    this.enabled = true,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isObsecure = false,
    this.validate = true,
    this.validationText = '',
    this.inputFormatters = const <TextInputFormatter>[],
    this.readonly = false,
    this.tapOutsideUnfocus = true,
    this.textBoxHeight,
    this.onTap,
    this.onTapOutside,
    this.isOutlined = false,
    this.verticalPadding = 8,
    this.horizontalPadding = 16,
    this.maxLength,
    this.hasCounterText = false,
    this.labelText,
    this.hintTextFontSize = 14,
    this.contentPadding,
    this.autofocus = false,
    this.boxShadow,
    this.isUnderlined = false,
    this.isAlignTop = false,
    this.isNoBorders = false,
    this.validationBoxShadow = false,
    this.focusNode,
    this.titleColor,
    this.borderRadius = 14,
    this.titlePaddingLeft = 0,
    this.scrollPadding = const EdgeInsets.all(20),
    this.textAlign = TextAlign.start,
    this.borderWidth = 1,
    this.hintTextColor = AppColor.darkGrey,
    this.readonlyBackgroundColor = AppColor.lightGrey,
    this.borderColor = AppColor.lightGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: textBoxHeight,
          padding: EdgeInsets.symmetric(
            vertical: textBoxHeight == null
                ? verticalPadding
                : textBoxHeight! > 35
                    ? verticalPadding
                    : 0,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            border: (isOutlined || isNoBorders)
                ? isUnderlined
                    ? Border(
                        bottom: BorderSide(
                          color: borderColor,
                          width: borderWidth,
                        ),
                      )
                    : null
                : Border.all(
                    color: borderColor,
                    width: borderWidth,
                  ),
            borderRadius:
                isOutlined ? null : BorderRadius.circular(borderRadius),
            color: readonly ? readonlyBackgroundColor : backgroundColor,
            boxShadow: validationBoxShadow
                ? !validate
                    ? const [
                        BoxShadow(
                          color: AppColor.primaryGrey,
                          blurRadius: 30.0,
                          offset: Offset(0, 0), // Slight bottom shadow
                        ),
                      ]
                    : null
                : boxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isAlignTop
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              prefixWidget ?? const SizedBox(),
              Expanded(
                child: TextFormField(
                  scrollPadding: scrollPadding,
                  focusNode: focusNode,
                  autofocus: autofocus,
                  maxLength: maxLength,
                  textAlign: textAlign,
                  onTapOutside: tapOutsideUnfocus
                      ? (event) {
                          if (focusNode != null && focusNode!.hasPrimaryFocus) {
                            focusNode!.unfocus();
                            if (onTapOutside != null) {
                              onTapOutside!();
                            }
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  maxLines: maxLines,
                  obscureText: isObsecure,
                  controller: controller,
                  enabled: enabled,
                  readOnly: readonly,
                  validator: (value) {
                    if (value != null && !validate) {
                      return (validationText == null ? '' : validationText!);
                    }
                    return null;
                  },
                  buildCounter: !hasCounterText
                      ? (
                          BuildContext context, {
                          required int currentLength,
                          required int? maxLength,
                          required bool isFocused,
                        }) =>
                          null
                      : null,
                  decoration: InputDecoration(
                    errorMaxLines: 1,
                    errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    fillColor: AppColor.primaryWhite,
                    hintText: hintText,
                    contentPadding: contentPadding == null
                        ? null
                        : EdgeInsets.symmetric(horizontal: contentPadding!),
                    hintStyle: AppTheme.primaryTextStyle(
                      fontSize: hintTextFontSize,
                      color: hintTextColor,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                    icon: icon,
                    labelText: labelText,
                  ),
                  onChanged: (value) {
                    onChanged?.call(value);
                    onTapOutside?.call();
                  },
                  onTap: onTap,
                ),
              ),
              surfixWidget ?? const SizedBox()
            ],
          ),
        ),
        if (!validate && validationText != null && validationText!.isNotEmpty)
          AppText(
            validationText!,
            color: AppColor.primaryRed,
            fontSize: 12,
            textAlign: TextAlign.start,
          ),
      ],
    );
  }
}
