import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';

class AppFileImage extends StatelessWidget {
  final File fileImage;
  final String errorImage;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const AppFileImage({
    super.key,
    required this.fileImage,
    this.errorImage = AssetConstants.montholLogo,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.file(
      fileImage,
      fit: fit,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(errorImage);
      },
    );
  }
}
