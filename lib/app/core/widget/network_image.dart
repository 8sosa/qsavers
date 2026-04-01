/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:quantity_savers/app/core/widget/custom_skeleton_loader_widget.dart';

import '../../export.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? radiusAll;
  final double radiusTopRight;
  final double radiusTopLeft;
  final double radiusBottomRight;
  final double radiusBottomLeft;
  final double imageHeight;
  final double imageWidth;
  final BoxFit imageFitType;
  final color;
  final placeHolder;

  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.radiusAll,
    this.radiusTopLeft = 0.0,
    this.radiusBottomRight = 0.0,
    this.radiusBottomLeft = 0.0,
    this.radiusTopRight = 0.0,
    required this.imageHeight,
    required this.imageWidth,
    this.color,
    this.placeHolder,
    this.imageFitType = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: imageHeight,
        width: imageWidth,
        child: Shimmer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusAll ?? 0.0),
            // enforce circular shape
            child: CachedNetworkImage(
              imageUrl: "$imageBaseUrl$imageUrl",
              fit: imageFitType,
              placeholder: (context, url) => ShimmerLoading(
                  isLoading: true,
                  isImage: true,
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.grey,
                      ))),
              errorWidget: (context, url, error) => AssetImageWidget(
                placeHolder ?? iconsSplashPng,
                radiusAll: radiusAll,
                imageHeight: imageHeight,
                imageWidth: imageWidth,
                imageFitType: imageFitType ?? BoxFit.fill,
              ),
            ),
          ),
        ));
  }
}
