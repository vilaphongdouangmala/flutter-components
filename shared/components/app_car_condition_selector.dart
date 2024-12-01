import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/enums/order_enum.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppCarConditionSelector extends StatelessWidget {
  const AppCarConditionSelector({
    super.key,
    required this.onConditionSelected,
    required this.value,
  });

  final Function(InspectionCondition selectedCondition) onConditionSelected;
  final InspectionCondition? value;

  Widget _buildConditionButton({
    required InspectionCondition condition,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: condition == value
              ? condition.backgroundColor
              : AppColor.extraLightGrey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Icon(
          condition.icon,
          color: condition == value
              ? condition.iconColor
              : AppColor.primaryTextColor,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildConditionButton(
          condition: InspectionCondition.good,
          onTap: () => onConditionSelected(InspectionCondition.good),
        ),
        const SizedBox(width: 8),
        _buildConditionButton(
          condition: InspectionCondition.normal,
          onTap: () => onConditionSelected(InspectionCondition.normal),
        ),
        const SizedBox(width: 8),
        _buildConditionButton(
          condition: InspectionCondition.bad,
          onTap: () => onConditionSelected(InspectionCondition.bad),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
