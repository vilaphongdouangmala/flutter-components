import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = AppColor.brightGreen,
    this.size = 28,
    this.borderColor = AppColor.primaryBlack,
    this.checkColor = AppColor.primaryWhite,
    this.borderWidth = 0.5,
  });

  final bool value;
  final Function(bool value) onChanged;
  final Color activeColor;
  final double size;
  final Color borderColor;
  final Color checkColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        padding: EdgeInsets.all(size * 0.05),
        decoration: BoxDecoration(
          border: !value
              ? Border.all(
                  color: borderColor,
                  width: borderWidth,
                )
              : null,
          borderRadius: BorderRadius.circular(4),
          color: value ? activeColor : Colors.transparent,
        ),
        child: value
            ? Icon(
                Icons.check_rounded,
                size: size * 0.8,
                color: checkColor,
                fill: 1,
                weight: 10,
              )
            : null,
      ),
    );
  }
}
