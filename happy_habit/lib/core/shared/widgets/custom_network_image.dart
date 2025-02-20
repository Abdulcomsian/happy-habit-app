import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/shared/widgets/circular_bounce_loader.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? width, height;
  final double placeholderSize;

  const CustomNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.url,
    this.placeholderSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (context, url) => CircleBounceLoader(size: placeholderSize.r),
      errorWidget: (context, url, error) => Icon(Icons.error_outline, size: placeholderSize.r),
    );
  }
}
