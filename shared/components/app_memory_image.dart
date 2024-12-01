import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';

class AppMemoryImage extends StatelessWidget {
  final Uint8List memoryImage;
  final String errorImage;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const AppMemoryImage({
    super.key,
    required this.memoryImage,
    this.errorImage = AssetConstants.montholLogo,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      memoryImage,
      fit: fit,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(errorImage);
      },
    );
  }
}
