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

import 'package:quantity_savers/app/core/widget/ripple.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../export.dart';

class FiltersScreen extends StatelessWidget {
  final controller = Get.put(FiltersController());
  final themeController = Get.put(ThemeController());

  FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiltersController>(
        init: FiltersController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              onTap: () {
                if (controller.clearedFilters == true) {
                  var data = controller.getFilterData();
                  Get.back(result: data);
                } else {
                  // Get.back();
                  Get.back(result: true);
                }
              },
              appBarTitleText: strFilters.toUpperCase(),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _categoryList(),
                        _subCategoryList(),
                        _childCategoryList(),
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
                        _vendors(),
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

  _categoryList() => controller.categoryList.length != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strCATEGORIES,
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: margin_10),
                itemCount: controller.categoryList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = controller.categoryList[index];
                  return ButtonWidget(
                    onTap: () {
                      controller.selectedCatIndex = index;
                      filterSelectctedData?.categoryId=item.sId;
                      filterSelectctedData?.subcategoryId=null;
                      filterSelectctedData?.subsubcategoryId=null;
                      controller.addDataToSubCategory();
                      controller.update();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: margin_15),
                      decoration: BoxDecoration(
                          color: controller.selectedCatIndex == index
                              ? AppColors.gradient2nd
                              : Colors.white,
                          borderRadius: BorderRadius.circular(margin_4)),
                      child: TextView(
                        text: item.name,
                        textStyle: textStyleTitleLarge().copyWith(
                          fontSize: font_14,
                          color: controller.selectedCatIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ).paddingSymmetric(vertical: margin_10),
                    ),
                  );
                }),
          ],
        ).paddingOnly(left: margin_20, top: margin_20, right: margin_20)
      : emptySizeBox();

  _subCategoryList() => controller.subCatgoryList.length != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "SubCategory".toUpperCase(),
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: margin_10),
                itemCount: controller.subCatgoryList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = controller.subCatgoryList[index];
                  return ButtonWidget(
                    onTap: () {
                      controller.selectedSubCategoryIndex = index;
                      filterSelectctedData?.subcategoryId=item.sId;
                      filterSelectctedData?.subsubcategoryId=null;
                      controller.selectedChildCategoryIndex = -1;
                      controller.addDataToChildCategory();
                      controller.update();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: margin_15),
                      decoration: BoxDecoration(
                          color: controller.selectedSubCategoryIndex == index
                              ? AppColors.gradient2nd
                              : Colors.white,
                          borderRadius: BorderRadius.circular(margin_4)),
                      child: TextView(
                        text: item.name,
                        textStyle: textStyleTitleLarge().copyWith(
                          fontSize: font_14,
                          color: controller.selectedSubCategoryIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ).paddingSymmetric(vertical: margin_10),
                    ),
                  );
                }),
          ],
        ).paddingOnly(left: margin_20, top: margin_20, right: margin_20)
      : emptySizeBox();

  _childCategoryList() => controller.childCategoryList.length != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "SubSubCategory".toUpperCase(),
              textStyle: textStyleTitleLarge().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: margin_10),
                itemCount: controller.childCategoryList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = controller.childCategoryList[index];
                  return ButtonWidget(
                    onTap: () {
                      controller.selectedChildCategoryIndex = index;
                      filterSelectctedData?.subsubcategoryId=item.sId;

                      controller.update();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: margin_15),
                      decoration: BoxDecoration(
                          color: controller.selectedChildCategoryIndex == index
                              ? AppColors.gradient2nd
                              : Colors.white,
                          borderRadius: BorderRadius.circular(margin_4)),
                      child: TextView(
                        text: item.name,
                        textStyle: textStyleTitleLarge().copyWith(
                          fontSize: font_14,
                          color: controller.selectedChildCategoryIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ).paddingSymmetric(vertical: margin_10),
                    ),
                  );
                }),
          ],
        ).paddingOnly(left: margin_20, top: margin_20, right: margin_20)
      : emptySizeBox();



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
                      text: "\$${controller.lowestPrice?.toInt()}",
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
        controller.initialPrice==null?emptySizeBox():  controller.showPrice && (controller.initialPrice??0) > 0.0
              ? SfRangeSlider(
                  activeColor: AppColors.gradient2nd,
                  inactiveColor: AppColors.greyColor.withOpacity(0.3),
                  min: 0,
                  max: 1000,
                  values: SfRangeValues(
                      controller.lowestPrice, controller.maxPrice),
                  onChanged: (SfRangeValues values) {
                     controller.lowestPrice = values.start.toInt();
                     controller.maxPrice = values.end.toInt();
                     controller.setPrice(controller.lowestPrice,controller.maxPrice);
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
              filterSelectctedData?.selectedRating=controller.ratings[index];
              print(4 - controller.selectedRatingIndex);
            },
            child: Row(
              children: [
                (index == controller.selectedRatingIndex.toInt())
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
              filterSelectctedData?.selectedDiscount=controller.discount[index];

              print(4 - controller.selectedRatingIndex);
            },
            child: Row(
              children: [
                (index == controller.selectedDiscountIndex.toInt())
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
                  filterSelectctedData?.sellerId=controller.vendorsResponseModel.data?.data![index].sId;

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
                    (index == controller.selectedVendorIndex?.toInt())
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
                  filterSelectctedData?.brandId=controller.brandListResponseModel.data?.data?[index].sId;

                  controller.onSelectedBrand(index,
                      controller.brandListResponseModel.data?.data?[index].sId);
                },
                child: Row(
                  children: [
                    (index == controller.selectedBrandIndex?.toInt())
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

                var data =controller.getFilterData();
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
