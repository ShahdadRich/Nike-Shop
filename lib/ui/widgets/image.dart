import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadeService extends StatelessWidget {
  final String imgeUrl;
  final BorderRadius borderRadius;
  const ImageLoadeService({
    super.key,
    required this.imgeUrl,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: imgeUrl));
  }
}
