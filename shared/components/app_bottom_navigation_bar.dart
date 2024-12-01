import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/features/main/controllers/main_screen_ctrl.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:monthol_mobile/shared/router/app_router.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Platform.isAndroid
          ? kBottomNavigationBarHeight
          : kBottomNavigationBarHeight + 36,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          final MainScreenCtrl mainScreenCtrl = Get.find();
          mainScreenCtrl.changeTabIndex(
            value,
            context: context,
          );
        },
        backgroundColor: AppColor.primaryGrey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: AppRouter.mainBottomNavigationBarRoutes.map(
          (route) {
            return BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    route.icon,
                    color: AppColor.primaryTextColor,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  AppText(
                    route.localizedName,
                    fontWeight: currentIndex == route.key
                        ? FontWeight.bold
                        : FontWeight.normal,
                  )
                ],
              ),
              label: '',
            );
          },
        ).toList(),
      ),
    );
  }
}
