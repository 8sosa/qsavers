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

import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/modules/home/models/data_model/main_search_data_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';

import '../../../core/widget/search_text_field.dart';
import '../../../export.dart';

class SearchOnHomeScreen extends StatelessWidget {
  final controller = Get.put(SearchOnHomeController());
  final themeController = Get.put(ThemeController());

  SearchOnHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchOnHomeController>(
        init: SearchOnHomeController(),
        builder: (context) {
          return Scaffold(
              appBar: CustomAppBar(
                  isCustom: true,
                  titleWidget: searchBarField(),
                  isBottomWidget: (controller.isForForumsSearching ||
                          controller.isForFilterScreen ||
                          controller.isForAddMembers ||
                          controller.isForSearchBrand ||
                          controller.forBank)
                      ? false
                      : true,
                  bottomWidget: TabBar(
                    controller: controller.tabController,
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.8),
                    labelColor: Colors.white,
                    labelStyle: textStyleTitleLarge().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w600),
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) => controller.onTabChanged(index),
                    tabs: const [
                      Tab(text: strProducts),
                      Tab(text: strCampaigns),
                      Tab(text: strVendors)
                    ],
                  )),
              body: searchList(controller.isForForumsSearching
                  ? controller.searchGroupResponseModel.data
                  : controller.isForFilterScreen
                      ? controller.vendorSearchResponseModel.data?.data
                      : controller.isForAddMembers
                          ? controller.addMemberResponseModel.data
                          : controller.isForSearchBrand
                              ? controller.brandListResponseModel.data?.data
                              : controller.forBank
                                  ? controller
                                      .countrySelectionResponseModel.data?.data
                                  : controller.mainSearchResponseModel.data));
        });
  }

  Widget searchBarField() => Container(
        margin:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_12),
        child: SearchTextFieldWidget(
          borderRadius: radius_8,
          borderColor: Colors.black,
          focusNode: controller.searchFieldFocusNode,
          textController: controller.searchFieldText,
          onChange: (text) {
            controller.updateSuffixIconVisibility();
          },
          prefixIcon: UnconstrainedBox(
            child: AssetSVGWidget(
              iconsSearchgray,
              imageHeight: height_20,
              imageWidth: width_20,
            ).paddingSymmetric(horizontal: margin_10),
          ),
          hint: controller.isForForumsSearching
              ? "Search forums..."
              : controller.isForFilterScreen == true
                  ? "Search Vendor..."
                  : controller.isForAddMembers == true
                      ? "Search Member..."
                      : controller.isForSearchBrand == true
                          ? "Search Brand"
                          : controller.forBank == true
                              ? "Search Country"
                              : "Search for products, brands and...",
          suffixIcon: Visibility(
            visible: controller.showSuffixIcon.value,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey.shade700),
              onPressed: () {
                controller.clearSearchField();
              },
            ),
          ),
          hintStyle: textStyleBodyMedium().copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontSize: font_14),
        ),
      );

  Widget searchList(dynamic data) {
    if (controller.isForSearchBrand == false &&
        controller.isForFilterScreen == false) {
      if (data == null || data.isEmpty) {
        return Center(child: _noCouponScreen());
      }
    }
    if(controller.forBank==true)
      {
        return Container(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data?.length ?? 0,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.textfieldborder,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                 onTap: ()
                {
                  Get.back(result: {
                    argIndex: index,
                    argCountry:
                    controller.countrySelectionResponseModel.data?.data?[index].country
                  });
                },
                child: _countryListItem(data?[index]),
              );
            },
          ).paddingOnly(left: margin_30),
        );
      }

    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data?.length ?? 0,
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.textfieldborder,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (controller.isForForumsSearching) {
                      Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
                        argIsSearchedForum: true,
                        argIsSearchedForumCampaign: true,
                        argGroupId: data?[index]?.sId,
                        argForumGroupType: data?[index]?.groupType
                      });
                    } else if (controller.isForFilterScreen) {
                      Get.back(result: {
                        argIndex: index,
                        argSellerId: controller
                            .vendorSearchResponseModel.data?.data?[index].sId
                      });
                    } else if (controller.isForSearchBrand) {
                      Get.back(result: {
                        argIndex: index,
                        argBrandId:
                            controller.brandListResponseModel.data?.data?[index].sId
                      });
                    } /*else if (controller.isForAddMembers) {
                      Get.back(result: {
                        argIndex: index,
                        argSellerId:
                            controller.addMemberResponseModel.data?[index].sId
                      });
                    }*/ else if (controller.mainSearchResponseModel.data?[index].type ==
                        "CATEGORY") {
                      filterSelectctedData = FilterCampaignData(
                        categoryId:
                            controller.mainSearchResponseModel.data?[index].sId,
                      );

                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                        argForViewVendorsProduct: strDealsOfDay,
                        argTitle:
                            controller.mainSearchResponseModel.data?[index].name,
                        argCategoryId:
                            controller.mainSearchResponseModel.data?[index].sId,
                        argSearchScreen: true
                      } /*,preventDuplicates: false*/);
                    }
                    else if (controller.mainSearchResponseModel.data?[index].type ==
                        "PRODUCTS") {
                      if(controller.addMember==false)
                        {
                          Get.toNamed(AppRoutes.productsDetailsScreenRoute, arguments: {
                            argProductId:
                            controller.mainSearchResponseModel.data?[index].sId,
                            argSearchScreen: true,
                          });
                          debugPrint(
                              "id is ${controller.mainSearchResponseModel.data?[index].sId}");
                        }

                    } else if (controller.mainSearchResponseModel.data?[index].type ==
                        "SUB_CATEGORY") {
                      filterSelectctedData = FilterCampaignData(
                        categoryId: controller
                            .mainSearchResponseModel.data?[index].categoryId,
                      );

                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                        // argId:controller.mainSearchResponseModel.data?[index].sId,
                        argCategoryId: controller
                            .mainSearchResponseModel.data?[index].categoryId,
                        argTitle:
                            controller.mainSearchResponseModel.data?[index].name,
                        argForViewVendorsProduct: strDealsOfDay,
                        argSearchScreen: true
                      });
                    } else if (controller.mainSearchResponseModel.data?[index].type ==
                        "BRANDS") {
                      filterSelectctedData = FilterCampaignData(
                        brandId: controller.mainSearchResponseModel.data?[index].sId,
                      );

                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                        // argId:controller.mainSearchResponseModel.data?[index].sId,
                        argBrandId:
                            controller.mainSearchResponseModel.data?[index].sId,
                        argTitle:
                            controller.mainSearchResponseModel.data?[index].name,
                        argForViewVendorsProduct: strDealsOfDay,
                        argSearchScreen: true
                      });
                    } else if (controller.mainSearchResponseModel.data?[index].type ==
                        "SUB_SUB_CATEGORIES") {
                      filterSelectctedData = FilterCampaignData(
                        categoryId: controller
                            .mainSearchResponseModel.data?[index].categoryId,
                        subcategoryId: controller
                            .mainSearchResponseModel.data?[index].subCategoryId,
                      );
                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                        // argId:controller.mainSearchResponseModel.data?[index].sId,
                        argCategoryId: controller
                            .mainSearchResponseModel.data?[index].categoryId,
                        argSubCategoryId: controller
                            .mainSearchResponseModel.data?[index].subCategoryId,
                        argTitle:
                            controller.mainSearchResponseModel.data?[index].name,
                        argForViewVendorsProduct: strDealsOfDay,
                        argSearchScreen: true
                      });
                    } else if (controller.mainSearchResponseModel.data?[index].type ==
                        "CAMPAIGNS") {
                      controller.handleCampaigns(index);
                    } else if (controller.mainSearchResponseModel.data?[index].type ==
                        "sellers") {
                      filterSelectctedData = FilterCampaignData(
                          sellerId:
                              controller.mainSearchResponseModel.data?[index].sId);
                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                        argSellerId:
                            controller.mainSearchResponseModel.data?[index].sId,
                        argTitle:
                            controller.mainSearchResponseModel.data?[index].name,
                        argForViewVendorsProduct: strForVendors,
                        argSearchScreen: true
                      });
                    }
                  },
                  child: _searchListItem(data?[index], index),
                );
              },
            ).paddingOnly(left: margin_30),
          ),
        ),
        if(controller.addMember==true)...[
          BottomButtonWidget(
            onPressed: () {
              FocusScope.of(Get.context!).unfocus;
              controller.searchFieldFocusNode.unfocus();
              Future.delayed(const Duration(milliseconds: 200), () {
                debugPrint("selectednewmwmbwrsid is ${controller.selectedMembersIds}");
                Get.back(result: {
                  argSelectedMembers: controller.selectedMembersIds
                });
              });
            },
            btnTitle: "NEXT",
          ),

        ]

      ],
    );
  }

  _noCouponScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: controller.addMember == true
                  ? "No User Found"
                  : "No Data Found",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  _searchListItem(dynamic data, int index)
  {
   return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      if (controller.isForForumsSearching) ...[
        SizedBox(
          height: height_30,
          width: width_30,
          child: AssetSVGWidget(
            data?.groupType == strPrivate
                ? iconsIconsLockClose
                : iconsLockOpen,
            imageHeight: height_30,
            imageWidth: width_30,
            imageFitType: BoxFit.contain,
          ),
        )
      ],
      if (!controller.isForForumsSearching &&
          controller.isForSearchBrand == false &&
          controller.isForVendors == false &&
          controller.addMember == false) ...[
        SizedBox(
          height: height_30,
          width: width_30,
          child: (data?.type == "CATEGORY" ||
              data?.type == "SUB_CATEGORY" ||
              data?.type == "SUB_SUB_CATEGORIES" ||
              data?.type == "BRANDS")
              ? SizedBox(
            height: height_30,
            width: width_30,
            child: AssetSVGWidget(
              iconsSearching,
              imageHeight: height_30,
              imageWidth: width_30,
              imageFitType: BoxFit.contain,
            ),
          )
              : NetworkImageWidget(
            imageUrl: controller.isForAddMembers == true
                ? data.profilePic ?? ""
                : data?.image ?? "",
            imageHeight: height_30,
            imageWidth: width_30,
            imageFitType: BoxFit.cover,
            placeHolder: iconsProfilePlaceholderL,
          ),
        )
      ],
      if (controller.isForVendors == true) ...[
        NetworkImageWidget(
          imageUrl: controller.isForAddMembers == true
              ? data.profilePic ?? ""
              : data?.image ?? "",
          imageHeight: height_30,
          imageWidth: width_30,
          imageFitType: BoxFit.cover,
          placeHolder: iconsProfilePlaceholderL,
        ),
      ],
      if (controller.isForSearchBrand == true) ...[
        SizedBox(
          height: height_30,
          width: width_30,
          child: AssetSVGWidget(
            iconsSearching,
            imageHeight: height_30,
            imageWidth: width_30,
            imageFitType: BoxFit.contain,
          ),
        )
      ],
      if (controller.isForAddMembers == true &&
          controller.addMember == true) ...[
        GestureDetector(
          onTap: ()
          {
            if(controller.isForAddMembers==true && controller.addMember==true)
              {
                controller.onSelectionChange(index, data?.sId);
              }
          },
          child: NetworkImageWidget(
            imageUrl: controller.isForAddMembers == true
                ? data.profilePic ?? ""
                : data?.image ?? "",
            imageHeight: height_30,
            imageWidth: width_30,
            imageFitType: BoxFit.cover,
            placeHolder: iconsProfilePlaceholderL,
          ),
        ),
      ],
      Expanded(
        child: GestureDetector(
          onTap: ()
          {
            if(controller.isForAddMembers==true && controller.addMember==true)
            {
              controller.onSelectionChange(index, data?.sId);
            }
          },
          child: InkWell(
            onTap: ()
            {
              if(controller.isForForumsSearching)
                {
                  Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
                    argIsSearchedForum: true,
                    argIsSearchedForumCampaign: true,
                    argGroupId: data?.sId,
                    argForumGroupType: data?.groupType
                  });
                }
            },
            child: TextView(
              text: controller.isForForumsSearching
                  ? data?.groupName
                  : data?.name,
              textStyle: textStyleTitleLarge().copyWith(
                fontWeight: FontWeight.w500,
                fontSize: font_18,
                color: Colors.black,
              ),
            ).paddingOnly(left: margin_12),
          ),
        ),
      ),
      if (controller.addMember == true) ...[
        SizedBox(
          height: height_20,
          width: width_20,
          child: Checkbox(
            side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(color: AppColors.DustyGray)),
            activeColor: AppColors.gradientColorSecondary,
            shape: const CircleBorder(),
            value: data?.isSelected,
            onChanged: (bool? value) {
              controller.onSelectionChange(index, data?.sId);
            },
          ),
        )
      ],
    ],
    ).paddingSymmetric(vertical: margin_15, horizontal: margin_15);
  }

  _countryListItem(dynamic data)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (controller.forBank == true) ...[
          TextView(
            text:
            data?.country,
            textStyle: textStyleTitleLarge().copyWith(
              fontWeight: FontWeight.w500,
              fontSize: font_18,
              color: Colors.black,
            ),
          ).paddingOnly(left: margin_12)
        ],
      ],
    ).paddingSymmetric(vertical: margin_15);
  }

}
