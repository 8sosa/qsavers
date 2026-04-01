import "package:quantity_savers/app/core/widget/image_preview_widget.dart";
import "package:quantity_savers/app/core/widget/local_image_preview_widget.dart";

import "../../../core/widget/video_player_widget/media_file.dart";
import "../../../core/widget/video_player_widget/video_preview_widget.dart";
import "../../../export.dart";

class EditReviewsAndRatingsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(EditReviewsAndRatingsController());
  final GlobalKey<FormState> ratingReviewFormGlobalKey = GlobalKey<FormState>();

  EditReviewsAndRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditReviewsAndRatingsController>(
      init: EditReviewsAndRatingsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: controller.title.toUpperCase(),
            actionWidget: controller.argument == strEditReviewsAndRatings
                ? [
                    IconButton(
                      onPressed: () {
                        Get.dialog(CustomDialogWidget(
                          title: strDeleteReviewRating,
                          confirmTitle: strYes,
                          cancelTitle: strNo,
                          confirmBtnBgColor: Colors.red,
                          cancelTitleColor: AppColors.gradientColorSecondary,
                          cancelBtnBorder: Border.all(
                              color: AppColors.borderColor, width: 1),
                          cancelBtnBgColor: Colors.transparent,
                          onTapConfirm: () {
                            controller.deleteReviewApi(
                                controller.reviewRatingData.sId ?? '');
                            Get.back(result: true);
                          },
                          isImage: false,
                          isCloseBtn: true,
                        ));
                      },
                      icon: const AssetSVGWidget(iconsDelete),
                    ),
                  ]
                : null,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _productInfo(),
                      const Divider(
                        color: AppColors.textfieldborder,
                      ),
                      Container(
                        child: _reviewsAndRatingsForm(),
                      )
                    ],
                  ),
                ),
              ),
              BottomButtonWidget(
                onPressed: () {
                  debugPrint("${controller.argument}");
                  if (controller.argument == strEditReviewsAndRatings) {
                    controller.hitEditReviewApi();
                  } else {
                    if (ratingReviewFormGlobalKey.currentState!.validate()) {
                      controller.hitProductReviewApi();
                    } else {
                      showToast(message: "Please add required Field");
                    }
                  }
                },
                btnTitle: (controller.argument == strEditReviewsAndRatings)
                    ? strSaveChanges
                    : strSubmit,
                isBorderColor: false,
              ),
            ],
          ),
        );
      },
    );
  }

  _productInfo() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height_65,
            width: width_65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius_4)),
                border: Border.all(color: AppColors.textfieldborder)),
            child: NetworkImageWidget(
              imageUrl: controller.isRouteForEditReview == true
                  ? controller.reviewRatingData.productId?.images![0] ?? ''
                  : controller.productDetailsResponseModel.data?.images![0] ??
                      '',
              imageHeight: height_65,
              imageWidth: width_65,
              imageFitType: BoxFit.contain,
            ).paddingAll(margin_4),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextView(
                        text: controller.isRouteForEditReview == true
                            ? controller.reviewRatingData.productId?.name
                            : "${controller.productDetailsResponseModel.data?.name}",
                        maxLines: 4,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_14),
                      ).paddingOnly(bottom: margin_8),
                    ),
                    // const Spacer(),
                    TextView(
                      text: controller.isRouteForEditReview == true
                          ? "\$${controller.reviewRatingData.productId?.discountPrice}"
                          : "\$${controller.productDetailsResponseModel.data?.discountPrice}",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AssetSVGWidget(
                      iconsStar,
                      color: AppColors.gradient2nd,
                      imageHeight: height_20,
                    ).paddingOnly(right: margin_4),
                    TextView(
                      text: controller.isRouteForEditReview == true
                          ? "${controller.reviewRatingData.productId?.averageRating}"
                          : "${controller.productDetailsResponseModel.data?.averageRating} ",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.lightBlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ),
                    TextView(
                      text: controller.isRouteForEditReview == true
                          ? "(${controller.reviewRatingData.productId?.totalRatings} Ratings & ${controller.reviewRatingData.productId?.totalReviews} Reviews)"
                          : "(${controller.productDetailsResponseModel.data?.totalRatings} Ratings & ${controller.productDetailsResponseModel.data?.totalReviews} Reviews)",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.gradientColorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: font_12),
                    ).paddingOnly(left: 5),
                  ],
                )
              ],
            ).paddingOnly(left: margin_8),
          ),
        ],
      ).paddingAll(margin_20);

  _reviewsAndRatingsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ratingInfo(),
        if (controller.argument == strEditReviewsAndRatings) ...[
          TextView(
            text:
                controller.isFromProductDetails ? strAddPhotos : strEditPhotos,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(top: margin_16, bottom: margin_16),
          _uploadImageInfo(),
        ],
        if (controller.argument != strEditReviewsAndRatings) ...[
          TextView(
            text:
                controller.isFromProductDetails ? strAddPhotos : strEditPhotos,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(top: margin_16, bottom: margin_16),
          _uploadImageInfo(),
        ],
        if (controller.argument == strEditReviewsAndRatings) ...[
          TextView(
            text:
                controller.isFromProductDetails ? strAddVideos : strEditVideos,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(top: margin_16, bottom: margin_16),
          _uploadVideoInfo(),
        ],
        if (controller.argument != strEditReviewsAndRatings) ...[
          TextView(
            text:
                controller.isFromProductDetails ? strAddVideos : strEditVideos,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(top: margin_16, bottom: margin_16),
          _uploadVideoInfo(),
        ],
        Form(
          key: ratingReviewFormGlobalKey,
          child: Column(
            children: [
              TextFieldWidget(
                validate: (value) => FieldChecker.fieldChecker(
                    value: value, message: strFieldRequired),
                textController: controller.textEditingController,
                labelSize: font_14,
                labelColor: AppColors.pricesColor,
                label: controller.isFromProductDetails
                    ? strAddHeadline
                    : strEditHeadline,
                hint: strEnterareviewheadline,
              ).paddingSymmetric(vertical: margin_16),
              TextFieldWidget(
                validate: (value) => FieldChecker.fieldChecker(
                    value: value, message: strFieldRequired),
                textController: controller.reviewEditingController,
                minLine: 5,
                maxLines: 10,
                labelSize: font_14,
                labelColor: AppColors.pricesColor,
                label: strAddReviews,
                hint: strEnterafullreview,
              ),
            ],
          ),
        )
      ],
    ).paddingAll(margin_20);
  }

  _ratingInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: strOverallRating,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(bottom: margin_4),
          Row(children: [
            RatingBar.builder(
              initialRating: controller.isRouteForEditReview == true
                  ? controller.reviewRatingData.ratings.toDouble()
                  : 1,
              itemSize: 35,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColors.gradient2nd,
              ),
              onRatingUpdate: (rating) {
                controller.isRouteForEditReview == true
                    ? controller.reviewRatingData.ratings = rating
                    : controller.rating.value = rating;
                controller.update();
                debugPrint("rating is:--${controller.rating}");
              },
            ),
            TextView(
              text: controller.isRouteForEditReview == true
                  ? controller.reviewRatingData.ratings.toString()
                  : "${controller.rating.value}",
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.lightBlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: font_28),
            ).paddingOnly(left: margin_8),
          ]),
        ],
      );

  _uploadImageInfo() => SizedBox(
        height: height_80,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.selectImages();
                controller.update();
              },
              child: DottedBorder(
                  color: AppColors.textfieldborder,
                  strokeWidth: 2,
                  child: Container(
                      width: width_80,
                      height: height_80,
                      padding: EdgeInsets.all(margin_20),
                      decoration:
                          const BoxDecoration(color: AppColors.Alabaster),
                      child: const AssetSVGWidget(
                        iconsUploadImage,
                      ))),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: (controller.isRouteForEditReview == true &&
                        controller.reviewRatingData.images != null)
                    ? controller.reviewRatingData.images?.length ?? 0
                    : (controller.isRouteForEditReview == true &&
                            controller.reviewRatingData.images == null)
                        ? controller.uploadedImageFileList.length
                        : controller.uploadedImageFileList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      (controller.isRouteForEditReview == true &&
                              controller.reviewRatingData.images != null)
                          ? InkWell(
                              child: NetworkImageWidget(
                                imageUrl:
                                    controller.reviewRatingData.images![index],
                                imageHeight: height_135,
                                imageWidth: height_80,
                                radiusAll: radius_8,
                                imageFitType: BoxFit.cover,
                              ),
                              onTap: () {
                                Get.dialog(ImagePreviewWidget(
                                    imageProvider: controller
                                            .reviewRatingData.images![index] ??
                                        ''));
                              },
                            )
                          : (controller.isRouteForEditReview == true &&
                                  controller.reviewRatingData.images == null)
                              ? InkWell(
                                  child: Image.file(
                                    File(controller
                                        .uploadedImageFileList[index].path),
                                    fit: BoxFit.cover,
                                    height: height_135,
                                    width: height_80,
                                  ),
                                  onTap: () {
                                    Get.dialog(LocalImagePreviewWidget(
                                      imageProvider: controller
                                              .uploadedImageFileList[index]
                                              .path ??
                                          '',
                                      isNetworkImage: false,
                                    ));
                                  },
                                )
                              : InkWell(
                                  child: Image.file(
                                    File(controller
                                        .uploadedImageFileList[index].path),
                                    fit: BoxFit.cover,
                                    height: height_135,
                                    width: height_80,
                                  ),
                                  onTap: () {
                                    Get.dialog(LocalImagePreviewWidget(
                                      imageProvider: controller
                                              .uploadedImageFileList[index]
                                              .path ??
                                          '',
                                      isNetworkImage: false,
                                    ));
                                  },
                                ),
                      Positioned(
                          right: 0,
                          child: Container(
                              padding: EdgeInsets.all(margin_4),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radius_20))),
                              child: InkWell(
                                  onTap: () {
                                    controller.unselectImage(index);
                                    controller.update();
                                  },
                                  child: const AssetSVGWidget(
                                      Assets.iconsNewcross))))
                    ],
                  ).paddingSymmetric(horizontal: margin_8);
                },
              ),
            )
          ],
        ),
      );
  _uploadVideoInfo() => SizedBox(
        height: height_80,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.selectVideos();
                controller.update();
              },
              child: DottedBorder(
                  color: AppColors.textfieldborder,
                  strokeWidth: 2,
                  child: Container(
                      width: width_80,
                      height: height_80,
                      padding: EdgeInsets.all(margin_20),
                      decoration:
                          const BoxDecoration(color: AppColors.Alabaster),
                      child: const AssetSVGWidget(
                        iconsUploadImage,
                      ))),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: (controller.isRouteForEditReview == true &&
                        controller.reviewRatingData.videos != null)
                    ? controller.reviewRatingData.videos?.length ?? 0
                    : (controller.isRouteForEditReview == true &&
                            controller.reviewRatingData.videos == null)
                        ? controller.uploadedVideoFileList.length
                        : controller.uploadedVideoFileList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      (controller.isRouteForEditReview == true &&
                              controller.reviewRatingData.videos != null)
                          ? VideoPreviewWidget(
                              mediaFile: MediaFile(
                                  networkPath: controller
                                      .reviewRatingData.videos?[index]),
                              height: height_135,
                              width: height_80,
                        padding: 60,

                            )
                          : (controller.isRouteForEditReview == true &&
                                  controller.reviewRatingData.videos == null)
                              ? VideoPreviewWidget(
                                  mediaFile: MediaFile(
                                      localPath: controller
                                          .uploadedVideoFileList[index].path),
                                  height: height_135,
                                  width: height_80,
                        padding: 60,
                                )
                              : VideoPreviewWidget(
                                  mediaFile: MediaFile(
                                      localPath: controller
                                          .uploadedVideoFileList[index].path),
                                  height: height_135,
                                  width: height_80,
                        padding: 60,
                                ),
                      Positioned(
                          right: 0,
                          child: Container(
                              padding: EdgeInsets.all(margin_4),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radius_20))),
                              child: InkWell(
                                  onTap: () {
                                    controller.unselectVideo(index);
                                    controller.update();
                                  },
                                  child: const AssetSVGWidget(
                                      Assets.iconsNewcross))))
                    ],
                  ).paddingSymmetric(horizontal: margin_8);
                },
              ),
            )
          ],
        ),
      );
}
