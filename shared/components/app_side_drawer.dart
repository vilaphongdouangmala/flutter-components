import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/extensions/context_extension.dart';

class AppRightSideDrawer extends StatelessWidget {
  final bool isVisible;
  final Widget drawerContent;
  final double drawerWidth;
  final VoidCallback onClose;

  const AppRightSideDrawer({
    super.key,
    required this.isVisible,
    required this.drawerContent,
    required this.onClose,
    this.drawerWidth = 300,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      right: isVisible ? 0 : -drawerWidth,
      top: 0,
      bottom: 0,
      child: Container(
        width: drawerWidth,
        height: context.contextHeight(),
        padding: EdgeInsets.symmetric(
          vertical: context.contextHeight() * 0.03,
        ),
        decoration: const BoxDecoration(
          color: AppColor.primaryWhite,
          boxShadow: [
            BoxShadow(
              color: AppColor.darkGrey,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.primaryWhite,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onClose,
                    child: Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: const BoxDecoration(
                        color: AppColor.primaryWhite,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.darkGrey,
                            blurRadius: 5.0,
                            offset: Offset(0, 1),
                          ),
                          BoxShadow(
                            color: AppColor.darkGrey,
                            blurRadius: 5.0,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.keyboard_double_arrow_right_rounded,
                        color: AppColor.extraDarkGrey,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.contextHeight() * 0.02,
            ),
            Expanded(
              child: drawerContent,
            ),
          ],
        ),
      ),
    );
  }
}
