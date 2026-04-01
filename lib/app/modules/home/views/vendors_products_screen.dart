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

import 'package:flutter/cupertino.dart';
import 'package:quantity_savers/app/core/widget/animated_search_bar.dart';
import 'package:quantity_savers/app/core/widget/loading_widget.dart';
import 'package:quantity_savers/app/modules/home/models/data_model/corresponding_products_data_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';
import '../../../export.dart';

class VendorsProductsScreen extends StatelessWidget {
  late VendorsProductsController controller;
  final themeController = Get.put(ThemeController());

  VendorsProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorsProductsController>(
        init: VendorsProductsController(),
        tag: DateTime.now().millisecondsSinceEpoch.toString(),
        builder: (con) {
          controller = con;
          return Scaffold(
            appBar: CustomAppBar(
              titlePrefixIcon:
                  (controller.argForViewVendorsProducts == strForVendors)
                      ? []
                      : null,
              appBarTitleText: controller.isRouteForSubCategory == true
                  ? controller.title.toUpperCase()
                  : controller.tileOfCurrentPage.toUpperCase(),
              actionWidget: [
                if (controller.searchScreen == false) ...[
                  controller.isRouteForSubCategory == true
                      ? SizedBox()
                      : AnimatedSearchBarWidget(
                          folded: controller.folded,
                          onSearchIconTap: () async {
                            if (controller.folded) {
                              // If folded, navigate to the search screen
                              Get.toNamed(AppRoutes.searchOnHomeScreenRoute);
                            }
                            /*if (controller.folded == false) {
                        controller.folded = true;
                        Future.delayed(const Duration(milliseconds: 220), (                ) {
                          controller.tileOfCurrentPage =
                              controller.title.toUpperCase();
                          controller.update();
                        });
                      } */
                            else {
                              controller.folded = false;
                              controller.tileOfCurrentPage = '';
                            }
                            Get.toNamed(AppRoutes.searchOnHomeScreenRoute);
                            controller.update();
                          },
                          onCloseIconTap: () {
                            controller.folded = true;
                            controller.tileOfCurrentPage =
                                controller.title.toUpperCase();
                            controller.update();
                          },
                        )
                ]
              ],
            ),
            body: controller.vendorsProductsResponseModel.data?.totalCount == 0
                ? Column(
                    children: [
                      controller.isRouteForSubCategory == true
                          ? SizedBox()
                          : sortAndFilter(),
                      SizedBox(
                        height: Get.height / 4,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AssetSVGWidget(iconsResultNotFound),
                            TextView(
                              text: "Sorry, no results found!",
                              textStyle: textStyleTitleLarge().copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ).paddingSymmetric(
                                vertical: margin_15, horizontal: margin_15),
                            TextView(
                              text:
                                  "Please check the spelling or try searching for something else.",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textStyle: textStyleTitleLarge().copyWith(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ).paddingOnly(left: 30, right: 30),
                          ],
                        ),
                      ),
                    ],
                  )
                : Shimmer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        controller.isRouteForSubCategory == true
                            ? SizedBox()
                            : sortAndFilter(),
                        SizedBox(
                          height: margin_2,
                          child: Divider(
                            thickness: margin_1,
                            color: AppColors.dividerColor,
                          ),
                        ),
                        productList(
                            controller.vendorsProductsResponseModel.data),
                        controller.isPagination
                            ? const ProgressCircle()
                            : const SizedBox(),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget sortAndFilter() => SizedBox(
        height: height_40,
        child: Row(
          children: [
            Stack(
              children: [
                MaterialButtonWidget(
                  minWidth: Get.width / 2.1,
                  onPressed: () {
                    Get.bottomSheet(bottomSheet());
                  },
                  buttonBgColor: Colors.transparent,
                  buttonText: strSortBy.toUpperCase(),
                  buttonTextStyle: textStyleTitleLarge()
                      .copyWith(fontSize: font_14, fontWeight: FontWeight.w600),
                  iconInRight: true,
                  iconWidget: const AssetSVGWidget(iconsDropDownArrow)
                      .paddingOnly(left: margin_3),
                ),
                if (controller.sorted == false) ...[
                  const Positioned(
                      right: 0,
                      left: 60,
                      top: 10,
                      child: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 10,
                      ))
                ]
              ],
            ),
            const VerticalDivider(
                color: AppColors.borderColor,
                thickness: 1,
                indent: 12,
                endIndent: 12),
            Stack(
              children: [
                MaterialButtonWidget(
                  minWidth: Get.width / 2.1,
                  onPressed: () async {
                    FilterCampaignData filterDaata = FilterCampaignData();
                    if (filterSelectctedData != null) {
                      filterDaata = filterSelectctedData!;
                      filterSelectctedData = filterDaata;
                    } else {
                      if (Get.arguments[argSellerId] != null) {
                        filterSelectctedData = FilterCampaignData(
                            sellerId: Get.arguments[argSellerId]);
                        debugPrint("thisone");
                      } else if (Get.arguments[argBrandId] != null) {
                        filterSelectctedData = FilterCampaignData(
                            brandId: Get.arguments[argBrandId]);
                        debugPrint("secondone");
                      } else {
                        filterSelectctedData = FilterCampaignData(
                            subcategoryId: Get.arguments[argSubCategoryId],
                            categoryId: Get.arguments[argCategoryId]);
                        debugPrint("thirdone");
                      }
                    }

                    var data = await Get.toNamed(
                        AppRoutes.filterCampaignsScreenRoute,
                        arguments: {
                          "categoryId": Get.arguments[argCategoryId] ?? null,
                          "subCategoryId":
                              Get.arguments[argSubCategoryId] ?? null,
                          "sellerId": Get.arguments[argSellerId] ?? null,
                          "brandId": Get.arguments[argBrandId] ?? null,
                          argForVendors: true,
                          argForCampaign: false,
                        });

                    controller.filterParameters = data;
                    if (controller.filterParameters?.sellerId == null &&
                        controller.filterParameters?.categoryId == null &&
                        controller.filterParameters?.subcategoryId == null &&
                        controller.filterParameters?.subsubcategoryId == null &&
                        controller.filterParameters?.highestPrice == null &&
                        controller.filterParameters?.lowestPrice == null &&
                        controller.filterParameters?.brandId == null &&
                        controller.filterParameters?.selectedRating == null &&
                        controller.filterParameters?.selectedDiscount == null) {
                      debugPrint("Data is null");
                      controller.hitGetVendorsProductsApi();
                    }
                    else
                      {
                        controller.hitGetVendorsFilteredProductsApi();
                      }


                    /*
                    if (controller.filterParameters?.isFilterApply == true) {
                      controller.filter = true;
                      controller.hitGetVendorsFilteredProductsApi();
                    } else if (controller.filterParameters?.isFilterApply ==
                        false) {
                      controller.filter = false;
                      controller.filterValuesUpdate();
                      controller.hitGetVendorsProductsApi();
                    }*/

                    controller.update();
                  },
                  buttonBgColor: Colors.transparent,
                  buttonText: "FILTERS".toUpperCase(),
                  buttonTextStyle: textStyleTitleLarge()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                if (filterSelectctedData != null) ...[
                  const Positioned(
                      right: 0,
                      left: 60,
                      top: 10,
                      child: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 10,
                      ))
                ]
              ],
            )
          ],
        ),
      );

  Widget bottomSheet() => GetBuilder<VendorsProductsController>(
        init: VendorsProductsController(),
        builder: (context) {
          return Container(
            width: Get.width,
            height: Get.height / 2.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 4,
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ).paddingOnly(top: margin_13),
                TextView(
                  text: "Sort By",
                  textStyle: textStyleTitleLarge()
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
                SizedBox(
                  height: margin_2,
                  width: Get.width,
                  child: const Divider(
                    thickness: 1.5,
                    color: AppColors.dividerColor,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.sortByElement.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (controller.sortByElement[index] == "All") {
                          controller.sorted = true;
                          debugPrint("value is${controller.sorted}");
                        } else {
                          controller.sorted = false;
                          debugPrint("value is${controller.sorted}");
                        }
                        controller.onSelectSortByItem(index);
                        Get.back();
                        print(controller.bottomSheetSelectedIndex);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextView(
                                text: controller.sortByElement[index],
                                textStyle: (index ==
                                        controller.bottomSheetSelectedIndex)
                                    ? textStyleTitleLarge().copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)
                                    : textStyleTitleLarge().copyWith(
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                              ),
                              const Spacer(),
                              (index == controller.bottomSheetSelectedIndex)
                                  ? const AssetSVGWidget(iconsRightChecked)
                                  : const SizedBox(),
                            ],
                          ).paddingSymmetric(vertical: margin_15),
                          if ((controller.sortByElement.length - 1) != index)
                            SizedBox(
                              height: margin_3,
                              width: double.infinity,
                              child: const Divider(
                                thickness: 1.5,
                                color: AppColors.dividerColor,
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                    );
                  },
                ).paddingOnly(left: margin_15, right: margin_15),
              ],
            ),
          );
        },
      );

  Widget productList(VendorsProductsDataModel? data) => Expanded(
        child: ShimmerLoading(
          isLoading: controller.isLoading,
          child: controller.isLoading
              ? const LoadingData()
              : GridView.builder(
            key: const PageStorageKey<String>('productList'),
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: .69,
                  ),
                  itemCount: data?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var item = data?.data?[index];
                    return InkWell(
                      onTap: () async {
                        var data = await Get.toNamed(
                            AppRoutes.productsDetailsScreenRoute,
                            arguments: {
                              argProductId: controller
                                  .vendorsProductsResponseModel
                                  .data
                                  ?.data?[index]
                                  .sId,
                            });

                        if (data == true) {
                          controller.hitGetVendorsProductsApi();
                        }
                      },
                      child: ProductCardWidget(
                        ontap: () {
                          bool isAuthorized = controller.handleWishlist(
                              item?.sId, item?.wishlist);
                          if (isAuthorized) {
                            item?.wishlist = !(item?.wishlist ?? false);
                            controller.update();
                          }
                        },
                        rating: "${(item?.averageRating).toStringAsFixed(1)}",
                        name: item?.brandId?.name ?? "",
                        description: item?.name ?? "",
                        discount: "${item?.discountPercantage}",
                        markPrice: "${(item?.price)}",
                        sellingPrice:
                            "${(item?.discountPrice)?.toStringAsFixed(2)}",
                        totalReviews: "${item?.totalReviews}",
                        imageUrl: "${item?.images?[0]}",
                        isOnWishlist: item?.wishlist,
                      ),
                    );
                  },
                ).paddingAll(margin_20),
        ),
      );
}
