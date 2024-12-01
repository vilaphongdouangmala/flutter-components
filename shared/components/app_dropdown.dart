import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/components/app_loading.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final FutureOr<List<T>> Function(
    String filter,
    LoadProps? loadProps,
  )? items;
  final String Function(T label) itemLabel;
  final Function(T? value) onChanged;
  final String hintText;
  final Color dropdownColor;
  final bool isExpanded;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double verticalPadding;
  final double horizontalPadding;
  final double textFontSize;
  final Color textColor;
  final FontWeight textFontWeight;
  final double height;
  final bool isLoading;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hintText = '',
    this.dropdownColor = AppColor.primaryWhite,
    this.isExpanded = true,
    this.borderRadius = 5.0,
    this.borderColor = AppColor.extraLightGrey,
    this.borderWidth = 1.0,
    this.verticalPadding = 8.0,
    this.horizontalPadding = 16.0,
    this.textFontSize = 14.0,
    this.textColor = AppColor.primaryTextColor,
    this.textFontWeight = FontWeight.normal,
    this.height = 40,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: dropdownColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: height - 8,
                  width: height + 2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: const AppLoading(
                    strokeWidth: 2,
                  ),
                ),
              ],
            )
          : DropdownSearch<T>(
              compareFn: (item1, item2) {
                return item1 == item2;
              },
              selectedItem: value,
              items: items,
              suffixProps: const DropdownSuffixProps(
                dropdownButtonProps: DropdownButtonProps(
                  iconOpened: Icon(
                    Icons.keyboard_arrow_up_outlined,
                    color: AppColor.lightGreyTextColor,
                  ),
                  iconClosed: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColor.lightGreyTextColor,
                  ),
                ),
              ),
              itemAsString: itemLabel,
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: verticalPadding,
                    horizontal: horizontalPadding,
                  ),
                  border: InputBorder.none,
                  fillColor: AppColor.primaryWhite,
                  hintText: hintText,
                  hintStyle: AppTheme.primaryTextStyle(
                    color: textColor,
                    fontSize: textFontSize,
                    fontWeight: textFontWeight,
                  ),
                ),
                expands: true,
                baseStyle: AppTheme.primaryTextStyle(
                  color: textColor,
                  fontSize: textFontSize,
                  fontWeight: textFontWeight,
                ),
              ),
              popupProps: PopupProps.menu(
                menuProps: MenuProps(
                  color: AppColor.primaryWhite,
                  borderRadius: BorderRadius.circular(borderRadius),
                  backgroundColor: AppColor.primaryWhite,
                ),
                searchFieldProps: TextFieldProps(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  style: AppTheme.primaryTextStyle(
                    color: textColor,
                    fontSize: textFontSize + 2,
                    fontWeight: textFontWeight,
                  ),
                ),
                showSearchBox: true,
                fit: FlexFit.loose,
                constraints: const BoxConstraints(),
              ),
              onChanged: onChanged,
            ),
    );
  }
}
