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

import 'package:quantity_savers/app/core/widget/image_preview_widget.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';
import 'package:quantity_savers/app/modules/Details/controllers/viewAllReviews_controller.dart';

import '../../../core/utils/time_conversion.dart';
import '../../../export.dart';
import '../models/data_models/product_details_data_model.dart';

class ViewAllReviewsScreen extends StatelessWidget {
  final controller = Get.put(ViewAllReviewsController());
  final themeController = Get.put(ThemeController());

  ViewAllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllReviewsController>(
        init: ViewAllReviewsController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.back(result: {argIndex: true});
              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                        AppColors.gradient1st,
                        AppColors.gradient2nd
                      ])),
                ),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back(result: {argIndex: true});
                  },
                  icon: const AssetSVGWidget(iconsAppBarback),
                ).paddingOnly(bottom: 10),
                title: Center(
                  child: Text(
                    "ALL REVIEWS".toUpperCase(),
                    style:
                        const TextStyle(fontFamily: "Montserrat", fontSize: 18),
                  ).paddingOnly(
                    bottom: 20,
                    right: 35,
                    top: 10,
                  ),
                ),
              ),
              body: controller.isLoading == true
                  ? Center(
                      child: const CircularProgressIndicator(
                      color: AppColors.gradient2nd,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ratingAndReviews(controller),
                          _reviewDetailsList(controller)
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

Widget ratingAndReviews(ViewAllReviewsController controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: Get.width / 2.3,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          text:
                              "${controller.productDetailsResponseModel.data?.averageRating}",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                        ),
                        const AssetSVGWidget(
                          iconsRatingStar,
                          imageHeight: 24,
                          imageWidth: 24,
                          imageFitType: BoxFit.fill,
                          color: AppColors.gradient2nd,
                        )
                      ],
                    ),
                    TextView(
                      text:
                          "${controller.productDetailsResponseModel.data?.totalRatings} Ratings & ${controller.productDetailsResponseModel.data?.totalReviews} Reviews",
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ).paddingOnly(top: margin_10)
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width / 2.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(icons5star,color: AppColors.gradient2nd,),
                      RatingBar.builder(
                        initialRating: 5,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.gradient2nd,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      _rangeBar(
                          count:
                              "${controller.productDetailsResponseModel.data?.fiveStarRatings}",
                          value: controller
                              .productDetailsResponseModel.data?.fiveStarRatings
                              .toDouble())
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(icons4star,color: AppColors.gradient2nd,),
                      RatingBar.builder(
                        initialRating: 4,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.gradient2nd,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      _rangeBar(
                          count:
                              "${controller.productDetailsResponseModel.data?.fourStarRatings}",
                          value: controller
                              .productDetailsResponseModel.data?.fourStarRatings
                              .toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(icons3star,color: AppColors.gradient2nd,),
                      RatingBar.builder(
                        initialRating: 3,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.gradient2nd,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      _rangeBar(
                          count:
                              "${controller.productDetailsResponseModel.data?.threeStarRatings}",
                          value: controller.productDetailsResponseModel.data
                              ?.threeStarRatings
                              .toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(icons2star,color: AppColors.gradient2nd,),
                      RatingBar.builder(
                        initialRating: 2,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.gradient2nd,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      _rangeBar(
                          count:
                              "${controller.productDetailsResponseModel.data?.twoStarRatings}",
                          value: controller
                              .productDetailsResponseModel.data?.twoStarRatings
                              .toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(icons1star,color: AppColors.gradient2nd,),
                      RatingBar.builder(
                        initialRating: 1,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.gradient2nd,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      _rangeBar(
                          count:
                              "${controller.productDetailsResponseModel.data?.oneStarRatings}",
                          value: controller
                              .productDetailsResponseModel.data?.oneStarRatings
                              .toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                ],
              ),
            )
          ],
        ).paddingOnly(top: margin_20),
        MaterialButtonWidget(
          minHeight: 50,
          onPressed: () {
            controller.handleRateProduct();
          },
          buttonText: "RATE PRODUCT",
          buttonTextStyle: textStyleTitleLarge().copyWith(
              color: AppColors.gradient2nd,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          buttonRadius: 0,
          buttonBgColor: Colors.transparent,
          borderColor: Colors.grey.shade300,
          borderWidth: 1,
          isOutlined: true,
        ).paddingOnly(top: margin_20),
        _ratingReviewdivider(),
        if (controller.allVideosWithRatings.isNotEmpty) ...[
          _itemTitles("Review with videos", ontap: () {
            Get.toNamed(AppRoutes.reviewVideosAndImagesScreenRoute, arguments: {
              argProductId: controller.productId,
              typeVideo: true
            });
          }),
          _reviewVideosList(controller),
          _ratingReviewdivider(),
        ],
        if (controller.allImages.isNotEmpty) ...[
          _itemTitles("Review with images", ontap: () {
            Get.toNamed(AppRoutes.reviewVideosAndImagesScreenRoute,
                arguments: {argProductId: controller.productId});
          }),
          _reviewImagesList(controller),
          _ratingReviewdivider()
        ],
      ],
    ).paddingSymmetric(horizontal: margin_20);

_rangeBar({count, value}) {
  return Row(
    children: [
      SizedBox(
        width: Get.width / 6,
        height: height_5,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(margin_3)),
          child: LinearProgressIndicator(
            value: value ?? 0.0,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.gradient2nd),
            backgroundColor: AppColors.DustyGray.withOpacity(0.1),
          ),
        ),
      ),
      TextView(
        text: "$count",
        textStyle: textStyleTitleLarge().copyWith(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
      ).paddingOnly(left: margin_4)
    ],
  ).paddingOnly(left: margin_4);
}

_itemTitles(String title, {ontap}) => Container(
      child: Row(
        children: [
          TextView(
            text: title,
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          InkWell(
            onTap: ontap ??
                () {
                  print("View all");
                },
            child: Row(
              children: [
                TextView(
                    text: "See all",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.gradient2nd,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(width: 4),
                const AssetSVGWidget(iconsForword,
                    color: AppColors.gradient2nd, imageWidth: 8)
              ],
            ),
          )
        ],
      ),
    );

_ratingReviewdivider() => SizedBox(
      height: margin_4,
      child: Divider(
        thickness: margin_1,
        color: Colors.grey.shade300,
      ),
    ).paddingSymmetric(vertical: margin_20);

/*
_reviewVideosList(ViewAllReviewsController controller)
{
  final List<String> allVideos = [];

  controller.productDetailsResponseModel.data?.ratings?.forEach((rating) {
    allVideos.addAll(rating?.videos ?? []);
  });
  if(allVideos.isEmpty)
    {
      return   SizedBox(
        height: 184,
        width: Get.width,
        child: Center(
          child: TextView(
            text: "No Videos Found",
            textStyle: textStyleBodyMedium().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: font_12),
          ),
        ),
      );
    }
  else
    {
      return SizedBox(
        width: Get.width,
        height: 184,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: allVideos.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return InkWell(
              onTap: () {},
              child: _reviewVideos(allVideos [index],controller,index),
            ).paddingOnly(right: margin_10);
          },
        ),
      ).paddingOnly(top: margin_20);
    }

}
_reviewVideos(String? video,ViewAllReviewsController controller,int index) => Stack(
      children: [
        VideoPreviewWidget(
          mediaFile: MediaFile(
              networkPath:
              video),
          height: height_180,
          width: 132,
        ),
        Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: [
                // const AssetSVGWidget(iconsVideoPlay),
                TextView(
                  text: '',
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ).paddingOnly(left: margin_4)
              ],
            )),
        Positioned(
            bottom: 30,
            left: 8,
            child: SizedBox(
              height: 10,
              width: Get.width / 2,
                child: RatingBar.builder(
                  initialRating: controller.productDetailsResponseModel.data?.ratings?[index].ratings.toDouble(),
                  itemSize: 15,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                  },
                )
            ))
      ],
    );
*/

Widget _reviewVideosList(ViewAllReviewsController controller) {
  final Map<String, double> allVideosWithRatings = {};

  controller.productMediaResponseModel.data?.data?.forEach((review) {
    final videos = review.videos ?? [];
    final rating = (review.ratings ?? 0.0).toDouble();
    for (var video in videos) {
      allVideosWithRatings[video] = rating;
    }
  });

  if (allVideosWithRatings.isEmpty) {
    return SizedBox(
      height: 184,
      width: Get.width,
      child: Center(
        child: TextView(
          text: "No Videos Found",
          textStyle: textStyleBodyMedium().copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  } else {
    return SizedBox(
      width: Get.width,
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allVideosWithRatings.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final video = allVideosWithRatings.keys.elementAt(index);
          final rating = allVideosWithRatings[video] ?? 0.0;
          return InkWell(
            onTap: () {},
            child: _reviewVideos([video], rating),
          ).paddingOnly(right: 10.0);
        },
      ),
    ).paddingOnly(top: 20.0);
  }
}

Widget _reviewVideos(List<String>? video, double rating) {
  return SizedBox(
    width: height_110,
    child: ListView.builder(
      itemCount: video?.length ?? 0,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            VideoPreviewWidget(
              mediaFile: MediaFile(networkPath: video?[index]),
              height: height_160,
              width: height_130,
              padding: 50,
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Row(
                children: [
                  TextView(
                    text: '',
                    textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ).paddingOnly(left: 4.0),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 8,
              child: SizedBox(
                height: 10,
                width: Get.width / 2,
                child: RatingBar.builder(
                  initialRating: rating.toDouble(),
                  itemSize: 15,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.gradient2nd,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget _reviewEachVideosList(List<String>? videos) {
  return SizedBox(
    width: Get.width,
    height: 184,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videos?.length ?? 0,
      itemBuilder: (BuildContext ctxt, int index) {
        return InkWell(
          onTap: () {},
          child: _reviewEachVideos(videos?[index]),
        ).paddingOnly(right: 10.0);
      },
    ),
  ).paddingOnly(top: 20.0);
}

Widget _reviewEachVideos(String? video) {
  return SizedBox(
    width: height_110,
    child: Stack(
      children: [
        VideoPreviewWidget(
          mediaFile: MediaFile(networkPath: video),
          height: 180,
          width: 132,
          padding: 50,
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Row(
            children: [
              TextView(
                text: '',
                textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ).paddingOnly(left: 4.0),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   left: 8,
        //   child: SizedBox(
        //     height: 10,
        //     width: Get.width / 2,
        //     child: RatingBar.builder(
        //       initialRating: rating,
        //       itemSize: 15,
        //       minRating: 1,
        //       direction: Axis.horizontal,
        //       allowHalfRating: true,
        //       itemCount: 5,
        //       ignoreGestures: true,
        //       itemBuilder: (context, _) => const Icon(
        //         Icons.star,
        //         color: Colors.amber,
        //       ),
        //       onRatingUpdate: (rating) {},
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

_reviewImagesList(ViewAllReviewsController controller) {
  final List<String> allImages = [];

  controller.productDetailsResponseModel.data?.ratings?.forEach((rating) {
    allImages.addAll(rating?.images ?? []);
  });
  if (allImages.isEmpty) {
    return Container(
      height: 184,
      width: Get.width,
      child: Center(
        child: TextView(
          text: "No Images Found",
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_12),
        ),
      ),
    );
  } else {
    return SizedBox(
      width: Get.width,
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final imageUrl = allImages[index];
          return InkWell(
            onTap: () {
              Get.dialog(ImagePreviewWidget(imageProvider: imageUrl ?? ""));
            },
            child: NetworkImageWidget(
              imageUrl: imageUrl ?? '',
              imageWidth: height_130,
              imageHeight: height_160,
              imageFitType: BoxFit.cover,
              radiusAll: 10,
            ),
          ).paddingOnly(right: margin_10);
        },
      ),
    ).paddingOnly(top: margin_15);
  }
}

_reviewImages(List<String>? images) {
  return SizedBox(
    width: Get.width,
    height: 184,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images?.length,
      itemBuilder: (BuildContext ctxt, int index) {
        final imageUrl = images?[index];
        return InkWell(
          onTap: () {
            Get.dialog(ImagePreviewWidget(imageProvider: imageUrl ?? ""));
          },
          child: NetworkImageWidget(
            imageUrl: imageUrl ?? '',
            imageWidth: height_130,
            imageHeight: height_160,
            imageFitType: BoxFit.cover,
            radiusAll: 10,
          ),
        ).paddingOnly(right: margin_10);
      },
    ),
  ).paddingOnly(top: margin_15);
}

_reviewDetailsList(ViewAllReviewsController controller) => ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount:
          controller.productDetailsResponseModel.data?.ratings?.length ?? 0,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext ctxt, int index) {
        return _reviewDetail(
            controller.productDetailsResponseModel.data?.ratings?[index],
            controller);
      },
    );

_reviewDetail(Ratings? ratings, ViewAllReviewsController controller) => Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: ratings?.ratings.toDouble(),
                  itemSize: 25,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.gradient2nd,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                TextView(
                  text: "${ratings?.title}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ).paddingOnly(left: 5),
              ],
            ),
            TextView(
              maxLines: 100,
              text: "${ratings?.description}",
              textStyle: textStyleTitleLarge()
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            ).paddingSymmetric(vertical: margin_10),
            if (ratings?.images != null && ratings?.images?.length != null) ...[
              _reviewImages(ratings?.images)
            ],
            if (ratings?.videos != null && ratings?.videos?.length != null) ...[
              _reviewEachVideosList(ratings?.videos),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  text: ratings?.userId?.name ?? "Unknown",
                  textStyle: textStyleTitleLarge().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 18,
                  width: 5,
                  child: VerticalDivider(
                    indent: 2,
                    thickness: 1,
                    color: Colors.grey.shade600,
                  ),
                ),
                TextView(
                  text:
                      " ${convertMillisecondsToTimeAgo(int.parse(ratings?.updatedAt))}",
                  textStyle: textStyleTitleLarge().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    controller.hitProductReviewLikeAndDislikeApi(
                        ratings?.sId, "LIKE");
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ratings?.userLikeStatus == "LIKE"
                          ? const AssetSVGWidget(
                              iconsThumbUp,
                              color: AppColors.gradient2nd,
                            )
                          : const AssetSVGWidget(iconsThumbUp),
                      (ratings?.likesCount ?? 0) > 0
                          ? TextView(
                              text: "${ratings?.likesCount ?? 0}",
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: AppColors.categoriesgrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ).paddingOnly(left: margin_10)
                          : emptySizeBox()
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.hitProductReviewLikeAndDislikeApi(
                        ratings?.sId, "DISLIKE");
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ratings?.userLikeStatus == "DISLIKE"
                          ? const AssetSVGWidget(
                              iconsThumbDown,
                              color: AppColors.gradient2nd,
                            )
                          : const AssetSVGWidget(iconsThumbDown),
                      (ratings?.dislikeCount ?? 0) > 0
                          ? TextView(
                              text: "${ratings?.dislikeCount ?? 0}",
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: AppColors.categoriesgrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ).paddingOnly(left: margin_10)
                          : emptySizeBox()
                    ],
                  ).paddingOnly(left: margin_20),
                )
              ],
            ).paddingOnly(top: margin_15),
          ],
        ).paddingSymmetric(horizontal: margin_20),
        _ratingReviewdivider()
      ],
    );

_ratingStars({stars, heightOfStar}) {
  debugPrint("Stars are $stars");
  return SizedBox(
    height: heightOfStar,
    width: Get.width / 3.5,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext ctxt, int index) {
        return SizedBox(
          child: (stars <= index)
              ? AssetSVGWidget(
                  iconsBlankstar,
                  imageHeight: heightOfStar,
                  imageWidth: heightOfStar,
                  imageFitType: BoxFit.fill,
                ).paddingOnly(right: margin_4)
              : AssetSVGWidget(
                  iconsRatingStar,
                  imageHeight: heightOfStar,
                  imageWidth: heightOfStar,
                  imageFitType: BoxFit.fill,
                  color: AppColors.gradient2nd,
                ).paddingOnly(right: margin_4),
        );
      },
    ),
  );
}
