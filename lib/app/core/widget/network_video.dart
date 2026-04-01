import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quantity_savers/app/core/widget/custom_skeleton_loader_widget.dart';

import '../../data/repository/endpoint.dart';
import '../values/app_assets.dart';
import 'asset_image.dart';

class NetworkVideoWidget extends StatelessWidget {
  final String videoUrl;
  final double? radiusAll;
  final double radiusTopRight;
  final double radiusTopLeft;
  final double radiusBottomRight;
  final double radiusBottomLeft;
  final double videoHeight;
  final double videoWidth;
  final color;
  final placeHolder;

  const NetworkVideoWidget({
    Key? key,
    required this.videoUrl,
    this.radiusAll,
    this.radiusTopLeft = 0.0,
    this.radiusBottomRight = 0.0,
    this.radiusBottomLeft = 0.0,
    this.radiusTopRight = 0.0,
    required this.videoHeight,
    required this.videoWidth,
    this.color,
    this.placeHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusAll ?? 0.0),
        child: AspectRatio(
          aspectRatio: 16 / 9, // You may need to adjust this aspect ratio
          child: CachedNetworkImage(
            imageUrl: "$videoUrl",
            placeholder: (context, url) => ShimmerLoading(
              isLoading: true,
              isImage: false,
              child: Container(
                color: Colors.grey,
              ),
            ),
            errorWidget: (context, url, error) => AssetImageWidget(
              placeHolder ?? iconsSplashPng,
              radiusAll: radiusAll,
              imageHeight: videoHeight,
              imageWidth: videoWidth,
              imageFitType: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
