import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monthol_mobile/shared/components/app_text.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AppSlider extends StatelessWidget {
  final AppSliderCtrl controller = Get.put(AppSliderCtrl());
  final double height;
  final double thumbRadius;
  final double value;
  final double max;
  final double min;
  final double stepSize;
  final Function(double value) onChanged;
  final Color thumbColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double trackHeight;
  final bool showTicks;
  final bool showLabels;

  AppSlider({
    super.key,
    required this.onChanged,
    required this.value,
    this.height = 70,
    this.thumbRadius = 10,
    this.max = 100,
    this.min = 0,
    required this.stepSize,
    this.thumbColor = AppColor.primaryWhite,
    this.activeTrackColor = AppColor.primaryTextColor,
    this.inactiveTrackColor = AppColor.primaryGrey,
    this.trackHeight = 2,
    this.showTicks = false,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showLabels)
          AppText(
            controller.minDiscountPercentage.round().toString(),
            fontWeight: FontWeight.w600,
          ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return SizedBox(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Positioned(
                      left: controller.getThumbPosition(
                        maxWidth: width,
                        thumbRadius: thumbRadius,
                        value: value,
                      ),
                      bottom: height - 20,
                      child: Center(
                        child: AppText(
                          '${value.round()}%',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: SfSliderTheme(
                        data: SfSliderThemeData(
                          activeTrackHeight: trackHeight,
                          inactiveTrackHeight: trackHeight,
                          thumbRadius: thumbRadius,
                          thumbColor: thumbColor,
                          activeTrackColor: activeTrackColor,
                          inactiveTrackColor: inactiveTrackColor,
                        ),
                        child: SfSlider(
                          value: value,
                          min: controller.minDiscountPercentage,
                          max: controller.maxDiscountPercentage,
                          stepSize: stepSize,
                          showLabels: false,
                          showTicks: showTicks,
                          thumbIcon: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryWhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColor.primaryBlack.withOpacity(0.65),
                                  offset: const Offset(0, 0),
                                  blurRadius: 2,
                                )
                              ],
                            ),
                          ),
                          activeColor: AppColor.primaryTextColor,
                          onChanged: (value) {
                            onChanged(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (showLabels)
          AppText(
            controller.maxDiscountPercentage.round().toString(),
            fontWeight: FontWeight.w600,
          ),
      ],
    );
  }
}

class AppSliderCtrl extends GetxController {
  double minDiscountPercentage = 0;
  double maxDiscountPercentage = 100;

  double getThumbPosition({
    required double maxWidth,
    required double thumbRadius,
    required double value,
  }) {
    final mainValue = maxWidth * (value / 100);
    final thumbOffset = (-50 * value / 100) + thumbRadius;
    return mainValue + thumbOffset;
  }
}
