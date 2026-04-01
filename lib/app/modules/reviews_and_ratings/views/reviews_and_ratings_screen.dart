import "package:quantity_savers/app/core/widget/image_preview_widget.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/media_file.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart";

import "../../../core/utils/read_more.dart";
import "../../../export.dart";

class ReviewsAndRatingsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ReviewsAndRatingsController());

  ReviewsAndRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsAndRatingsController>(
      init: ReviewsAndRatingsController(),
      builder: (controller) {
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
              ),
              centerTitle: true,
              title: Text(
                strReviewsAndRatings.toUpperCase(),
                style:
                    TextStyle(fontSize: font_16, fontWeight: FontWeight.w600),
              ),
            ),
            body:controller.reviewRatingResponseModel.data?.totalCount==0 ? _noCouponScreen(): Container(
              decoration: const BoxDecoration(color: AppColors.textfieldborder),
              child: ListView.builder(
                itemCount:
                    controller.reviewRatingResponseModel.data?.totalCount ?? 0,
                itemBuilder: (context, index) {
                  return _reviewsAndRatingsScreen(index);
                },
              ),
            ));
      },
    );
  }
  _noCouponScreen() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetSVGWidget(iconsNotPurchased)
            .paddingOnly(bottom: margin_20),
        TextView(
          text: strNoDataFound,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(bottom: margin_16),

      ],
    ),
  );
  _reviewsAndRatingsScreen(int index) => Container(
        padding: EdgeInsets.all(margin_16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                NetworkImageWidget(
                        imageUrl: controller.reviewRatingResponseModel.data
                                ?.data?[index].productId?.images?[0] ??
                            '',
                        imageHeight: height_75,
                        radiusAll: radius_8,
                        imageWidth: width_110)
                    .paddingOnly(right: margin_8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: controller.reviewRatingResponseModel.data
                          ?.data?[index].productId?.name,
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.lightBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ),
                    TextView(
                      text:
                          "(SKU:${controller.reviewRatingResponseModel.data?.data?[index].productId?.produuctId})",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.bottombarColor,
                          fontWeight: FontWeight.w400,
                          fontSize: font_12),
                    ).paddingSymmetric(vertical: margin_8),
                    TextView(
                      text:
                          "\$${(controller.reviewRatingResponseModel.data?.data?[index].productId?.discountPrice).toStringAsFixed(2)}",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.pricesColor,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ),
                  ],
                ),
              ],
            ),
            _ratingInfo(index),
            Align(
              alignment: Alignment.topLeft,
              child: TextView(
                text: controller
                    .reviewRatingResponseModel.data?.data?[index].title,
                textStyle: textStyleBodyMedium().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: font_14),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ReadMoreTextWidget(
                trimLines: 3,
                text: controller
                    .reviewRatingResponseModel.data?.data?[index].description??'',
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.lightBlackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: font_13),
              ),
            ).paddingOnly(top: margin_8, bottom: margin_16),
            if (controller
                        .reviewRatingResponseModel.data?.data?[index].images !=
                    null &&
                controller.reviewRatingResponseModel.data?.data?[index].images
                        ?.length !=
                    0)...[
              SizedBox(
                height: height_70,
                width: Get.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.reviewRatingResponseModel.data
                      ?.data?[index].images?.length ??
                      0,
                  shrinkWrap: true,
                  itemBuilder: (context, value) {
                    return InkWell(
                      onTap: ()
                      {
                        Get.dialog(ImagePreviewWidget(imageProvider: controller.reviewRatingResponseModel.data
                            ?.data?[index].images?[value] ??
                            ''));
                      },
                      child: NetworkImageWidget(
                          imageUrl: controller.reviewRatingResponseModel.data
                              ?.data?[index].images?[value] ??
                              '',
                          imageHeight: height_70,
                          imageFitType: BoxFit.cover,
                          radiusAll: radius_8,
                          imageWidth: height_80)
                          .paddingOnly(right: margin_12),
                    );
                  },
                ),
              )
            ],
            SizedBox(height: 10,),
            if (controller
                .reviewRatingResponseModel.data?.data?[index].videos !=
                null &&
                controller.reviewRatingResponseModel.data?.data?[index].videos
                    ?.length !=
                    0)...[
              SizedBox(
                height: height_70,
                width: Get.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.reviewRatingResponseModel.data
                      ?.data?[index].videos?.length ??
                      0,
                  shrinkWrap: true,
                  itemBuilder: (context, value) {
                    return VideoPreviewWidget(
                      mediaFile: MediaFile(
                          networkPath:
                          controller.reviewRatingResponseModel.data
                              ?.data?[index].videos?[value],),
                      height: height_135,
                      width: height_80,
                      padding: 50,
                    )
                        .paddingOnly(right: margin_12,left: margin_3);
                  },
                ),
              )
            ],
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.editReviewsAndRatingsRoute,
                        arguments: {
                          argForWriteReview: strEditReviewsAndRatings,
                          argReviewId: controller
                              .reviewRatingResponseModel.data?.data?[index].sId,
                          argIsRouteForEditReview: true,
                          argIsReviewRatingResponseModel: controller
                              .reviewRatingResponseModel.data?.data?[index]
                        });
                  },
                  child: _reviewsAndRatingsManageBtn(iconsPencil, strEdits),
                )),
                SizedBox(
                  width: width_8,
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Get.dialog(CustomDialogWidget(
                          title: strDeleteReviewDes,
                          confirmTitle: strYes,
                          cancelTitle: strNo,
                          confirmBtnBgColor: Colors.red,
                          cancelBtnBgColor: AppColors.textfieldborder,
                          cancelTitleColor: Colors.black,
                          onTapConfirm: () {
                            Get.back(result: true);
                            controller.deleteReviewApi(controller
                                    .reviewRatingResponseModel
                                    .data
                                    ?.data?[index]
                                    .sId ??
                                '');
                          },
                        ));
                      },
                      child:
                          _reviewsAndRatingsManageBtn(iconsDelete, strDelete)),
                )
              ],
            ).paddingOnly(top: margin_16)
          ],
        ),
      ).paddingOnly(bottom: margin_12);

  _ratingInfo(int index) {
    var date =
        controller.reviewRatingResponseModel.data?.data?[index].updatedAt ?? "";

    int? reviewDate;
    if (date.isNotEmpty) {
      reviewDate = int.tryParse(date);
    }

    if (reviewDate != null) {
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(reviewDate);
      controller.updatedDate = DateFormat('dd MMM yyyy').format(confirmedDate);
    } else {
      print("Failed to parse date: $date");
    }
    return Row(children: [
      RatingBar.builder(
        initialRating: controller
            .reviewRatingResponseModel.data?.data?[index].ratings
            .toDouble(),
        itemSize: 16,
        minRating: 1,
        ignoreGestures: true,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.gradient2nd,
        ),
        onRatingUpdate: (rating) {
          debugPrint("$rating");
        },
      ),
      TextView(
        text: controller.reviewRatingResponseModel.data?.data?[index].ratings
            .toString(),
        textStyle: textStyleBodyMedium().copyWith(
            color: AppColors.pricesColor,
            fontWeight: FontWeight.w500,
            fontSize: font_14),
      ),
      const Spacer(),
      TextView(
        text: controller.updatedDate,
        textStyle: textStyleBodyMedium().copyWith(
            color: AppColors.bottombarColor,
            fontWeight: FontWeight.w500,
            fontSize: font_14),
      )
    ]).paddingOnly(top: margin_16, bottom: margin_12);
  }

  _reviewsAndRatingsManageBtn(iconPrefix, btnName) => Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_4),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: btnName == strDelete
                    ? [AppColors.lightRedColor, AppColors.lightRedColor]
                    : [AppColors.gradient1st, AppColors.gradient2nd])),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetSVGWidget(
                iconPrefix,
                color: Colors.white,
              ).paddingOnly(right: margin_2),
              Text(btnName,
                  style: TextStyle(
                    fontSize: font_12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),
      );
}
