import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:monthol_mobile/shared/common/constants/asset_constants.dart';
import 'package:monthol_mobile/shared/common/utils/image_utils.dart';
import 'package:monthol_mobile/shared/configs/app_configs.dart';
import 'package:monthol_mobile/shared/configs/theme_configs.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String errorImage;
  final Widget? errorWidget;
  final BoxFit? fit;
  final bool isCacheEnable;
  final bool isImageProvider;
  final bool isAbsoluteUrl;
  final double? width;
  final double? height;
  final String? cacheKey;
  final Color? backgroundColor;
  final double loadingBorderRadius;
  final void Function(DownloadProgress downloadProgress)? onImageLoading;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.errorImage = AssetConstants.montholLogo,
    this.fit,
    this.isCacheEnable = true,
    this.isImageProvider = false,
    this.isAbsoluteUrl = true,
    this.width,
    this.height,
    this.cacheKey,
    this.backgroundColor,
    this.loadingBorderRadius = 0,
    this.onImageLoading,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final String url =
        isAbsoluteUrl ? imageUrl : Environments.objStorageUrl + imageUrl;

    if (isCacheEnable) {
      if (isImageProvider) {
        return Image(image: CachedNetworkImageProvider(url));
      } else {
        return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          cacheKey: cacheKey,
          fit: fit,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            if (onImageLoading != null) {
              onImageLoading!(downloadProgress);
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(loadingBorderRadius),
                color: backgroundColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: AppColor.primaryWhite,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColor.primaryWhite,
                  ),
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            // Show default error image if errorWidget is not provided
            return errorWidget != null
                ? errorWidget!
                : DefaultErrorNetworkImage(
                    errorImage: errorImage,
                    width: width,
                    height: height,
                    fit: fit,
                  );
          },
        );
      }
    } else {
      return Image.network(
        ImageUtils.getUniqueImageUrl(url),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return DefaultErrorNetworkImage(
            errorImage: errorImage,
            width: width,
            height: height,
            fit: fit,
          );
        },
      );
    }
  }
}

class DefaultErrorNetworkImage extends StatelessWidget {
  final String errorImage;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const DefaultErrorNetworkImage({
    super.key,
    this.errorImage = AssetConstants.montholLogo,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      errorImage,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
