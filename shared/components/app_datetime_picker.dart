import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/utils/datetime_utils.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppDateTimePicker extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime selectedDate) onDateChanged;
  final DateTime? displayDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final double height;
  final double verticalPadding;
  final double horizontalPadding;
  final bool readonly;
  final bool isOutlined;
  final bool isUnderlined;
  final bool isNoBorders;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color textColor;
  final double textFontSize;
  final FontWeight textFontWeight;
  final bool disableTimePicker;
  final String hintText;
  final Color hintTextColor;
  final FontWeight hintFontWeight;

  const AppDateTimePicker({
    super.key,
    required this.onDateChanged,
    required this.displayDate,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.height = 40,
    this.verticalPadding = 8,
    this.horizontalPadding = 16,
    this.readonly = false,
    this.isOutlined = false,
    this.isUnderlined = false,
    this.isNoBorders = false,
    this.borderRadius = 5,
    this.borderWidth = 1,
    this.backgroundColor = AppColor.primaryWhite,
    this.textColor = AppColor.primaryTextColor,
    this.textFontSize = 14,
    this.textFontWeight = FontWeight.normal,
    this.disableTimePicker = false,
    this.hintText = '-',
    this.hintTextColor = AppColor.lightGrey,
    this.hintFontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    final AppDateTimePickerController controller = AppDateTimePickerController(
      onDateChanged: onDateChanged,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      disableTimePicker: disableTimePicker,
    );
    return Expanded(
      child: Container(
        height: height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          border: (isOutlined || isNoBorders)
              ? isUnderlined
                  ? Border(
                      bottom: BorderSide(
                        color: AppColor.lightGrey,
                        width: borderWidth,
                      ),
                    )
                  : null
              : Border.all(
                  color: AppColor.lightGrey,
                  width: borderWidth,
                ),
          borderRadius: isOutlined ? null : BorderRadius.circular(borderRadius),
          color: readonly ? AppColor.primaryGrey : backgroundColor,
        ),
        child: InkWell(
          onTap: readonly
              ? null
              : () async {
                  await controller.onDatePicked(context);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                displayDate != null
                    ? disableTimePicker
                        ? displayDate!.toShortDateString()
                        : displayDate!.toShortDateTimeString()
                    : hintText,
                color: readonly
                    ? AppColor.darkGrey
                    : displayDate != null
                        ? textColor
                        : hintTextColor,
                fontSize: textFontSize,
                fontWeight:
                    displayDate != null ? textFontWeight : hintFontWeight,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDateTimePickerController {
  final Function(DateTime selectedDate) onDateChanged;
  DateTime? initialDate;
  DateTime? firstDate;
  DateTime? lastDate;
  final bool disableTimePicker;

  AppDateTimePickerController({
    required this.onDateChanged,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.disableTimePicker,
  });

  Future<void> onDatePicked(
    BuildContext context,
  ) async {
    final pickedDate = await pickDate(context);
    if (pickedDate == null) return;

    if (disableTimePicker) {
      onDateChanged(pickedDate);
      return;
    }

    if (context.mounted) {
      final pickedTime = await pickTime(context);
      if (pickedTime == null) return;
      final DateTime dateTimePicked = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      onDateChanged(dateTimePicked);
    }
  }

  Future<DateTime?> pickDate(context) async => await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
      );

  Future<TimeOfDay?> pickTime(context) async => await showTimePicker(
        context: context,
        initialTime: initialDate != null
            ? TimeOfDay.fromDateTime(initialDate!)
            : TimeOfDay.now(),
      );
}
