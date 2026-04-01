

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

import 'package:quantity_savers/app/export.dart';

import 'full_screen_image.dart';

Widget imageFile(File file,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.file(
      file,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageMemory(Uint8List bytes,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.memory(
      bytes,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageNetwork(String url,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    FancyShimmerImage(
      imageUrl: url,
      height: height!,
      width: width!,
      boxFit: fit!,
    );

imageAssetProvider(name) => AssetImage(name);

imageNetworkProvider(name) => NetworkImage(name);

imageFileProvider(name) => FileImage(name);

Widget cachedImage(
  url, {
  double? height,
  double? width,
  BoxFit boxFit = BoxFit.contain,
}) {
  return FancyShimmerImage(
    width: width!,
    height: height!,
    boxFit: boxFit,
    imageUrl: url ?? "",
  );
}

Widget cachedImageWithView(
  url, {
  double? height,
  double? width,
  var tag,
  BoxFit boxFit = BoxFit.contain,
}) {
  return FullScreenWidget(
    disposeLevel: DisposeLevel.High,
    child: Hero(
      tag: tag,
      child: FancyShimmerImage(
        width: width!,
        height: height!,
        boxFit: boxFit,
        imageUrl: url ?? "",
      ),
    ),
  );
}
