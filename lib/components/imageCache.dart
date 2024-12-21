import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Widget buildCachedNetworkImage({
  required String imageUrl,
  int cacheDurationInDays = 1,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => Center(
      child: SizedBox(
        width: 24, 
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2, 
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey), 
        ),
      ),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    cacheManager: CacheManager(
      Config(
        imageUrl.hashCode.toString(),
        stalePeriod: Duration(days: cacheDurationInDays),
      ),
    ),
    width: width,
    height: height,
    fit: fit,
  );
}
