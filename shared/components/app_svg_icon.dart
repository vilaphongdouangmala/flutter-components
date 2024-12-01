import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon({
    super.key,
    required this.svgAsset,
    required this.size,
    this.iconColor = AppColor.primaryTextColor,
  });

  final String svgAsset;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgAsset,
      colorFilter: ColorFilter.mode(
        iconColor,
        BlendMode.srcIn,
      ),
      width: size - 2,
      height: size - 2,
    );
  }
}
