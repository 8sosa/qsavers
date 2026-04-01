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

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../export.dart';

class ReviewVideosAndImagesScreen extends StatelessWidget {
  final controller = Get.put(ReviewVideosAndImageController());
  final themeController = Get.put(ThemeController());

  ReviewVideosAndImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewVideosAndImageController>(
        init: ReviewVideosAndImageController(),
        builder: (context) {
          return Scaffold(
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
                  Get.back();
                },
                icon: const AssetSVGWidget(iconsAppBarback),
              ).paddingOnly(bottom: 5),
              title: Center(
                child: Text(
                  "customer media".toUpperCase(),
                  style:
                      const TextStyle(fontFamily: "Montserrat", fontSize: 18),
                ).paddingOnly(bottom: 20, right: 35, top: 10),
              ),
              bottom: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.white,
                labelStyle: textStyleTitleLarge()
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => controller.onTabChanged(index),
                tabs: const [Tab(text: "VIDEOS "), Tab(text: "PHOTOS ")],
              ),
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  controller.isLoading == true
                      ? Center(child: const CircularProgressIndicator())
                      : _reviewVideosList(controller),
                  controller.isLoading == true
                      ? Center(child: const CircularProgressIndicator())
                      : _reviewImagesList(controller)
                ]),
          );
        });
  }

  _reviewVideosList(ReviewVideosAndImageController controller) {
    final Map<String, double> allVideosWithRatings = {};

    controller.productMediaResponseModel.data?.data?.forEach((review) {
      final videos = review.videos ?? [];
      final rating = (review.ratings ?? 0.0).toDouble();
      for (var video in videos) {
        allVideosWithRatings[video] = rating;
      }
    });

    final List<Map<String, dynamic>> allVideosWithDetails = [];

    controller.productMediaResponseModel.data?.data?.forEach((review) {
      final videos = review.videos ?? [];
      final rating = review.ratings ?? 0.0;
      final title = review.title ?? '';
      final description = review.description ?? '';
      final userName = review.userId?.name ?? 'Unknown';
      final updatedAt = review.updatedAt ?? '';

      for (var video in videos) {
        allVideosWithDetails.add({
          'video': video,
          'rating': rating,
          'title': title,
          'description': description,
          'userName': userName,
          'updatedAt': updatedAt
        });
      }
    });

    if (controller.isLoading == true) {
      return Skeletonizer(
        enabled: controller.isLoading,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1 / 1.3,
          ),
          itemCount: allVideosWithRatings.length,
          itemBuilder: (context, index) {
            // final video = allVideosWithRatings.keys.elementAt(index);
            // final rating = allVideosWithRatings[video] ?? 0.0;
            // return _reviewVideos([video], rating);
            final videoDetail = allVideosWithDetails[index];
            final video = videoDetail['video'];
            final rating = videoDetail['rating'];
            final title = videoDetail['title'];
            final description = videoDetail['description'];
            final userName = videoDetail['userName'];
            final updatedAt = videoDetail['updatedAt'];

            return _reviewVideos(
                video, rating, title, description, userName, updatedAt);
          },
        ).paddingAll(20),
      );
    }
    if (allVideosWithRatings.isEmpty) {
      return _noCouponScreen();
    } else {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1 / 1.3,
        ),
        itemCount: allVideosWithRatings.length,
        itemBuilder: (context, index) {
          // final video = allVideosWithRatings.keys.elementAt(index);
          // final rating = allVideosWithRatings[video] ?? 0.0;
          // return _reviewVideos([video], rating);
          final videoDetail = allVideosWithDetails[index];
          final video = videoDetail['video'];
          final rating = videoDetail['rating'];
          final title = videoDetail['title'];
          final description = videoDetail['description'];
          final userName = videoDetail['userName'];
          final updatedAt = videoDetail['updatedAt'];

          return _reviewVideos(
              [video], rating.toDouble(), title, description, userName, updatedAt);
        },
      ).paddingAll(20);
    }
  }

  _noCouponScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: "No Data Found",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  _reviewVideos(List<String>? video, double rating, var title, var description,
      var userName, var updatedAt) {
    return SizedBox(
      width: height_110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: video?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint("hello world");
              Get.toNamed(AppRoutes.reviewsDetailsScreenRoute, arguments: {
                argForImages: false,
                argForVideoUrl: video?[index],
                argTitle: title,
                argDescription: description,
                argRating: rating,
                argUserName: userName,
                argUpdatedAt: updatedAt
              });
            },
            child: Stack(
              children: [
                VideoPreviewWidget(
                  onTap: () {
                    Get.toNamed(AppRoutes.reviewsDetailsScreenRoute,
                        arguments: {
                          argForImages: false,
                          argForVideoUrl: video?[index],
                          argTitle: title,
                          argDescription: description,
                          argRating: rating,
                          argUserName: userName,
                          argUpdatedAt: updatedAt
                        });
                  },
                  mediaFile: MediaFile(networkPath: video?[index]),
                  height: height_225,
                  width: Get.width / 2.3,
                  autoplay: false,
                ),
                Positioned(
                    bottom: 8,
                    left: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        )))
              ],
            ),
          );
        },
      ),
    );
  }

  _reviewImagesList(ReviewVideosAndImageController controller) {
    List<String> allImages = [];
    controller.productDetailsResponseModel.data?.ratings?.forEach((rating) {
      allImages.addAll(rating?.images ?? []);
    });

    if (controller.isLoading == true) {
      return Skeletonizer(
        enabled: controller.isLoading,
        child: DynamicHeightGridView(
          itemCount: allImages.length,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          builder: (ctx, index) {
            final imageUrl = allImages[index];
            if (index % 2 == 0) {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.reviewsDetailsScreenRoute, arguments: {
                    argForImages: true,
                    argForImagesUrl: imageUrl
                  });
                },
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                  imageFitType: BoxFit.cover,
                  imageHeight: height_150,
                  imageWidth: width_50,
                  radiusAll: 10,
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.reviewsDetailsScreenRoute, arguments: {
                    argForImages: true,
                    argForImagesUrl: imageUrl
                  });
                },
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                  imageFitType: BoxFit.cover,
                  imageHeight: height_100,
                  imageWidth: width_50,
                  radiusAll: 10,
                ),
              );
            }
          },
        ),
      );
    }
    return GetBuilder<ReviewVideosAndImageController>(
      init: controller,
      builder: (controller) {
        List<String> allImages = [];
        controller.productDetailsResponseModel.data?.ratings?.forEach((rating) {
          allImages.addAll(rating?.images ?? []);
        });

        if (allImages.isEmpty) {
          return _noCouponScreen();
        } else {
          return Padding(
            padding: EdgeInsets.all(margin_20),
            child: DynamicHeightGridView(
              itemCount: allImages.length,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              builder: (ctx, index) {
                final imageUrl = allImages[index];
                if (index % 2 == 0) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.reviewsDetailsScreenRoute,
                          arguments: {
                            argForImages: true,
                            argForImagesUrl: imageUrl
                          });
                    },
                    child: NetworkImageWidget(
                      imageUrl: imageUrl,
                      imageFitType: BoxFit.cover,
                      imageHeight: height_150,
                      imageWidth: width_50,
                      radiusAll: 10,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.reviewsDetailsScreenRoute,
                          arguments: {
                            argForImages: true,
                            argForImagesUrl: imageUrl
                          });
                    },
                    child: NetworkImageWidget(
                      imageUrl: imageUrl,
                      imageFitType: BoxFit.cover,
                      imageHeight: height_100,
                      imageWidth: width_50,
                      radiusAll: 10,
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
