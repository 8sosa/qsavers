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

import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../export.dart';
import '../controllers/campaign_filter_controller.dart';

class CampaignFilterScreen extends StatelessWidget {
  final controller = Get.put(CampaignFilterController());
  final themeController = Get.put(ThemeController());

  CampaignFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignFilterController>(
        init: CampaignFilterController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              onTap: () {
                if (controller.clearedFilters == true) {
                  var data = controller.getFilterData();
                  Get.back(result: data);
                } else {
                  Get.back();
                }
              },
              appBarTitleText: controller.title.toUpperCase(),
            ),
            body:
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        controller.forCampaign == false
                            ? TextView(
                          text: "CATEGORIES",
                          textStyle: textStyleTitleLarge().copyWith(
                            fontSize: font_16,
                            fontWeight: FontWeight.w600,
                          ),
                        ).paddingOnly(left: 20, top: 20)
                            : SizedBox(),
                        controller.forCampaign == false &&
                            controller.categoryName != ""
                            ? InkWell(
                          onTap: () {
                            controller
                                .hitCategoryData(controller.categoryId);
                          },
                          child: TextView(
                            text: "${controller.categoryName}",
                            textStyle: textStyleTitleLarge().copyWith(
                              fontSize: font_16,
                              fontWeight: FontWeight.w600,
                            ),
                          ).paddingOnly(left: 20, top: 20),
                        )
                            : SizedBox(),
                        (controller.showDefaultSubcategory == true )
                            ? SizedBox(
                          height: 240,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return subCategoryNames(controller
                                  .productSubCategoryResponseModel
                                  .data
                                  ?.data?[index]
                                  .name,controller
                                  .productSubCategoryResponseModel
                                  .data
                                  ?.data?[index].sId,index);
                            },
                            itemCount: controller
                                .productSubCategoryResponseModel
                                .data
                                ?.totalCount ??
                                0,
                          ),
                        )
                            : SizedBox(),
                        controller.forCampaign == false &&
                            controller.subCategoryName != "" &&
                            controller.showDefaultSubcategory == false && controller.subCategoryId!="" && controller.subCategoryId!=null
                            ? TextView(
                          text: "${controller.subCategoryName}",
                          textStyle: textStyleTitleLarge().copyWith(
                            fontSize: font_16,
                            fontWeight: FontWeight.w600,
                          ),
                        ).paddingOnly(left: 20, top: 20)
                            : SizedBox(),
                        controller.forCampaign == false &&
                            controller.showDefaultSubcategory == false
                            ? subsubCategoryName()
                            : SizedBox(),
                        category(),
                        _priceTitle(),
                        price(),
                        brand(),
                        discountTitle(),
                        controller.showDiscount ? discount() : SizedBox(),
                        _customerRatingTitle(),
                        controller.showRating
                            ? customersRating()
                            : const SizedBox(),
                        controller.showRating
                            ? SizedBox(
                          height: margin_5,
                          child: Divider(
                            thickness: margin_4,
                            color: AppColors.dividerColor,
                          ),
                        )
                            : SizedBox(
                          height: margin_2,
                          child: Divider(
                            thickness: margin_1,
                            color: AppColors.dividerColor,
                          ),
                        ).paddingOnly(top: margin_10),
                        controller.forVendorFiltration
                            ? const SizedBox()
                            : _vendors(),
                        controller.forCampaign == true
                            ? _streamingTitle()
                            : SizedBox(),
                        controller.forCampaign == true
                            ? streamsList()
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
                _bottomButton()
              ],
            ),
          );
        });
  }

  Widget subCategoryNames(var name , var id , int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ()
          {
            controller.subCategoryId=id;
            controller.selectedSubSubCatIndex = -1;
            controller.hitSubSubCategoriesApi(id,index);
            debugPrint("SubCategory Id is ${controller.subCategoryId}");
          },
          child: TextView(
            text: name,
            textStyle: textStyleTitleLarge().copyWith(
              fontSize: font_14,
              fontWeight: FontWeight.w400,
            ),
          ).paddingOnly(left: 30, top: 20),
        ),
        Visibility(child: subsubCategoryName(),visible: controller.tappedIndex==index?true:false)
      ],
    );
  }

  Widget category() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          controller.isShowCategory();
        },
        child: SizedBox(
          height: height_44,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "GENDER",
                  textStyle: textStyleTitleLarge().copyWith(
                    fontSize: font_16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                controller.showCategory
                    ? AssetSVGWidget(
                  iconsFilterDropUp,
                  imageHeight: height_20,
                  imageWidth: width_20,
                  imageFitType: BoxFit.fill,
                )
                    : AssetSVGWidget(
                  iconsFilterDropDown,
                  imageHeight: height_20,
                  imageWidth: width_20,
                  imageFitType: BoxFit.fill,
                ),
              ],
            ),
          ),
        ).paddingSymmetric(horizontal: margin_20),
      ),
      if (controller.showCategory)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount:
          controller.productCategoriesResponseModel.data?.totalCount ??
              0,
          itemBuilder: (BuildContext ctxt, int index) {
            var item = controller.productCategoriesResponseModel.data?.data;
            return GestureDetector(
              onTap: () {
                controller.onSelectCategory(index);
                controller.subCategoryId=null;
                print("SubCategoryIddd is ${controller.subCategoryId}");
                print(controller.selectedCategories);
              },
              child: Row(
                children: [
                  (controller.selectedCatIndex == index)
                      ? const AssetSVGWidget(iconsRadioFill)
                      : const AssetSVGWidget(iconsRadioUnselected),
                  TextView(
                    text: item?[index].name,
                    textStyle: textStyleTitleLarge().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w600,
                        fontSize: font_14),
                  ).paddingOnly(left: margin_20),
                ],
              ).paddingSymmetric(vertical: margin_10),
            );
          },
        ).paddingSymmetric(horizontal: margin_20)
      else
        const SizedBox(),
      controller.showCategory
          ? SizedBox(
        height: margin_5,
        child: Divider(
          thickness: margin_4,
          color: AppColors.dividerColor,
        ),
      )
          : SizedBox(
        height: margin_2,
        child: Divider(
          thickness: margin_1,
          color: AppColors.dividerColor,
        ),
      ).paddingOnly(top: margin_20)
    ],
  ).paddingOnly(top: margin_20);

  _priceTitle() => GestureDetector(
    onTap: () {
      controller.isShowPrice();
    },
    child: SizedBox(
      height: height_44,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strPriceForFilter.capitalize,
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            controller.showPrice
                ? AssetSVGWidget(
              iconsFilterDropUp,
              imageHeight: height_20,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            )
                : AssetSVGWidget(
              iconsFilterDropDown,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            ),
          ],
        ).paddingSymmetric(horizontal: margin_20),
      ),
    ),
  ).paddingSymmetric(vertical: margin_5);

  Widget price() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      controller.showPrice
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "\$${controller.lowestPrice.toInt()}",
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(bottom: 2),
          const Spacer(),
          TextView(
            text: "\$${controller.maxPrice}",
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.pricesColor,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          ).paddingOnly(bottom: 2),
        ],
      ).paddingSymmetric(horizontal: margin_20)
          : const SizedBox(),
      controller.showPrice && controller.initialPrice > 0.0
          ? SfRangeSlider(
        activeColor: AppColors.gradient2nd,
        inactiveColor: AppColors.greyColor.withOpacity(0.3),
        min: 0.0,
        max: controller.initialPrice,
        values: SfRangeValues(
            controller.lowestPrice, controller.maxPrice),
        onChanged: (SfRangeValues values) {
          controller.lowestPrice = values.start.toInt();
          controller.maxPrice = values.end.toInt();
          controller.update();
        },
      )
          : const SizedBox(),
      controller.showPrice
          ? SizedBox(
        height: margin_5,
        child: Divider(
          thickness: margin_4,
          color: AppColors.dividerColor,
        ),
      )
          : SizedBox(
        height: margin_2,
        child: Divider(
          thickness: margin_1,
          color: AppColors.dividerColor,
        ),
      )
    ],
  );

  _customerRatingTitle() => GestureDetector(
    onTap: () {
      controller.isShowRating();
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: strCustomerRatings,
          textStyle: textStyleTitleLarge().copyWith(
            fontSize: font_16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        controller.showRating
            ? AssetSVGWidget(
          iconsFilterDropUp,
          imageHeight: height_20,
          imageWidth: width_20,
          imageFitType: BoxFit.fill,
        )
            : AssetSVGWidget(
          iconsFilterDropDown,
          imageHeight: height_20,
          imageWidth: width_20,
          imageFitType: BoxFit.fill,
        ),
      ],
    ).paddingSymmetric(horizontal: margin_20),
  ).paddingOnly(top: margin_20, bottom: margin_10);

  Widget customersRating() => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: controller.ratings.length,
    itemBuilder: (BuildContext ctxt, int index) {
      return GestureDetector(
        onTap: () {
          controller.onSelectedRating(index);
          print(4 - controller.selectedRating);
        },
        child: Row(
          children: [
            (index == controller.selectedRating.toInt())
                ? const AssetSVGWidget(iconsRadioFill)
                : const AssetSVGWidget(iconsRadioUnselected),
            TextView(
              text: "${controller.ratings[index]}",
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_15),
            const AssetSVGWidget(
              iconsRatingStar,
              color: AppColors.gradient2nd,
            ).paddingOnly(left: margin_10),
            TextView(
              text: "& above",
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_4),
          ],
        ).paddingSymmetric(vertical: margin_8),
      );
    },
  ).paddingSymmetric(horizontal: margin_20);

  discountTitle() => GestureDetector(
    onTap: () {
      controller.isShowDiscount();
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: "Discount",
          textStyle: textStyleTitleLarge().copyWith(
            fontSize: font_16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        controller.showDiscount
            ? AssetSVGWidget(
          iconsFilterDropUp,
          imageHeight: height_20,
          imageWidth: width_20,
          imageFitType: BoxFit.fill,
        )
            : AssetSVGWidget(
          iconsFilterDropDown,
          imageHeight: height_20,
          imageWidth: width_20,
          imageFitType: BoxFit.fill,
        ),
      ],
    ).paddingSymmetric(horizontal: margin_20),
  ).paddingOnly(top: margin_20, bottom: margin_10);

  Widget discount() => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: controller.discount.length,
    itemBuilder: (BuildContext ctxt, int index) {
      return GestureDetector(
        onTap: () {
          controller.onSelectedDiscount(index);
          print(4 - controller.selectedRating);
        },
        child: Row(
          children: [
            (index == controller.selectedDiscount.toInt())
                ? const AssetSVGWidget(iconsRadioFill)
                : const AssetSVGWidget(iconsRadioUnselected),
            TextView(
              text: "${controller.discount[index]}",
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_15),
            TextView(
              text: "% and above",
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_4),
          ],
        ).paddingSymmetric(vertical: margin_8),
      );
    },
  ).paddingSymmetric(horizontal: margin_20);

  _vendorsTitle() => GestureDetector(
    onTap: () {
      controller.isShowVendors();
    },
    child: SizedBox(
      height: height_44,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strVendors,
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            controller.showVendors
                ? AssetSVGWidget(
              iconsFilterDropUp,
              imageHeight: height_20,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            )
                : AssetSVGWidget(
              iconsFilterDropDown,
              imageHeight: height_20,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            ),
          ],
        ).paddingSymmetric(horizontal: margin_20),
      ),
    ),
  ).paddingSymmetric(vertical: margin_5);

  brandTitle() => GestureDetector(
    onTap: () {
      controller.isShowBrand();
    },
    child: SizedBox(
      height: height_44,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "Brand",
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            controller.showBrand
                ? AssetSVGWidget(
              iconsFilterDropUp,
              imageHeight: height_20,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            )
                : AssetSVGWidget(
              iconsFilterDropDown,
              imageHeight: height_20,
              imageWidth: width_20,
              imageFitType: BoxFit.fill,
            ),
          ],
        ).paddingSymmetric(horizontal: margin_20),
      ),
    ),
  ).paddingSymmetric(vertical: margin_5);

  Widget vendorsList() => Column(
    children: [
      TextFieldWidget(
        contentPadding: EdgeInsets.all(margin_10),
        prefixIcon: AssetSVGWidget(
          iconsSearchIcon,
          color: Colors.grey,
          imageFitType: BoxFit.fill,
          imageHeight: height_8,
          imageWidth: width_8,
        ).paddingSymmetric(vertical: margin_8, horizontal: margin_10),
        hint: strSearchForVendors,
        borderRadius: radius_4,
        readOnly: true,
        onTap: () async {
          var result = await Get.toNamed(AppRoutes.searchOnHomeScreenRoute,
              arguments: {argForFilterScreen: true, argForVendors: true});
          if (result != null) {
            controller.onSelectedVendor(
                result[argIndex], result[argSellerId]);
          }
        },
      ).paddingSymmetric(horizontal: margin_20),
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.vendorsResponseModel.data?.data?.length ?? 0,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () {
              controller.onSelectedVendor(index,
                  controller.vendorsResponseModel.data?.data?[index].sId);
            },
            child: Row(
              children: [
                NetworkImageWidget(
                    imageUrl:
                    "${controller.vendorsResponseModel.data?.data?[index].image ?? ''}",
                    radiusAll: radius_20,
                    imageHeight: 40,
                    imageWidth: 40,
                    imageFitType: BoxFit.fill,
                    placeHolder: iconsProfilePlaceholderS),
                TextView(
                  text:
                  "${controller.vendorsResponseModel.data?.data?[index].name ?? ''}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.categoriesgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ).paddingOnly(left: margin_15),
                Spacer(),
                (index == controller.selectedVendor.toInt())
                    ? const AssetSVGWidget(iconsRadioFill)
                    : const AssetSVGWidget(iconsRadioUnselected),
              ],
            ).paddingOnly(top: margin_15),
          );
        },
      ).paddingSymmetric(horizontal: margin_20),
    ],
  ).paddingOnly(bottom: 20);

  Widget BrandList() => Column(
    children: [
      TextFieldWidget(
        contentPadding: EdgeInsets.all(margin_10),
        prefixIcon: AssetSVGWidget(
          iconsSearchIcon,
          color: Colors.grey,
          imageFitType: BoxFit.fill,
          imageHeight: height_8,
          imageWidth: width_8,
        ).paddingSymmetric(vertical: margin_8, horizontal: margin_10),
        hint: "Search Brand",
        borderRadius: radius_4,
        readOnly: true,
        onTap: () async {
          var result = await Get.toNamed(AppRoutes.searchOnHomeScreenRoute,
              arguments: {argForSearchBrand: true});
          if (result != null) {
            controller.onSelectedBrand(
                result[argIndex], result[argBrandId]);
          }
        },
      ).paddingSymmetric(horizontal: margin_20),
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.brandListResponseModel.data?.totalCount ?? 0,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () {
              debugPrint("Pressed");
              controller.onSelectedBrand(index,
                  controller.brandListResponseModel.data?.data?[index].sId);
            },
            child: Row(
              children: [
                (index == controller.selectedBrand.toInt())
                    ? const AssetSVGWidget(iconsRadioFill)
                    : const AssetSVGWidget(iconsRadioUnselected),
                TextView(
                  text:
                  "${controller.brandListResponseModel.data?.data?[index].name ?? ''}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.categoriesgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ).paddingOnly(left: margin_15),
              ],
            ).paddingOnly(top: margin_15),
          );
        },
      ).paddingSymmetric(horizontal: margin_20),
    ],
  ).paddingOnly(bottom: 20);

  Widget subsubCategoryName() => Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller
            .productSubSubCategoryResponseModel.data?.totalCount ??
            0,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () {
              debugPrint("Pressed");
              controller.onSelectSubSubCategory(index);
            },
            child: Row(
              children: [
                (index == controller.selectedSubSubCatIndex.toInt())
                    ? const AssetSVGWidget(iconsRadioFill)
                    : const AssetSVGWidget(iconsRadioUnselected),
                SizedBox(
                  width: 8,
                ),
                TextView(
                  text:
                  "${controller.productSubSubCategoryResponseModel.data?.data?[index].name ?? ''}",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: AppColors.categoriesgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ),
              ],
            ).paddingOnly(top: margin_15),
          );
        },
      ).paddingSymmetric(horizontal: margin_20),
    ],
  );

  _vendors() => Column(
    children: [
      _vendorsTitle(),
      controller.showVendors ? vendorsList() : const SizedBox(),
      controller.showVendors
          ? SizedBox(
        height: margin_5,
        child: Divider(
          thickness: margin_4,
          color: AppColors.dividerColor,
        ),
      )
          : SizedBox(
        height: margin_2,
        child: Divider(
          thickness: margin_1,
          color: AppColors.dividerColor,
        ),
      ),
    ],
  );

  brand() => Column(
    children: [
      brandTitle(),
      controller.showBrand ? BrandList() : const SizedBox(),
      controller.showBrand
          ? SizedBox(
        height: margin_5,
        child: Divider(
          thickness: margin_4,
          color: AppColors.dividerColor,
        ),
      )
          : SizedBox(
        height: margin_2,
        child: Divider(
          thickness: margin_1,
          color: AppColors.dividerColor,
        ),
      ),
    ],
  );

  _streamingTitle() => Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: strStreaming,
          textStyle: textStyleTitleLarge().copyWith(
            fontSize: font_16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ).paddingSymmetric(horizontal: margin_20),
  ).paddingOnly(top: margin_20, bottom: margin_10);

  Widget streamsList() => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: controller.streams.length,
    itemBuilder: (BuildContext ctxt, int index) {
      return GestureDetector(
        onTap: () {
          controller.onSelectedStream(index);
        },
        child: Row(
          children: [
            (index == controller.selectedStreaming.toInt())
                ? const AssetSVGWidget(iconsRadioFill)
                : const AssetSVGWidget(iconsRadioUnselected),
            TextView(
              text: controller.streams[index],
              textStyle: (index == controller.selectedStreaming.toInt())
                  ? textStyleTitleLarge().copyWith(
                  fontWeight: FontWeight.w700, fontSize: font_14)
                  : textStyleTitleLarge().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_15),
          ],
        ).paddingSymmetric(vertical: margin_10),
      );
    },
  ).paddingSymmetric(horizontal: margin_20);

  _bottomButton() => Container(
    decoration: BoxDecoration(
        border: Border(
            top:
            BorderSide(color: AppColors.borderColor, width: margin_1))),
    child: Row(
      children: [
        MaterialButtonWidget(
          minWidth: Get.width / 2.5,
          minHeight: height_40,
          buttonBgColor: AppColors.gradient2nd,
          textColor: Colors.white,
          buttonText: strApply.toUpperCase(),
          onPressed: () {
            debugPrint("ApplyButton is Pressed");
            var data = controller.getFilterData();
            Get.back(result: data);
          },
        ),
        const Spacer(),
        MaterialButtonWidget(
          minWidth: Get.width / 2.5,
          minHeight: height_40,
          borderColor: AppColors.gradient2nd,
          buttonText: strClear.toUpperCase(),
          isOutlined: true,
          buttonBgColor: Colors.transparent,
          textColor: AppColors.gradient2nd,
          onPressed: () {
            controller.clearFilterData();
          },
        )
      ],
    ).paddingAll(margin_20).paddingOnly(bottom: margin_20),
  );
}
