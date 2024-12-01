import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';

class AppOrderSectionContainer extends StatelessWidget {
  const AppOrderSectionContainer({
    super.key,
    required this.title,
    required this.child,
    this.width = double.infinity,
    this.childPadding = const EdgeInsets.symmetric(
      horizontal: 32,
      vertical: 16,
    ),
  });

  final String title;
  final Widget child;
  final double width;
  final EdgeInsetsGeometry? childPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.contextWidth(),
      decoration: BoxDecoration(
        color: AppColor.primaryGrey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryBlack.withOpacity(0.25),
            offset: const Offset(1, 1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Container(
            padding: childPadding,
            width: context.contextWidth(),
            decoration: const BoxDecoration(
              color: AppColor.primaryWhite,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
