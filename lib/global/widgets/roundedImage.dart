import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage(
      {super.key,
      this.url,
      required this.asset,
      required this.height,
      this.borderRadius = 100,
       this.width});
  final String? url;
  final String asset;
  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: url != null
          ? CachedNetworkImage(
              imageUrl: url!, width: width, height: height, fit: BoxFit.cover)
          : Image.asset(asset, width: width, height: height, fit: BoxFit.cover),
    );
  }
}
