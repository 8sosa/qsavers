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
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/core/widget/image_preview_widget.dart';
import 'package:quantity_savers/app/core/widget/search_navigation_widget.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/product_faq_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/related_product_data_model.dart';
import 'package:quantity_savers/app/modules/Details/widgets/campaign_details_widget_screen.dart';

import '../../../core/widget/googleplacepicker/google_place_picker.dart';
import '../../../core/widget/googleplacepicker/place_autoComplete_model.dart';
import '../../../core/widget/googleplacepicker/place_details_model.dart';
import '../../../core/widget/multiple_image_preview_widget.dart';
import '../../../core/widget/video_player_widget/video_preview_widget.dart';
import '../../../export.dart';

String? productDetailTag;

class ProductDetailsScreen extends StatelessWidget {
  final String tag;
  late ProductDetailsController controller;
  final themeController = Get.put(ThemeController());

  ProductDetailsScreen({super.key, required this.tag}) {
    productDetailTag = tag;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        tag: tag,
        builder: (con) {
          controller = con;
          return WillPopScope(
            onWillPop: () async {
              if (controller.wishListScreen == true) {
                Get.back(result: {argIndex: true});
                return Future.value(true);
              } else {
                Get.back(result: true);
                return true;
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(
                isCustom: true,
                titleWidget: controller.searchScreen == false
                    ? SearchNavigationWidget()
                    : SizedBox(),
                onTap: () {
                  debugPrint("this is pressed");
                  if (controller.wishListScreen == true) {
                    Get.back(result: {argIndex: true});
                  } else {
                    Get.back(result: true);
                    return true;
                  }
                },
              ),
              body: Shimmer(
                  child: ShimmerLoading(
                isImage: true,
                isLoading: controller.isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _showImagesAndLikeOrShare(),
                      if (controller.productDetailsResponseModel.data?.images
                              ?.length ==
                          1) ...[
                        const SizedBox().paddingSymmetric(vertical: margin_12),
                      ] else ...[
                        _dotIndicators(),
                      ],
                      _productTitle(
                          controller.productDetailsResponseModel.data, context),
                      if (controller.productDetailsResponseModel.data
                                  ?.totalRatings !=
                              0 ||
                          controller.productDetailsResponseModel.data
                                  ?.averageRating !=
                              0 ||
                          controller.productDetailsResponseModel.data
                                  ?.totalReviews !=
                              0) ...[
                        _productRatingAndReviewsCount(
                            controller.productDetailsResponseModel.data)
                      ],
                      _productPrice(
                          controller.productDetailsResponseModel.data,
                          controller
                              .productDetailsResponseModel.data?.discountPrice),
                      quantityAndBuyNow(
                          controller.productDetailsResponseModel.data),
                      _divider(),
                      _campaignSection(context),
                      _divider(),
                      highLights(controller.productDetailsResponseModel.data)
                          .paddingOnly(top: margin_20),
                      (Platform.isAndroid)
                          ? SizedBox(height: margin_20)
                          : const SizedBox(),
                      _divider(),
                      deliveringTo()
                          .paddingOnly(top: margin_20, bottom: margin_20),
                      _divider(),
                      services(controller.productDetailsResponseModel.data)
                          .paddingOnly(top: margin_20),
                      (Platform.isAndroid)
                          ? SizedBox(height: margin_20)
                          : const SizedBox(),
                      _divider(),
                      specifications(
                              controller.productDetailsResponseModel.data)
                          .paddingOnly(top: margin_0),
                      _divider(),
                      ratingAndReviews(
                              controller.productDetailsResponseModel.data)
                          .paddingOnly(top: margin_20),
                      _reviewDetailsList(
                          controller.productDetailsResponseModel.data),
                      (controller.productDetailsResponseModel.data?.ratings
                                  ?.length !=
                              0)
                          ? _seeAllReviews()
                          : const SizedBox(),
                      (controller.faqLength != 0)
                          ? _faqS(controller.productFaqResponseModel.data)
                          : const SizedBox(),
                      (controller.faqLength > 5)
                          ? _seeAllFAQs()
                          : const SizedBox(
                              height: 20,
                            ),
                      if (controller
                              .relatedProductResponseModel.data?.totalCount !=
                          0) ...[
                        _relatedProducts(
                            controller.relatedProductResponseModel.data)
                      ]
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }

  _divider() => SizedBox(
        height: margin_5,
        child: Divider(
          thickness: margin_4,
          color: AppColors.borderColor,
        ),
      );

  Widget searchBarField() => TextFieldWidget(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
        borderColor: Colors.black,
        focusNode: controller.searchFieldFocusNode,
        textController: controller.searchfieldText,
        onChange: (text) {
          controller.updateSuffixIconVisibility();
        },
        prefixIcon:
            const AssetSVGWidget(iconsSearchgray, imageHeight: 1, imageWidth: 1)
                .paddingSymmetric(horizontal: margin_10),
        hint: strSearchForProduct,
        suffixIcon: Visibility(
          visible: controller.showSuffixIcon.value,
          child: IconButton(
            icon: Icon(Icons.close, color: AppColors.DustyGray),
            onPressed: () {
              controller.clearSearchField();
            },
          ),
        ),
        hintStyle: textStyleBodyMedium().copyWith(
            color: AppColors.DustyGray,
            fontWeight: FontWeight.w500,
            fontSize: font_14),
      ).paddingOnly(top: margin_4);

  _showImagesAndLikeOrShare() {
    int imageCount =
        controller.productDetailsResponseModel.data?.images?.length ?? 0;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enableInfiniteScroll: imageCount > 1,
            scrollDirection: Axis.horizontal,
            autoPlay: imageCount > 1,
            onPageChanged: imageCount > 1
                ? (index, reason) {
                    controller.onPageChanged(index);
                  }
                : null,
          ),
          items: List.generate(
            imageCount,
            (index) => GestureDetector(
              onTap: () {
                Get.dialog(MultipleImagePreviewWidget(
                  imageProviders:
                      controller.productDetailsResponseModel.data?.images ?? [],
                  initialIndex: index,
                ));
              },
              child: buildPage(
                  controller.productDetailsResponseModel.data?.images?[index]),
            ),
          ),
        ),
        Positioned(
          top: margin_6,
          right: margin_15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: AssetSVGWidget(
                  controller.productDetailsResponseModel.data?.wishlist == true
                      ? iconsHeartlikered
                      : iconsHeartDisLike,
                ),
                onTap: () {
                  controller.handleWishlist(
                    controller.productDetailsResponseModel.data!.sId,
                    controller.productDetailsResponseModel.data?.wishlist,
                  );
                },
              ),
              SizedBox(height: margin_8),
              GestureDetector(
                child: AssetSVGWidget(iconsShareProduct),
                onTap: () {
                  dynamicLinkingController.generateDeepLink(
                      controller.productId,
                      controller.productDetailsResponseModel.data?.name
                          ?.toString()
                          .toLowerCase());
                },
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(top: margin_20);
  }

  _dotIndicators() => Center(
        child: DotsIndicator(
          dotsCount:
              controller.productDetailsResponseModel.data?.images?.length ?? 1,
          position: controller.currentIndex.toInt(),
          decorator: DotsDecorator(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(color: Colors.black, width: 0.5)),
            // Inactive dot color
            activeColor: Colors.black,
            // Active dot color
            size: const Size.square(10.0),
            // Size of dots
            activeSize: const Size(10.0, 10.0),
            // Size of the active dot
            spacing: const EdgeInsets.all(2.0),
            // Spacing between dots
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ).paddingSymmetric(vertical: margin_12),
      );

  Widget buildPage(dynamic data) {
    return Stack(
      children: [
        NetworkImageWidget(
          imageUrl: data ?? "",
          imageHeight: height_200,
          imageWidth: Get.width,
          imageFitType: BoxFit.contain,
        ),
        Positioned(
          top: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height_16),
            ],
          ),
        ),

        // Add more positioned widgets as needed
      ],
    );
  }

  _productTitle(dynamic data, BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextView(
          maxLines: 4,
          text: (data?.name ?? ""),
          textStyle: textStyleTitleLarge().copyWith(
              color: Colors.black,
              fontSize: font_14,
              fontWeight: FontWeight.w600),
        ).paddingSymmetric(horizontal: margin_22),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildRowWithBulletPoint(
                          'This product is available for purchase at the original price.',
                        ),
                        _buildRowWithBulletPoint(
                          'Choose the listed products on the website or app.',
                        ),
                        _buildRowWithBulletPoint(
                          'Proceed to checkout, enter their shipping and payment information, and complete the purchase.',
                        ),
                        _buildRowWithBulletPoint(
                          'Receive an order confirmation and tracking information for their purchase.',
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(color: AppColors.gradient2nd),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.help_outline,
              color: AppColors.gradient2nd,
            )).paddingOnly(right: margin_15)
      ]);

  _productRatingAndReviewsCount(dynamic data) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (data?.averageRating != 0) ...[
            const AssetSVGWidget(
              iconsRatingStar,
              color: AppColors.gradient2nd,
            ).paddingOnly(top: margin_1),
            TextView(
              text: "${(data?.averageRating.toDouble())}",
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ).paddingSymmetric(horizontal: margin_4)
          ],
          TextView(
                  text:
                      "${(data?.totalReviews != 0 && data?.totalRatings != 0) ? "(" : ""}${data?.totalRatings != 0 ? "${data?.totalRatings} Ratings" : ""} ${(data?.totalReviews != 0 && data?.totalRatings != 0) ? "&" : ""} ${data?.totalReviews != 0 ? "${data?.totalReviews} Reviews" : ""}${(data?.totalReviews != 0 && data?.totalRatings != 0) ? ")" : ""}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14))
              .paddingOnly(top: margin_0)
        ],
      ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);

  _productPrice(dynamic data, dynamic price) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: strPrice.capitalize,
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.DustyGray,
                fontWeight: FontWeight.w500,
                fontSize: font_16),
          ).paddingSymmetric(horizontal: margin_4),
          TextView(
              text: (price != null)
                  ? "\$${price * double.parse(controller.selectedQuantityValue!.value)}"
                  : "\$$price",
              //"\$${(price *  double.parse(controller.selectedQuantityValue!.value)) % 1 != 0 ?(price *  double.parse(controller.selectedQuantityValue!.value)) : (price *  double.parse(controller.selectedQuantityValue!.value)).round()} ",
              //text: price?.toString(),
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_20))
        ],
      ).paddingSymmetric(horizontal: margin_18);

  Widget quantityAndBuyNow(dynamic data) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _selectQuantityDropDown()),
          SizedBox(width: margin_12),
          Expanded(
            child: MaterialButtonWidget(
              minHeight: height_42,
              onPressed: () {
                controller.handleAddToCart();
              },
              textColor: Colors.white,
              buttonText: "BUY NOW".toUpperCase(),
              buttonBgColor: AppColors.gradient2nd,
            ),
          )
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20);

  Widget _campaignSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextView(
              maxLines: 4,
              text: strCampaign,
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ).paddingOnly(left: margin_5),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildRowWithBulletPoint(
                              'Enter a name for the campaign.',
                            ),
                            _buildRowWithBulletPoint(
                              'Select the products to be included in the campaign.',
                            ),
                            _buildRowWithBulletPoint(
                              'Set the discount percentage or fixed amount off the original price.',
                            ),
                            _buildRowWithBulletPoint(
                              'Specify the minimum number of participants required for the campaign to be valid.',
                            ),
                            _buildRowWithBulletPoint(
                              'Provide a detailed description of the campaign, including benefits and terms.',
                            ),
                            _buildRowWithBulletPoint(
                              'Upload any promotional images or videos for the campaign.',
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text(
                              'Close',
                              style: TextStyle(color: AppColors.gradient2nd),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.help_outline,
                  color: AppColors.gradient2nd,
                ))
          ]),
          Row(
            children: [
              TextView(
                text: "Price: ",
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ).paddingOnly(left: margin_5),
              TextView(
                text:
                    "\$${controller.productDetailsResponseModel.data?.wholesalePrice}",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: font_16),
              ),
              TextView(
                text: "\$${controller.productDetailsResponseModel.data?.price}",
                textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.DustyGray,
                  fontWeight: FontWeight.w600,
                  fontSize: font_16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.DustyGray,
                ),
              ).paddingOnly(left: margin_10),
              TextView(
                text:
                    "${(controller.getDiscountPercentage()).toStringAsFixed(2)}% off",
                //   text:  "${controller.formatDiscount(controller.productDetailsResponseModel.data?.discount)}% off",
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.gradient2nd,
                    fontWeight: FontWeight.w600,
                    fontSize: font_16),
              ).paddingOnly(left: margin_10)
            ],
          ).paddingOnly(top: margin_10),
          Container(
            decoration: BoxDecoration(
                color: AppColors.catBackgroundColor,
                borderRadius: BorderRadius.circular(radius_6)),
            child: RichText(
              text: TextSpan(
                  text: "Buy minimum ",
                  style: textStyleLabelLarge().copyWith(
                      color: AppColors.gradient1st,
                      fontWeight: FontWeight.w400,
                      fontSize: font_14),
                  children: [
                    TextSpan(
                      text:
                          "${controller.productDetailsResponseModel.data?.campaignQuantity ?? 0} piece",
                      style: textStyleLabelLarge().copyWith(
                          color: AppColors.gradient2nd,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ),
                    TextSpan(
                      text: " to available this price",
                      style: textStyleLabelLarge().copyWith(
                          color: AppColors.gradient1st,
                          fontWeight: FontWeight.w400,
                          fontSize: font_14),
                    ),
                  ]),
            ).paddingSymmetric(horizontal: margin_15, vertical: margin_4),
          ).paddingOnly(top: margin_20),
          // Container(
          //   child: RichText(
          //     text: TextSpan(
          //         text: strReasonQualification,
          //         style: textStyleLabelLarge().copyWith(
          //             color: AppColors.pricesColor,
          //             fontWeight: FontWeight.w500,
          //             fontSize: font_14),
          //         children: [
          //           TextSpan(
          //             text: "*",
          //             style: textStyleLabelLarge().copyWith(
          //                 color: AppColors.redColor,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 14),
          //           ),
          //         ]),
          //   ).paddingSymmetric(vertical: margin_4),
          // ).paddingOnly(top: margin_20),
          // _selectCampaignDropDown(),
          _campaignBtn(),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const AssetSVGWidget(iconsExclamationGray)
          //         .paddingOnly(right: margin_4),
          //     Expanded(
          //       child: TextView(
          //         text:
          //             "The campaign limit is ${controller.productDetailsResponseModel.data?.campaignLimit}, and ${controller.productDetailsResponseModel.data?.ongoingCampaign} campaigns have already been created.",
          //         textStyle: textStyleLabelLarge().copyWith(
          //             color: AppColors.DustyGray,
          //             fontSize: font_12,
          //             fontWeight: FontWeight.w500),
          //         maxLines: 3,
          //       ),
          //     ),
          //   ],
          // ).paddingOnly(top: margin_10),
          CampaignDetailsWidgetScreen(
                  timerText: controller.timers,
                  data: controller.productCampaignsResponseModel.data ?? [],
                  count: ((controller.productCampaignsResponseModel.data ?? [])
                              .length >
                          3)
                      ? 3
                      : (controller.productCampaignsResponseModel.data ?? [])
                          .length)
              .paddingOnly(top: margin_20),
          if ((controller.productCampaignsResponseModel.data?.length ?? 0) >
              1) ...[
            MaterialButtonWidget(
              minHeight: height_42,
              onPressed: () {
                Get.toNamed(AppRoutes.viewAllCampaignListScreenRoute);
              },
              buttonText: "$strViewAll $strCampaigns".toUpperCase(),
              buttonTextStyle: textStyleTitleMedium().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: font_14,
                  color: AppColors.gradient2nd),
              buttonBgColor: Colors.transparent,
              borderColor: AppColors.gradient2nd,
              borderWidth: 2,
              isOutlined: true,
            )
          ],
          TextView(
            text: "In Stock.",
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.gradient2nd,
                fontSize: font_18,
                fontWeight: FontWeight.w600),
          ).paddingOnly(top: margin_20),
          _soldByRichText(),
          (controller.productDetailsResponseModel.data?.productVariations
                          ?.length ??
                      0) >=
                  2
              ? _itemWithQuantityCard(
                  controller.productDetailsResponseModel.data)
              : SizedBox()
        ],
      ).paddingSymmetric(vertical: margin_20, horizontal: margin_15);

  _selectQuantityDropDown() => DropDownTextFieldWidget(
        borderColor: AppColors.borderColor,
        onFieldSubmitted: (value) {
          controller.onChangeDropDownValueQuantity(value);
        },
        hint: "1",
        Quantity: true,
        hintStyle: textStyleLabelLarge().copyWith(
            color: Colors.black,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.itemsCount,
        selectedItemTextStyle: textStyleLabelLarge().copyWith(
            color: AppColors.pricesColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        selectedValue: controller.selectedQuantityValue?.value,
      );

  _selectCampaignDropDown() => DropDownTextFieldWidget(
        borderColor: AppColors.borderColor,
        onFieldSubmitted: (value) {
          controller.onChangeDropDownValue(value);
        },
        hint: strSelectQualification,
        Quantity: false,
        hintStyle: textStyleLabelLarge().copyWith(
            color: AppColors.categoriesgrey,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.items,
        selectedItemTextStyle: textStyleLabelLarge().copyWith(
            color: AppColors.pricesColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        selectedValue: controller.selectedValue?.value,
      ).paddingOnly(top: margin_10);

  _campaignBtn() {
    var data = controller.productDetailsResponseModel.data;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButtonWidget(
          minHeight: height_42,
          minWidth: height_230,
          onPressed: () {
            if (data?.canCreateCampaign == true) {
              if (data?.createCampaign == false) {
                controller.handleStartCampaign();
              } else {
                showToast(message: "Campaign is already going on");
              }
            } else {
              if (data?.campaignRequest == false) {
                Get.toNamed(AppRoutes.requestCampaignScreenRoute);
              } else {
                showToast(message: "Request already sent");
              }
            }
          },
          buttonText: (data?.canCreateCampaign == true)
              ? strStartCampaign.toUpperCase()
              : strRequestCampaign.toUpperCase(),
          buttonTextStyle: textStyleTitleLarge().copyWith(
            color: (data?.campaignRequest == true)
                ? AppColors.campaignbtnColor
                : ((data?.canCreateCampaign == false) ||
                        (data?.canCreateCampaign == true &&
                            data?.createCampaign == false))
                    ? AppColors.gradient2nd
                    : AppColors.campaignbtnColor,
            fontWeight: FontWeight.w600,
            fontSize: font_14,
          ),
          buttonRadius: font_8,
          buttonBgColor: Colors.transparent,
          borderColor: AppColors.gradient2nd,
          borderWidth: width_1,
          isOutlined: true,
        ),
        const SizedBox(
          width: 8,
        ),
        if (data?.canCreateCampaign == true) ...[
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.aboutCampaignScreenRoute, arguments: {
                argProductDetails: controller.productDetailsResponseModel
              });
            },
            icon: SizedBox(
                width: width_60,
                height: height_42,
                child: const AssetSVGWidget(iconsGreenExclamaitbtn)),
          )
        ]
      ],
    ).paddingOnly(top: margin_20);
  }

  _soldByRichText() => RichText(
        text: TextSpan(
            text: "Sold by ",
            style: textStyleLabelLarge().copyWith(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
            children: [
              TextSpan(
                text:
                    controller.productDetailsResponseModel.data?.addedBy?.name,
                style: textStyleLabelLarge().copyWith(
                    color: Colors.cyan,
                    fontWeight: FontWeight.w600,
                    fontSize: font_14),
              ),
            ]),
      ).paddingOnly(top: margin_15);

  _itemWithQuantityCard(ProductDetailsDataModel? data) => SizedBox(
        height: height_100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data?.productVariations?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                controller.productId =
                    data?.productVariations?[index].productId ?? "";
                controller.hitGetProductsDetailsApi();
                controller.update();
              },
              child: Container(
                width: width_200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(margin_10),
                    border: Border.all(
                      color: (controller.inStockCardSelectedIndex == index)
                          ? AppColors.gradient2nd
                          : AppColors.textfieldborder,
                      width: width_1,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: "${data?.productVariations?[index].name}",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      textStyle: textStyleLabelLarge().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ),
                    TextView(
                      text:
                          "\$${data?.productVariations?[index].discountPrice}",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      textStyle: textStyleLabelLarge().copyWith(
                          color: (controller.inStockCardSelectedIndex == index)
                              ? AppColors.gradient2nd
                              : AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ),
                    Container(
                      width: Get.width,
                      color: AppColors.catBackgroundColor,
                      child: Center(
                        child: TextView(
                          text:
                              "${strQuantity.toUpperCase()}: ${data?.productVariations?[index].quantity}",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: AppColors.gradient2nd,
                              fontSize: font_12,
                              fontWeight: FontWeight.w500),
                        ).paddingSymmetric(vertical: margin_4),
                      ),
                    ).paddingOnly(top: margin_10)
                  ],
                ).paddingSymmetric(horizontal: margin_13),
              ).paddingOnly(right: margin_20),
            );
          },
        ),
      ).paddingOnly(top: margin_20);

  Widget highLights(ProductDetailsDataModel? data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: strHighlights,
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.black,
                fontSize: font_18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Get.width,
            child: ListView.builder(
              itemCount: data?.productHighlights?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctxt, int index) {
                return InkWell(
                  onTap: () {
                    print(index);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text: "\u2022 ",
                        textStyle: textStyleTitleLarge().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Expanded(
                        child: TextView(
                          maxLines: 4,
                          text: data?.productHighlights?[index].content ?? "",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ).paddingOnly(top: margin_10),
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20);

  Widget deliveringTo() {
    String formattedFutureDate = '';
    if (controller.deliveryCheckResponseModel.data?.deliveryTime != null) {
      int? numberOfDaysToAdd =
          controller.deliveryCheckResponseModel.data?.deliveryTime;
      DateTime currentDate = DateTime.now();
      DateTime futureDate = currentDate.add(Duration(days: numberOfDaysToAdd!));
      formattedFutureDate = DateFormat('dd-MM-yyyy').format(futureDate);
    }

    print('Future Date: $formattedFutureDate');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextView(
          text: "Delivering to",
          textStyle: textStyleTitleLarge().copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        placesAutoCompleteTextField(),
        TextView(
          text: controller.check == true
              ? "Delivery by $formattedFutureDate"
              : "Delivery by",
          textStyle: textStyleTitleLarge().copyWith(
              color: AppColors.categoriesgrey,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ).paddingOnly(top: margin_10)
      ],
    ).paddingSymmetric(horizontal: margin_20);
  }

  Widget services(ProductDetailsDataModel? data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: "Services",
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Get.width,
            child: ListView.builder(
              itemCount: data?.productServices?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctxt, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: "\u2022 ",
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Expanded(
                      child: /*TextView(
                        maxLines: 4,
                        text: data?.productServices?[index].content ?? "",
                        textStyle: textStyleTitleLarge().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),*/
                          TextView(
                        maxLines: 4,
                        text:
                            data?.productServices?[index].content?.isNotEmpty ==
                                    true
                                ? data!.productServices![index].content![0]
                                        .toUpperCase() +
                                    data!.productServices![index].content!
                                        .substring(1)
                                : "",
                        textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: margin_10);
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20);

  // Widget placesAutoCompleteTextField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.white),
  //       borderRadius: BorderRadius.circular(0.0),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: GooglePlaceAutoCompleteTextField(
  //             textEditingController: controller.textEditingController,
  //             focusNode: controller.focusNode,
  //             googleAPIKey: "AIzaSyBBZGsH8PUhQwvuwHjl7KOtvNYE_rE00ww",
  //             inputDecoration: InputDecoration(
  //               hintText: "Search your delivery location",
  //               prefixIcon: const AssetSVGWidget(
  //                 iconsSearchIcon,
  //                 color: AppColors.DustyGray,
  //               ).paddingSymmetric(vertical: margin_10, horizontal: margin_10),
  //               contentPadding: EdgeInsets.all(margin_10),
  //               hintStyle: textStyleBodyMedium().copyWith(
  //                 color: Colors.grey.shade600,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: font_14,
  //               ),
  //               floatingLabelBehavior: FloatingLabelBehavior.always,
  //               fillColor: themeController.isDarkMode.value == true
  //                   ? Colors.black
  //                   : Colors.white,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(radius_10),
  //                 borderSide: BorderSide(
  //                   color: themeController.isDarkMode.value == true
  //                       ? AppColors.appBorderDarkColor
  //                       : AppColors.textfieldborder,
  //                 ),
  //               ),
  //               focusedErrorBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(radius_10),
  //                 borderSide: BorderSide(
  //                   color: themeController.isDarkMode.value == true
  //                       ? AppColors.appBorderDarkColor
  //                       : Colors.red,
  //                 ),
  //               ),
  //               errorBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(radius_10),
  //                 borderSide: BorderSide(
  //                   color: themeController.isDarkMode.value == true
  //                       ? AppColors.appBorderDarkColor
  //                       : Colors.red,
  //                 ),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(radius_10),
  //                 borderSide: BorderSide(
  //                   color: themeController.isDarkMode.value == true
  //                       ? AppColors.appBorderDarkColor
  //                       : AppColors.textfieldborder,
  //                 ),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(radius_10),
  //                 borderSide: BorderSide(
  //                   color: themeController.isDarkMode.value == true
  //                       ? AppColors.appBorderDarkColor
  //                       : AppColors.textfieldborder,
  //                 ),
  //               ),
  //             ),
  //             validate: (value) => FieldChecker.fieldChecker(
  //                 value: value, message: strFieldRequired),
  //             debounceTime: 400,
  //             isLatLngRequired: true,
  //             getPlaceDetailWithLatLng: (PlaceDetails placeDetails) {
  //               if (placeDetails.result != null &&
  //                   placeDetails.result!.addressComponents != null) {
  //                 String cityName = '';
  //                 String stateName = '';
  //                 String countryName = '';
  //
  //                 for (var component
  //                     in placeDetails.result!.addressComponents!) {
  //                   if (component.types != null &&
  //                       component.types!.contains("locality") &&
  //                       component.types!.contains("political")) {
  //                     cityName = component.longName ?? '';
  //                   } else if (component.types != null &&
  //                       component.types!
  //                           .contains("administrative_area_level_1")) {
  //                     stateName = component.longName ?? '';
  //                   } else if (component.types != null &&
  //                       component.types!.contains("country")) {
  //                     countryName = component.longName ?? '';
  //                   }
  //                 }
  //
  //                 String fullAddress = '$cityName, $stateName, $countryName';
  //                 controller.textEditingController.text = fullAddress;
  //               }
  //               controller.update();
  //             },
  //             itemClick: (Prediction prediction) {
  //               controller.textEditingController.text =
  //                   prediction.description ?? "";
  //             },
  //             seperatedBuilder: Divider(),
  //             itemBuilder: (context, index, Prediction prediction) {
  //               return Container(
  //                 padding: EdgeInsets.all(10),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.location_on),
  //                     SizedBox(width: 7),
  //                     Expanded(child: Text("${prediction.description ?? ""}"))
  //                   ],
  //                 ),
  //               );
  //             },
  //             isCrossBtnShown: false,
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             controller.getLocationFromAddress(
  //                 controller.textEditingController.text);
  //             print("check");
  //           },
  //           child: TextView(
  //             text: strCheck,
  //             textStyle: textStyleTitleLarge().copyWith(
  //                 color: AppColors.gradient2nd,
  //                 fontSize: font_14,
  //                 fontWeight: FontWeight.w700),
  //           ).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
  //         ),
  //       ],
  //     ),
  //   ).paddingOnly(top: 20);
  // }
  Widget placesAutoCompleteTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                GooglePlaceAutoCompleteTextField(
                  textEditingController: controller.textEditingController,
                  focusNode: controller.focusNode,
                  googleAPIKey: "AIzaSyBBZGsH8PUhQwvuwHjl7KOtvNYE_rE00ww",
                  inputDecoration: InputDecoration(
                    hintText: "Search your delivery location",
                    prefixIcon: const AssetSVGWidget(
                      iconsSearchIcon,
                      color: AppColors.DustyGray,
                    ).paddingSymmetric(
                        vertical: margin_10, horizontal: margin_10),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (controller.check == true) {
                          controller.textEditingController.text = "";
                          controller.check = false;
                        } else {
                          controller.getLocationFromAddress(
                            controller.textEditingController.text,
                          );
                        }
                        controller.update();

                        print("check");
                      },
                      child: TextView(
                        text: controller.check == false ? "Check" : "Change",
                        textStyle: textStyleTitleLarge().copyWith(
                          color: AppColors.gradient2nd,
                          fontSize: font_14,
                          fontWeight: FontWeight.w700,
                        ),
                      ).paddingSymmetric(
                        vertical: margin_15,
                        horizontal: margin_10,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(margin_10),
                    hintStyle: textStyleBodyMedium().copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: font_14,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: themeController.isDarkMode.value == true
                        ? Colors.black
                        : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(
                        color: themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(
                        color: themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : Colors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(
                        color: themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(
                        color: themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_10),
                      borderSide: BorderSide(
                        color: themeController.isDarkMode.value == true
                            ? AppColors.appBorderDarkColor
                            : AppColors.textfieldborder,
                      ),
                    ),
                  ),
                  // validate: (value) =>
                  //     FieldChecker.fieldChecker(value: value, message: strFieldRequired),
                  debounceTime: 400,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (PlaceDetails placeDetails) {
                    if (placeDetails.result != null &&
                        placeDetails.result!.addressComponents != null) {
                      String cityName = '';
                      String stateName = '';
                      String countryName = '';

                      for (var component
                          in placeDetails.result!.addressComponents!) {
                        if (component.types != null &&
                            component.types!.contains("locality") &&
                            component.types!.contains("political")) {
                          cityName = component.longName ?? '';
                        } else if (component.types != null &&
                            component.types!
                                .contains("administrative_area_level_1")) {
                          stateName = component.longName ?? '';
                        } else if (component.types != null &&
                            component.types!.contains("country")) {
                          countryName = component.longName ?? '';
                        }
                      }

                      String fullAddress =
                          '$cityName, $stateName, $countryName';
                      controller.textEditingController.text = fullAddress;
                    }
                    controller.update();
                  },
                  itemClick: (Prediction prediction) {
                    controller.textEditingController.text =
                        prediction.description ?? "";
                  },
                  seperatedBuilder: Divider(),
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 7),
                          Expanded(
                              child: Text("${prediction.description ?? ""}"))
                        ],
                      ),
                    );
                  },
                  isCrossBtnShown: false,
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(top: 20);
  }

  Widget specifications(ProductDetailsDataModel? data) {
    var count = data?.productdetails?.length ?? 0;
    debugPrint("Count Value is $count");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextView(
          text: strSpecifications,
          textStyle: textStyleTitleLarge().copyWith(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        ListView.builder(
          itemCount:
              controller.isSpecsExpanded ? count : (count > 4 ? 4 : count),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  text: "${data?.productdetails?[index].key}",
                  textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                // TextView(
                //   maxLines: 4,
                //   text: "${data?.productdetails?[index].value}",
                //   textStyle: textStyleTitleLarge().copyWith(
                //     color: Colors.black,
                //     fontWeight: FontWeight.w500,
                //     fontSize: 14,
                //   ),
                // ),
                TextView(
                  maxLines: 4,
                  text: data?.productdetails?[index].value?.isNotEmpty == true
                      ? data!.productdetails![index].value![0].toUpperCase() +
                          data!.productdetails![index].value!.substring(1)
                      : "",
                  textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ).paddingOnly(top: margin_10);
          },
        ),
        count > 4
            ? InkWell(
                onTap: () {
                  controller.isSpecsExpanded = !controller.isSpecsExpanded;
                  controller.update();
                },
                child: Text(
                  controller.isSpecsExpanded ? "Read less..." : "Read more...",
                  style: textStyleTitleLarge().copyWith(
                    color: AppColors.gradient2nd,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ).paddingOnly(top: margin_10),
              )
            : const SizedBox(), // Placeholder to maintain spacing
      ],
    ).paddingSymmetric(horizontal: margin_20, vertical: margin_20);
  }

  Widget ratingAndReviews(ProductDetailsDataModel? data) {
    List<String>? allImages = (data?.ratings ?? [])
        .map((rating) => rating.images)
        .expand((images) => images ?? [])
        .cast<String>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextView(
          text: "Rating & Reviews",
          textStyle: textStyleTitleLarge().copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ).paddingSymmetric(horizontal: margin_20),
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
                          text: "${data?.averageRating}",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: font_24),
                        ),
                        AssetSVGWidget(
                          iconsRatingStar,
                          imageHeight: height_24,
                          imageWidth: width_24,
                          imageFitType: BoxFit.fill,
                          color: AppColors.gradient2nd,
                        )
                      ],
                    ),
                    TextView(
                      text:
                          "${data?.totalRatings} Ratings & ${data?.totalReviews} Reviews",
                      textStyle: textStyleTitleLarge().copyWith(
                          color: AppColors.DustyGray,
                          fontSize: font_14,
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
                          count: "${data?.fiveStarRatings}",
                          value: data?.fiveStarRatings.toDouble())
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(
                      //   icons4star,
                      //   color: AppColors.gradient2nd,
                      // ),
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
                          count: "${data?.fourStarRatings}",
                          value: data?.fourStarRatings.toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(
                      //   icons3star,
                      //   color: AppColors.gradient2nd,
                      // ),
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
                          count: "${data?.threeStarRatings}",
                          value: data?.threeStarRatings.toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(
                      //   icons2star,
                      //   color: AppColors.gradient2nd,
                      // ),
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
                          count: "${data?.twoStarRatings}",
                          value: data?.twoStarRatings.toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const AssetSVGWidget(
                      //   icons1star,
                      //   color: AppColors.gradient2nd,
                      // ),
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
                          count: "${data?.oneStarRatings}",
                          value: data?.oneStarRatings.toDouble())
                    ],
                  ).paddingOnly(top: margin_4),
                ],
              ),
            )
          ],
        ).paddingOnly(top: margin_20).paddingSymmetric(horizontal: margin_20),
        MaterialButtonWidget(
          minHeight: height_42,
          onPressed: () {
            controller.handleRateProduct();
          },
          buttonText: strRateProduct.toUpperCase(),
          buttonTextStyle: textStyleTitleLarge().copyWith(
              color: AppColors.gradient2nd,
              fontWeight: FontWeight.w600,
              fontSize: radius_14),
          buttonRadius: radius_2,
          buttonBgColor: Colors.transparent,
          borderColor: AppColors.textfieldborder,
          borderWidth: width_1,
          isOutlined: true,
        ).paddingOnly(top: margin_20).paddingSymmetric(horizontal: margin_20),
        Container(child: _ratingReviewDivider())
            .paddingSymmetric(horizontal: margin_20),
        if (allImages.isEmpty) ...[Container()]
      ],
    );
  }

  _rangeBar({count, value}) {
    return Row(
      children: [
        SizedBox(
          width: Get.width / 6,
          height: height_5,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(margin_3)),
            child: LinearProgressIndicator(
              value: value ?? 0.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gradient2nd),
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

  _ratingReviewDivider() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: AppColors.borderColor,
        ),
      ).paddingSymmetric(vertical: margin_10);

  _reviewVideosList(List<String>? videos, var rating) => SizedBox(
        width: Get.width,
        height: 184,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videos?.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return InkWell(
              onTap: () {},
              child: _reviewVideos(videos?[index], rating),
            ).paddingOnly(right: margin_10);
          },
        ),
      ).paddingOnly(top: margin_20);

  _reviewVideos(String? video, var rating) => Stack(
        children: [
          VideoPreviewWidget(
            mediaFile: MediaFile(networkPath: video),
            height: height_160,
            width: height_130,
            autoplay: true,
            padding: 65,
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
                )),
          )
        ],
      );

  _reviewImagesList(List<String> images) => SizedBox(
        width: Get.width,
        height: 184,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.dialog(
                    ImagePreviewWidget(imageProvider: images[index] ?? ''));
              },
              child: NetworkImageWidget(
                imageUrl: images[index] ?? "",
                imageHeight: height_160,
                imageWidth: height_130,
                imageFitType: BoxFit.cover,
                radiusAll: 10,
              ),
            ).paddingOnly(right: margin_10);
          },
        ),
      ).paddingOnly(top: margin_15);

  _reviewDetailsList(ProductDetailsDataModel? data) => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: min(data?.ratings?.length ?? 0, 5),
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          debugPrint("Iddd is ${data?.ratings?[index].sId}");
          return _reviewDetail(data?.ratings?[index]);
        },
      );

  _reviewDetail(dynamic rating) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: rating?.ratings.toDouble(),
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
              // _ratingStars(stars: rating?.ratings, heightOfStar: height_14),
              Flexible(
                child: TextView(
                  text: "${rating?.title}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: font_14,
                      fontWeight: FontWeight.w500),
                ).paddingOnly(left: 10, top: 5),
              ),
            ],
          ),
          TextView(
            maxLines: 100,
            text: "${rating?.description}",
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.lightBlackColor,
                fontWeight: FontWeight.w400,
                fontSize: font_14),
          ).paddingSymmetric(vertical: margin_10),
          if (rating?.images?.length != null && rating?.images != null) ...[
            rating?.images?.length > 0
                ? _reviewImagesList(rating?.images)
                : const SizedBox(),
          ],
          if (rating?.videos?.length != null && rating?.videos != null) ...[
            rating?.videos?.length > 0
                ? _reviewVideosList(rating?.videos, rating?.ratings)
                : const SizedBox(),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextView(
                text: rating?.userId?.name ?? "Unknown",
                textStyle: textStyleTitleLarge().copyWith(
                    fontSize: font_14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.DustyGray),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: height_14,
                width: width_5,
                child: const VerticalDivider(
                  indent: 2,
                  thickness: 1,
                  color: AppColors.DustyGray,
                ),
              ),
              TextView(
                text:
                    " ${convertMillisecondsToTimeAgo(int.parse(rating?.createdAt))}",
                textStyle: textStyleTitleLarge().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.DustyGray),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  controller.hitProductReviewLikeAndDislikeApi(
                      rating?.sId, "LIKE");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    rating?.userLikeStatus == "LIKE"
                        ? const AssetSVGWidget(
                            iconsThumbUp,
                            color: AppColors.gradient2nd,
                          )
                        : const AssetSVGWidget(iconsThumbUp),
                    (rating?.likesCount ?? 0) > 0
                        ? TextView(
                            text: "${rating?.likesCount ?? 0}",
                            textStyle: textStyleTitleLarge().copyWith(
                              color: AppColors.categoriesgrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ).paddingOnly(left: margin_10)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  controller.hitProductReviewLikeAndDislikeApi(
                      rating?.sId, "DISLIKE");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    rating?.userLikeStatus == "DISLIKE"
                        ? const AssetSVGWidget(
                            iconsThumbDown,
                            color: AppColors.gradient2nd,
                          )
                        : const AssetSVGWidget(iconsThumbDown),
                    (rating?.dislikeCount ?? 0) > 0
                        ? TextView(
                            text: "${rating?.dislikeCount ?? 0}",
                            textStyle: textStyleTitleLarge().copyWith(
                                color: AppColors.categoriesgrey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ).paddingOnly(left: margin_10)
                        : SizedBox()
                  ],
                ).paddingOnly(left: margin_20),
              )
            ],
          ).paddingOnly(top: margin_15),
          _ratingReviewDivider()
        ],
      ).paddingSymmetric(horizontal: margin_20);

  _questionsLikesCount({count, id, like}) {
    return InkWell(
      onTap: () {
        controller.hitLikeProductFaq(id, "LIKE");
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          like == true
              ? const AssetSVGWidget(
                  iconsThumbUp,
                  color: AppColors.gradient2nd,
                )
              : const AssetSVGWidget(iconsThumbUp),
          count > 0
              ? TextView(
                  text: "$count",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.categoriesgrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ).paddingOnly(left: margin_10)
              : emptySizeBox()
        ],
      ),
    );
  }

  _questionsDisLikesCount({count, id, dislike}) => InkWell(
        onTap: () {
          controller.hitLikeProductFaq(id, "DISLIKE");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dislike == true
                ? const AssetSVGWidget(
                    iconsThumbDown,
                    color: AppColors.gradient2nd,
                  )
                : const AssetSVGWidget(iconsThumbDown),
            count > 0
                ? TextView(
                    text: "$count",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ).paddingOnly(left: margin_10)
                : SizedBox()
          ],
        ).paddingOnly(left: margin_20),
      );

  _ratingStars({stars, heightOfStar}) => SizedBox(
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

  _seeAllReviews() => InkWell(
        onTap: () async {
          var result = await Get.toNamed(AppRoutes.viewAllReviewsScreenRoute,
              arguments: {
                argProductId: controller.productDetailsResponseModel.data?.sId
              });
          if (result != null && result[argIndex] == true) {
            debugPrint("Result is $result");
            controller.hitGetProductsDetailsApi(showLoader: false);
          }
        },
        child: Column(
          children: [
            // _ratingReviewDivider(),
            Row(
              children: [
                TextView(
                  text: "See all reviews",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontSize: font_16,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const AssetSVGWidget(iconsForword,
                    color: AppColors.gradient2nd, imageWidth: 8)
              ],
            ).paddingSymmetric(horizontal: margin_20),
            _ratingReviewDivider()
          ],
        ),
      );

  _faqS(List<ProductFaqDataModel>? data) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "FAQ’s",
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ).paddingOnly(left: margin_20, right: margin_20, bottom: margin_20),
          Divider(
            color: AppColors.borderColor,
          ),
          SizedBox(
            height: 15,
          ),
          _questionAnswerList(data)
        ],
      );

  _questionAnswerList(dynamic data) => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data != null && data.length > 5 ? 5 : data?.length ?? 0,
        padding: EdgeInsets.all(margin_0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _questionAnswersWithLikeUnlike(data?[index]),
              _ratingReviewDivider()
            ],
          );
        },
      );

  _questionAnswersWithLikeUnlike(dynamic data) => Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Q: ",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: Colors.black,
                        fontSize: font_14,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: TextView(
                      text: "${data?.question}",
                      maxLines: 10,
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontSize: font_14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "A: ",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: Colors.black,
                        fontSize: font_14,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: TextView(
                      text: removeAllHtmlTags(data?.answer),
                      maxLines: 10,
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontSize: font_14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: margin_10),
              Row(
                children: [
                  TextView(
                    text: "${data?.sellerId?.name}",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: AppColors.categoriesgrey,
                        fontSize: font_14,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  _questionsLikesCount(
                      count: data?.totalLikes,
                      id: data?.sId,
                      like: data?.isLiked),
                  _questionsDisLikesCount(
                      count: data?.totalDislikes,
                      id: data?.sId,
                      dislike: data?.isDisliked)
                ],
              )
            ],
          ).paddingSymmetric(horizontal: margin_20),
        ],
      );

  _seeAllFAQs() => InkWell(
        onTap: () async {
          var result = await Get.toNamed(AppRoutes.allProductFAQsScreenRoute,
              arguments: {
                argProductId: controller.productId,
                argWishList: true
              });
          if (result != null && result[argIndex] == true) {
            debugPrint("Result is $result");
            controller.hitProductFaqDetailsApi(showLoader: false);
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                TextView(
                  text: "See all FAQ’s",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const AssetSVGWidget(iconsForword,
                    color: AppColors.gradient2nd, imageWidth: 8)
              ],
            ).paddingSymmetric(horizontal: margin_20),
            _ratingReviewDivider()
          ],
        ),
      );

  _relatedProducts(RelatedProductDataModel? data) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Related Products",
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ).paddingOnly(left: margin_20, right: margin_20, bottom: margin_20),
          _relatedProductsList(data)
        ],
      ).paddingOnly(bottom: margin_8);

  _relatedProductsList(RelatedProductDataModel? data) => SizedBox(
        width: Get.width,
        height: height_260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data?.totalCount ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                controller.productId = data?.data?[index].sId;
                controller.update();
                controller.hitGetProductsDetailsApi();
                //  Get.offNamed(AppRoutes.productsDetailsScreenRoute,arguments: {argProductId:data?.data?[index].sId});
              },
              child: _product(data?.data?[index]),
            ).paddingOnly(right: margin_20);
          },
        ),
      ).paddingSymmetric(horizontal: margin_20);

  Widget _product(RelatedProductSubDataModel? data) => SizedBox(
        width: Get.width / 2.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height_150,
              child: Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: data?.images?[0] ?? "",
                    imageHeight: height_135,
                    imageWidth: width_135,
                    imageFitType: BoxFit.fill,
                  ),
                  // Positioned(
                  //   top: 4,
                  //   right: 4,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       // controller.viewWishList = !controller.viewWishList;
                  //       controller.handleWishlist(data?.sId, data?.wishlist);
                  //       controller.update();
                  //     },
                  //     icon: AssetSVGWidget((data?.wishlist == true)
                  //         ? iconsHeartlikered
                  //         : iconsHeartDisLike),
                  //     // icon: controller.viewWishList==true? AssetSVGWidget(iconsHeartlikered):AssetSVGWidget(iconsHeartDisLike)
                  //   ),
                  // ),
                  if (data?.averageRating != 0 && data?.totalReviews != 0) ...[
                    Positioned(
                        bottom: 25,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              if (data?.averageRating != 0) ...[
                                TextView(
                                  text: "${data?.averageRating}",
                                  textStyle: textStyleTitleLarge().copyWith(
                                      color: Colors.black,
                                      fontSize: font_14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const AssetSVGWidget(
                                  iconsRatingStar,
                                  color: AppColors.gradient2nd,
                                ).paddingSymmetric(horizontal: margin_4),
                                const SizedBox(
                                  height: 10,
                                  width: 4,
                                  child: VerticalDivider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                              if (data?.totalReviews != 0) ...[
                                TextView(
                                  text: "${data?.totalReviews}",
                                  textStyle: textStyleTitleLarge().copyWith(
                                      color: Colors.black,
                                      fontSize: font_14,
                                      fontWeight: FontWeight.w600),
                                ).paddingOnly(left: margin_4)
                              ]
                            ],
                          ).paddingSymmetric(
                              vertical: margin_2, horizontal: margin_8),
                        ))
                  ]
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextView(
                maxLines: 1,
                text: "${data?.brandId?.name}",
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w600,
                    fontSize: font_16),
              ),
              IconButton(
                onPressed: () {
                  // controller.viewWishList = !controller.viewWishList;
                  controller.handleWishlist(data?.sId, data?.wishlist);
                  controller.update();
                },
                icon: AssetSVGWidget((data?.wishlist == true)
                    ? iconsHeartlikered
                    : iconsHeartDisLike),
                // icon: controller.viewWishList==true? AssetSVGWidget(iconsHeartlikered):AssetSVGWidget(iconsHeartDisLike)
              ),
            ]),
            TextView(
              maxLines: 1,
              text: "${data?.name}",
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ).paddingOnly(top: margin_4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextView(
                  text: "\$${(data?.discountPrice).toStringAsFixed(2)}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ).paddingOnly(right: margin_10),
                TextView(
                  text: "\$${(data?.price) /*.toStringAsFixed(2)*/}",
                  textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.DustyGray,
                    fontWeight: FontWeight.w600,
                    fontSize: font_14,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.DustyGray,
                  ),
                ).paddingOnly(left: margin_0),
                TextView(
                  text: "${data?.discountPercantage}% off",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w600,
                      fontSize: font_12),
                ).paddingOnly(left: margin_4)
              ],
            ).paddingOnly(top: margin_12)
          ],
        ),
      );

  Widget _buildRowWithBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 12),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('hh:mm a');
    return dateFormat.format(dateTime);
  }
}
