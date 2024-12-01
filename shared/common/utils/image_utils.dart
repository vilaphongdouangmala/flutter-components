import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:monthol_mobile/shared/common/utils/file_utils.dart';

class ImageUtils {
  static String getUniqueImageUrl(String url) {
    // Add a unique query string to the image URL to prevent caching
    return '$url?${DateTime.now().second}';
  }

  static String getImageCacheKey({
    required String? updatedAt,
    String? id,
    required String attribute,
  }) {
    return '${(id != null ? "$id-" : '')}$attribute-$updatedAt';
  }

  static Future<Uint8List> getImageBytesFromNetwork({
    required String imageUrl,
  }) async {
    http.Response response = await http.get(Uri.parse(
      imageUrl,
    ));
    return Uint8List.fromList(response.bodyBytes);
  }

  static Future<bool> isImageCached(String cacheKey) async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(cacheKey);
    return fileInfo != null;
  }

  static bool isNetworkImageUrl(String url) {
    const imageExtensions = FileUtils.allowedImageExtensions;
    final uri = Uri.tryParse(url);

    if (uri == null || !uri.hasScheme || uri.path.isEmpty) {
      return false;
    }

    final extension = uri.pathSegments.last.split('.').last.toLowerCase();
    return imageExtensions.contains(extension);
  }

  static bool isBase64Image(String base64String) {
    final base64Regex =
        RegExp(r'^data:image\/(png|jpe?g);base64,[A-Za-z0-9+/]+={0,2}$');
    return base64Regex.hasMatch(base64String);
  }
}
