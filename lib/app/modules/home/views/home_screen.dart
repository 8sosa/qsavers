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

import 'package:dots_indicator/dots_indicator.dart';
import 'package:quantity_savers/app/core/widget/network_image.dart';
import 'package:quantity_savers/app/modules/home/models/data_model/vendors_data_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';

import '../../../core/widget/home_timer.dart';
import '../../../export.dart';
import '../widgets/counter_widget.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  final themeController = Get.put(ThemeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: RefreshIndicator(
              color: AppColors.gradient2nd,
              onRefresh: () async {
                await controller.refreshList();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _searchBar(),
                    _topPageBuilder(),
                    SizedBox(height: height_24),
                    itemsCatList(),
                    if (controller.dealOfDayTimerResponseModel.data?.isActive ==
                        true) ...[
                      _dealsOfTheDayScreen(),
                    ],
                    campaigns(),
                    topDeals(),
                    topFashionBrand(),
                    middleBanner(),
                    featuredCategoriesOfWeek(),
                    shopWithUs(),
                    popularVendors(),
                    banner(),
                    bestOnQuantitySaver()
                  ],
                ),
              ),
            ),
          );
        });
  }

  _searchBar() => Container(
        height: height_70,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              colors: [AppColors.gradient1st, AppColors.gradient2nd]),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.searchOnHomeScreenRoute);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_10),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width_24),
                TextView(
                  text: "Search for products, brands and...",
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const Spacer(),
                const Icon(Icons.search,
                    color: AppColors.gradient2nd, size: 24),
                const SizedBox(width: 24)
              ],
            ),
          ),
        ).paddingOnly(
            left: margin_20,
            right: margin_20,
            top: margin_6,
            bottom: margin_20),
      );

  _topPageBuilder() => Container(
        child: controller.topBannerResponseModel.data != null &&
                controller.topBannerResponseModel.data?.dataa?.length != 0
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  InkWell(
                    onTap: () {
                      filterSelectctedData = FilterCampaignData(
                        categoryId: controller
                                .topBannerResponseModel
                                .data
                                ?.dataa?[controller.currentIndex]
                                .categoryId
                                ?.sId ??
                            '',
                        subcategoryId: controller
                                .topBannerResponseModel
                                .data
                                ?.dataa?[controller.currentIndex]
                                .subcategoryId
                                ?.sId ??
                            "",
                      );

                      Get.toNamed(AppRoutes.vendorsProductsScreenRoute,
                          arguments: {
                            argCategoryId: controller
                                    .topBannerResponseModel
                                    .data
                                    ?.dataa?[controller.currentIndex]
                                    .categoryId
                                    ?.sId ??
                                '',
                            argSubCategoryId: controller
                                    .topBannerResponseModel
                                    .data
                                    ?.dataa?[controller.currentIndex]
                                    .subcategoryId
                                    ?.sId ??
                                "",
                            argTitle: controller.topBannerResponseModel.data
                                    ?.dataa?[controller.currentIndex].title ??
                                "",
                            argForViewVendorsProduct: strDealsOfDay,
                          });
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          controller.onPageChanged(index);
                        },
                      ),
                      items: List.generate(
                        controller.topBannerResponseModel.data?.totalCount ?? 0,
                        (index) => buildPage(index),
                      ),
                    ),
                  ),
                  if (controller.topBannerResponseModel.data?.totalCount !=
                          null &&
                      controller.topBannerResponseModel.data?.totalCount !=
                          0) ...[
                    Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: controller.topBannerResponseModel.data
                                        ?.totalCount ==
                                    1
                                ? const SizedBox()
                                : DotsIndicator(
                                    dotsCount: controller.topBannerResponseModel
                                            .data?.totalCount ??
                                        1,
                                    // Number of dots should match the number of pages
                                    position: controller.currentIndex.toInt(),
                                    decorator: DotsDecorator(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: Colors.white, width: 0.5)),
                                      // Inactive dot color
                                      activeColor: Colors.white,
                                      // Active dot color
                                      size: const Size.square(8.0),
                                      // Size of dots
                                      activeSize: const Size(8.0, 8.0),
                                      // Size of the active dot
                                      spacing: const EdgeInsets.all(2.0),
                                      // Spacing between dots
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ).paddingSymmetric(
                                    horizontal: margin_4, vertical: margin_1))
                        .paddingOnly(bottom: margin_6),
                  ]
                ],
              )
            : emptySizeBox(),
      );

  Widget buildPage(int index) {
    debugPrint("Image data is ${controller.topBannerResponseModel.data?.dataa?[index].image}");
    return NetworkImageWidget(
      imageUrl:
          controller.topBannerResponseModel.data?.dataa?[index].image ?? "",
      imageHeight: height_200,
      imageWidth: Get.width,
      imageFitType: BoxFit.contain,
    );
  }

  Widget itemsCatList() => controller.productCategoriesResponseModel.data !=
              null &&
          controller.productCategoriesResponseModel.data?.data?.length != 0
      ? SizedBox(
          height: height_100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
                controller.productCategoriesResponseModel.data?.totalCount ?? 0,
            itemBuilder: (BuildContext context, int index) {
              List<String> Categories = [
                iconsKidd,
                iconsWomenn,
                iconsMenn,
                demoImagesImage10
              ];
              return InkWell(
                onTap: () {
                  // print(index);
                  // var catId = controller
                  //     .productCategoriesResponseModel.data!.data?[index].sId;
                  // Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                  //   argCategoryId: catId,
                  //   argForViewVendorsProduct: strDealsOfDay,
                  //   argTitle: controller
                  //       .productCategoriesResponseModel.data!.data?[index].name
                  // });
                  Get.toNamed(AppRoutes.subCategoryRoute, arguments: {
                    argTitle: controller
                        .productCategoriesResponseModel.data!.data?[index].name,
                    argCategoryId: controller
                        .productCategoriesResponseModel.data!.data?[index].sId
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: height_48,
                      width: height_48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white),
                      child: Center(
                        child: AssetImageWidget(Categories[index]),
                      ),
                    ),
                    SizedBox(height: height_8),
                    TextView(
                        text: controller.productCategoriesResponseModel.data
                            ?.data?[index].name,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_11))
                  ],
                ).paddingSymmetric(horizontal: margin_13),
              );
            },
          ),
        )
      : emptySizeBox();

  Widget _dealsOfTheDayScreen() {
    var count = controller.dealsOfTheDayResponseModel.data?.totalCount;
    return Visibility(
      visible: ((count != null) ? count : 0) != 0 ? true : false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(thickness: 6, color: AppColors.dividerColor),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextView(
                  text: "Deals of the Day",
                  textStyle: textStyleTitleLarge().copyWith(
                      //color: Colors.red,
                      fontSize: font_16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              _timerOrViewAll(fortimer: true, onTap: () {}),
              _dealOfDayItem(controller.dealsOfTheDayResponseModel.data),
              MaterialButtonWidget(
                minHeight: height_48,
                onPressed: () {
                  Get.toNamed(AppRoutes.viewAllProductsScreenRoute, arguments: {
                    argForViewAllProduct: strDealsOfDay,
                  });
                },
                buttonText: strViewAll,
                buttonTextStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.gradient2nd,
                    fontWeight: FontWeight.w600,
                    fontSize: font_14),
                iconWidget: AssetSVGWidget(iconsForword,
                    imageHeight: height_12, imageWidth: width_12),
                iconInRight: true,
                buttonRadius: 8,
                buttonBgColor: Colors.transparent,
                borderColor: AppColors.borderColor,
                borderWidth: 0.5,
                isOutlined: true,
              ).paddingOnly(top: margin_20, bottom: margin_8),
            ],
          ).paddingAll(margin_20),
        ],
      ),
    );
  }

  _dealOfDayItem(dynamic data) => Visibility(
        visible: data != null && data.totalCount > 0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1 / 1.6,
          ),
          itemCount:
              data != null && data.totalCount > 6 ? 6 : data?.totalCount ?? 0,
          itemBuilder: (context, index) {
            if (index < data?.data?.length) {
              return InkWell(
                onTap: () {
                  filterSelectctedData = FilterCampaignData(
                      categoryId: data?.data[index].categoryId.sId,
                      subcategoryId: data?.data[index].subcategoryId.sId);
                  debugPrint(
                      "Id are ${data?.data[index].categoryId.sId} and ${data?.data[index].subcategoryId.sId}");
                  Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                    argCategoryId: data?.data[index].categoryId.sId ?? "",
                    argSubCategoryId: data?.data[index].subcategoryId.sId ?? "",
                    argTitle: data?.data[index].title ?? "",
                    argForViewVendorsProduct: strDealsOfDay,
                  });
                },
                child: _dealsOfTheDayItemCard(data?.data[index]),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ).paddingOnly(top: margin_20),
      );

  _dealOfFeatureItem(dynamic data) => Visibility(
        visible: data != null && data.totalCount > 0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1 / 1.6,
          ),
          itemCount:
              data != null && data.totalCount > 6 ? 6 : data?.totalCount ?? 0,
          itemBuilder: (context, index) {
            if (index < data?.data?.length) {
              return InkWell(
                onTap: () {
                  filterSelectctedData = FilterCampaignData(
                      categoryId: data?.data[index].categoryId.sId,
                      subcategoryId: data?.data[index].subcategoryId.sId);

                  debugPrint(
                      "Id are ${data?.data[index].categoryId.sId} and ${data?.data[index].subcategoryId.sId}");
                  Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                    argCategoryId: data?.data[index].categoryId.sId ?? "",
                    argSubCategoryId: data?.data[index].subcategoryId.sId ?? "",
                    argTitle: data?.data[index].title ?? "",
                    argForViewVendorsProduct: strDealsOfDay,
                  });
                },
                child: _dealsOfTheFeaturedItemCard(data?.data[index]),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ).paddingOnly(top: margin_20),
      );

  _dealsOfTheDayItemCard(dynamic data) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: Get.width,
                child: data.image != ""
                    ? NetworkImageWidget(
                        imageUrl: data.image ?? "",
                        imageHeight: height_135,
                        imageWidth: width_130,
                        imageFitType: BoxFit.fill,
                        radiusAll: 6)
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            TextView(
              text: "${data.title}",
              textStyle: textStyleHeadlineLarge()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
            ),
            SizedBox(height: height_6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: "From",
                  textStyle: textStyleHeadlineLarge().copyWith(
                      color: AppColors.DustyGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                TextView(
                  text: " \$${(data.price).toStringAsFixed(2)}",
                  textStyle: textStyleHeadlineLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 6),
            TextView(
              text: "${data.categoryId?.name} & more",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ).paddingAll(margin_8),
      );

  _dealsOfTheFeaturedItemCard(dynamic data) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: Get.width,
                child: data.image != ""
                    ? NetworkImageWidget(
                        imageUrl: data.image ?? "",
                        imageHeight: height_135,
                        imageWidth: width_130,
                        imageFitType: BoxFit.fill,
                        radiusAll: 6)
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            TextView(
              text: "${data.title}",
              textStyle: textStyleHeadlineLarge()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
            ),
            SizedBox(height: height_6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: "From",
                  textStyle: textStyleHeadlineLarge().copyWith(
                      color: AppColors.DustyGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                TextView(
                  text: " \$${(data.price).toStringAsFixed(2)}",
                  textStyle: textStyleHeadlineLarge().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 6),
            TextView(
              text: "${data.subcategoryId.name}",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ).paddingAll(margin_8),
      );

  _itemTitles(String title, bool fortimer, {onTap}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextView(
              text: title,
              textStyle: textStyleTitleLarge().copyWith(
                  //color: Colors.red,
                  fontSize: font_16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          _timerOrViewAll(fortimer: fortimer, onTap: onTap)
        ],
      );

  Widget _timerOrViewAll({bool fortimer = false, onTap}) {
    final now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final time = endOfDay.millisecondsSinceEpoch;
    return Container(
      child: fortimer
          ? Container(
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 6),
                  const AssetSVGWidget(iconsClock),
                  const SizedBox(width: 6),
                  CountDownWidgetHomeScreen(
                    time: DateTime.fromMillisecondsSinceEpoch(controller
                            .dealOfDayTimerResponseModel.data?.validTill ??
                        0),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  const Text(
                    "Left",
                    style: TextStyle(
                        color: AppColors.gradient2nd,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          : InkWell(
              onTap: onTap ??
                  () {
                    print("View all");
                  },
              child: Row(
                children: [
                  TextView(
                      text: "View All",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.gradient2nd,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  const AssetSVGWidget(iconsForword,
                      color: AppColors.gradient2nd, imageWidth: 8)
                ],
              ),
            ),
    );
  }

  Widget campaigns() {
    var count = controller.campaignDataResponseModel.data?.count;
    return Visibility(
        visible: (((count != null) ? count : 0) > 0) ? true : false,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitles("Campaigns", false, onTap: () {
                  debugPrint("Check");
                  Get.toNamed(AppRoutes.viewAllCampaignsScreenRoute,
                      arguments: {argTitle: strCampaigns});
                }),
                _campaignItems(controller)
              ],
            ).paddingAll(20),
          ],
        ));
  }

  _campaignItems(HomeController controller) => Container(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1 / 1.3,
          ),
          itemCount: controller.campaignDataResponseModel.data?.count ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.handleNotifications(index);
                // Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
                //   argCampaignId: controller
                //       .campaignDataResponseModel.data?.data?[index].sId,
                //   argForOngoing: false,
                //   argForHome: true
                // });
              },
              child: _campaignItemsCard(index),
            );
          },
        ).paddingOnly(top: margin_20),
      );

  Widget _campaignItemsCard(int index) {
    var campaign = controller.campaignDataResponseModel.data?.data?[index];
    var campaignName = campaign?.campaignName;
    var totalQuantity = campaign?.totalQuantity;
    var soldQuantity = campaign?.soldQuantity;
    var price = campaign?.oneProductPrice;
    int endDateMillis = campaign?.endDate ?? 0;
    int startDateMillis = campaign?.startDate ?? 0;
    var remainingQuantity = totalQuantity - soldQuantity;

    // String timer = controller.timers[index][endDateMillis] ?? "0d : 0h : 0m : 0s";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: height_140,
            child: Stack(
              children: [
                // const Positioned.fill(
                //     child: AssetImageWidget(
                //       demoImagesRectangle183572,
                //       imageFitType: BoxFit.fill,
                //       radiusAll: 8,
                //     )),
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: NetworkImageWidget(
                    imageUrl: controller.campaignDataResponseModel.data
                            ?.data?[index].image ??
                        "",
                    imageHeight: height_60,
                    imageWidth: height_70,
                    imageFitType: BoxFit.cover,
                  ),
                )),
                if (controller.campaignDataResponseModel.data?.data?[index]
                            .isLive ==
                        true &&
                    controller.campaignDataResponseModel.data?.data?[index]
                            .createdBy !=
                        controller.userLoggedInId) ...[
                  Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.redColor,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AssetSVGWidget(iconsLive),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {},
                              child: TextView(
                                  text: "Join Now",
                                  textStyle: textStyleBodyMedium().copyWith(
                                      color: Colors.white,
                                      fontSize: font_10,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        ).paddingSymmetric(
                            vertical: margin_2, horizontal: margin_6),
                      )),
                ],


                Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: CountDownWidgetHomeScreen(
                              time: DateTime.fromMillisecondsSinceEpoch(
                                  controller.campaignDataResponseModel.data
                                          ?.data?[index].endDate ??
                                      0))
                          .paddingSymmetric(vertical: 4, horizontal: 8),
                    ))
              ],
            ),
          ),
        ),
        TextView(
          text: '$campaignName',
          maxLines: 1,

          textStyle: textStyleTitleLarge().copyWith(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        ).paddingOnly(top: 12, bottom: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: TextView(
                text: "$remainingQuantity/$totalQuantity",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
            ),
            const Spacer(),
            TextView(
              text: '\$$price',
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.gradient2nd,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget topDeals() {
    var count = controller.topDealsResponseModel.data?.totalCount;
    return Visibility(
      visible: ((count != null) ? count : 0) != 0 ? true : false,
      child: Column(
        children: [
          const Divider(thickness: 6, color: AppColors.dividerColor)
              .paddingSymmetric(vertical: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1 / 0.7,
            ),
            itemCount: controller.topDealsResponseModel.data?.totalCount ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print('$index');
                },
                child: _topDealsItem(index),
              );
            },
          ).paddingAll(20),
        ],
      ),
    );
  }

  _topDealsItem(int index) => InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
            argCategoryId: controller.topDealsResponseModel?.data?.data?[index]
                    .categoryId?.sId ??
                "",
            argSubCategoryId: controller.topDealsResponseModel?.data
                    ?.data?[index].subcategoryId?.sId ??
                "",
            argTitle:
                "Top Deals on ${(controller.topDealsResponseModel?.data?.data?[index].title ?? "")}",
            argForViewVendorsProduct: strDealsOfDay,
          });
        },
        child: Container(
          height: height_240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: NetworkImageWidget(
                  imageUrl: controller
                          .topDealsResponseModel.data?.data?[index].image ??
                      "",
                  imageHeight: height_135,
                  imageWidth: width_130,
                  imageFitType: BoxFit.cover,
                  radiusAll: radius_4,
                ),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: TextView(
                    text:
                        "Top Deals On ${controller.topDealsResponseModel.data?.data?[index].title ?? ""}",
                    textStyle: textStyleTitleLarge()
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
              Positioned(
                  top: 54,
                  left: 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.gradient2nd,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextView(
                          text: "From".toUpperCase(),
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        TextView(
                          text:
                              "\$${controller.topDealsResponseModel.data?.data?[index].price}",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 14),
                        ).paddingOnly(left: 4),
                      ],
                    ).paddingSymmetric(vertical: 8, horizontal: 12),
                  )),
            ],
          ),
        ),
      );

  Widget topFashionBrand() {
    var count = controller.fashionDealsResponseModel.data?.totalCount;
    return Visibility(
      visible: ((count != null) ? count : 0) != 0 ? true : false,
      child: Column(
        children: [
          const Divider(thickness: 6, color: AppColors.dividerColor)
              .paddingSymmetric(vertical: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _itemTitles(strTopFashionBrands, false, onTap: () {
                Get.toNamed(AppRoutes.viewAllProductsScreenRoute, arguments: {
                  argForViewAllProduct: strTopFashionBrands,
                });
              }),
              _dealOfDayItem(controller.fashionDealsResponseModel.data)
            ],
          ).paddingAll(margin_20),
        ],
      ),
    );
  }

  Widget styleWithDiscount({title, image}) => Visibility(
        visible: true,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor)
                .paddingSymmetric(vertical: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: TextView(
                        text: title,
                        textStyle: textStyleTitleLarge().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_18))),
                _styleWithDiscountItems(image: image)
              ],
            ).paddingSymmetric(horizontal: margin_20, vertical: margin_10),
          ],
        ),
      );

  _styleWithDiscountItems({image}) => Container(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 1 / 0.9,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print('$index');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(margin_8),
                    border: Border.all(color: AppColors.borderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AssetImageWidget(image,
                        imageWidth: Get.width,
                        imageHeight: height_85,
                        imageFitType: BoxFit.fill),
                    TextView(
                      text: "Clothing",
                      textStyle: textStyleTitleLarge().copyWith(
                          fontSize: font_14, fontWeight: FontWeight.w500),
                    ).paddingOnly(top: margin_8)
                  ],
                ).paddingAll(margin_4),
              ),
            );
          },
        ).paddingOnly(top: 20),
      );

  Widget featuredCategoriesOfWeek() => Visibility(
        visible: (controller.featuredCategoriesResponseModel.data != null &&
                controller.featuredCategoriesResponseModel.data?.totalCount !=
                    0)
            ? true
            : false,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor)
                .paddingSymmetric(vertical: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitles(strFeaturesCategories, false, onTap: () {
                  Get.toNamed(AppRoutes.viewAllProductsScreenRoute, arguments: {
                    argForViewAllProduct: strFeaturesCategories,
                  });
                }),
                _dealOfFeatureItem(
                    controller.featuredCategoriesResponseModel.data)
              ],
            ).paddingAll(20),
          ],
        ),
      );

  Widget shopWithUs() => Visibility(
        visible: (controller.shopWithUsResponseModel.data != null &&
                controller.shopWithUsResponseModel.data?.totalCount != 0)
            ? true
            : false,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor)
                .paddingSymmetric(vertical: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitles(strShopWithUs, false, onTap: () {
                  Get.toNamed(AppRoutes.viewAllVendorsScreenRoute,
                      arguments: {argForAllVendors: strShopWithUs});
                }),
                _shopWithUsItems(controller.shopWithUsResponseModel.data)
              ],
            ).paddingAll(20),
          ],
        ),
      );

  _shopWithUsItems(DealsOfTheDayDataModel? data) => Container(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: data?.totalCount ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                filterSelectctedData = FilterCampaignData(
                    categoryId: data?.data![index].categoryId?.sId,
                    subcategoryId: data?.data![index].subcategoryId?.sId);

                Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                  argCategoryId: data?.data?[index].categoryId?.sId ?? "",
                  argSubCategoryId: data?.data?[index].subcategoryId?.sId ?? "",
                  argTitle: data?.data?[index].title ?? "",
                  argForViewVendorsProduct: strDealsOfDay,
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_8),
                    border: Border.all(
                        color: AppColors.borderColor, width: width_1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height_130,
                      width: Get.width,
                      child: NetworkImageWidget(
                        imageUrl: data?.data?[index].image ?? "",
                        imageHeight: height_150,
                        imageWidth: width_130,
                        imageFitType: BoxFit.fill,
                        radiusAll: radius_4,
                      ),
                    ),
                    Center(
                        child: TextView(
                      text: "${data?.data?[index].title}",
                      textStyle: textStyleTitleLarge().copyWith(
                          fontSize: margin_14, fontWeight: FontWeight.w500),
                    ).paddingOnly(top: margin_16))
                  ],
                ).paddingAll(margin_4),
              ),
            );
          },
        ).paddingOnly(top: 20),
      );

  Widget popularVendors() => Visibility(
        visible: (controller.vendorsResponseModel.data != null &&
                controller.vendorsResponseModel.data?.totalCount != 0)
            ? true
            : false,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor)
                .paddingSymmetric(vertical: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitles(strPopularVendors, false, onTap: () {
                  Get.toNamed(AppRoutes.viewAllVendorsScreenRoute,
                      arguments: {argForAllVendors: strPopularVendors});
                }),
                _popularsVendors(controller.vendorsResponseModel.data)
              ],
            ).paddingAll(margin_20),
          ],
        ),
      );

  _popularsVendors(VendorsDataModel? data) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1 / 1,
        ),
        itemCount: /*6*/data != null && data.totalCount > 6 ? 6 : data?.totalCount ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              filterSelectctedData = FilterCampaignData(
                sellerId: data?.data?[index].sId,
              );
              Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                argForViewVendorsProduct: strForVendors,
                argTitle: data?.data?[index].name ?? "",
                argSellerId: data?.data?[index].sId ?? "",
                argImage: data?.data?[index].image ?? "",
              });
              print('image : ${data?.data?[index].image ?? ""}');
            },
            child: Container(
              padding: EdgeInsets.all(margin_16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.borderColor, width: width_0point5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height_60,
                    width: height_60,
                    child: NetworkImageWidget(
                        imageUrl: data?.data?[index].image ?? "",
                        placeHolder: iconsProfilePlaceholderS,
                        imageHeight: height_40,
                        imageWidth: height_40,
                        radiusAll: height_60,
                        imageFitType: BoxFit.fill),
                  ),
                  SizedBox(height: margin_10),
                  Expanded(
                    child: TextView(
                      maxLines: 1,
                      text: "${data?.data?[index].name}",
                      textStyle: textStyleTitleLarge().copyWith(
                          fontSize: font_14, fontWeight: FontWeight.w500),
                    ).paddingOnly(top: margin_16),
                  )
                ],
              ),
            ),
          );
        },
      ).paddingOnly(top: margin_16);

  // Widget banner() => Visibility(
  //       visible: true,
  //       child:
  //           InkWell(
  //             onTap: () {
  //               var title = "";
  //               Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
  //                 argCategoryId: controller.bottomBannerResponseModel.data?.data?[0].categoryId?.sId,
  //                 argSubCategoryId: controller.bottomBannerResponseModel.data?.data?[0].subcategoryId?.sId,
  //                 argTitle: title,
  //                 argForViewVendorsProduct: strDealsOfDay,
  //               });
  //             },
  //             child: controller.bottomBannerResponseModel.data != null &&
  //                     controller
  //                             .bottomBannerResponseModel.data?.data?.length !=
  //                         0
  //                 ? Column(
  //                     children: [
  //                       const Divider(
  //                               thickness: 6, color: AppColors.dividerColor)
  //                           .paddingSymmetric(vertical: 8),
  //                       Container(
  //                         width: Get.width,
  //                         decoration:
  //                             const BoxDecoration(color: AppColors.bannerColor),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //                             // TextView(
  //                             //   text: "SALE".toUpperCase(),
  //                             //   textStyle: TextStyle(
  //                             //       fontFamily: 'BebasNeue',
  //                             //       fontWeight: FontWeight.w400,
  //                             //       fontSize: font_80,
  //                             //       color: AppColors.titleRed),
  //                             // ),
  //                             // TextView(
  //                             //     text: "On Casual Fits".toUpperCase(),
  //                             //     textStyle: textStyleTitleLarge().copyWith(
  //                             //         fontWeight: FontWeight.w600,
  //                             //         fontSize: 32)),
  //                             // TextView(
  //                             //   text: "up to 50% off".toUpperCase(),
  //                             //   textStyle: TextStyle(
  //                             //       fontFamily: 'BebasNeue',
  //                             //       fontWeight: FontWeight.w400,
  //                             //       fontSize: font_40,
  //                             //       color: AppColors.titleRed),
  //                             // ).paddingOnly(top: 8),
  //                             // TextView(
  //                             //         text: "FOR MEN'S & WOMEN".toUpperCase(),
  //                             //         textStyle: textStyleTitleLarge().copyWith(
  //                             //             color: Colors.grey.shade800,
  //                             //             fontWeight: FontWeight.w500,
  //                             //             fontSize: 18))
  //                             //     .paddingOnly(top: 8),
  //                             // Container(
  //                             //     padding: EdgeInsets.symmetric(
  //                             //         horizontal: margin_12,
  //                             //         vertical: margin_12),
  //                             //     margin: EdgeInsets.only(
  //                             //         top: margin_16, bottom: margin_20),
  //                             //     decoration: BoxDecoration(
  //                             //         color: AppColors.gradient2nd,
  //                             //         borderRadius: BorderRadius.circular(4)),
  //                             //     child: TextView(
  //                             //       text: "SHOP NOW".toUpperCase(),
  //                             //       textStyle: textStyleTitleLarge().copyWith(
  //                             //           color: Colors.white,
  //                             //           fontSize: font_14,
  //                             //           fontWeight: FontWeight.w700),
  //                             //     )),
  //                             // const AssetImageWidget(
  //                             //     demoImagesWomanStylishColorfulOut),
  //                             NetworkImageWidget(
  //                                     imageUrl: controller
  //                                         .bottomBannerResponseModel
  //                                         .data
  //                                         ?.data?[0]
  //                                         .image,
  //                                     imageHeight: 100,
  //                                     imageWidth: Get.width)
  //                                 .paddingSymmetric(horizontal: 16)
  //                           ],
  //                         ).paddingSymmetric(vertical: margin_20),
  //                       ).paddingAll(margin_20),
  //                     ],
  //                   )
  //                 : emptySizeBox(),
  //           ),
  //
  //
  //
  //     );
  Widget banner() => Visibility(
        visible: true,
        child: controller.bottomBannerResponseModel.data != null &&
                controller.bottomBannerResponseModel.data?.data?.isNotEmpty ==
                    true
            ? Column(
                children: [
                  const Divider(thickness: 6, color: AppColors.dividerColor)
                      .paddingSymmetric(vertical: 4),
                  Container(
                      width: Get.width,
                      decoration:
                          const BoxDecoration(color: AppColors.bannerColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .bottomBannerResponseModel.data!.data!.length,
                              itemBuilder: (context, index) {
                                final bannerData = controller
                                    .bottomBannerResponseModel
                                    .data!
                                    .data![index];
                                return InkWell(
                                  onTap: () {
                                    filterSelectctedData = FilterCampaignData(
                                      categoryId: bannerData.categoryId?.sId,
                                      subcategoryId:
                                          bannerData.subcategoryId?.sId,
                                    );
                                    Get.toNamed(
                                        AppRoutes.vendorsProductsScreenRoute,
                                        arguments: {
                                          argCategoryId:
                                              bannerData.categoryId?.sId,
                                          argSubCategoryId:
                                              bannerData.subcategoryId?.sId,
                                          argTitle: bannerData.title ?? "",
                                          argForViewVendorsProduct:
                                              strDealsOfDay,
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        NetworkImageWidget(
                                          imageUrl: bannerData.image,
                                          imageHeight: 240,
                                          imageWidth: Get.width,
                                          imageFitType: BoxFit.fill,
                                        ).paddingSymmetric(horizontal: 4),
                                      ],
                                    ).paddingSymmetric(vertical: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ).paddingOnly(right: 4)),
                ],
              )
            : emptySizeBox(),
      );

  Widget middleBanner() => Visibility(
        visible: true,
        child: controller.middleBannerResponseModel.data != null &&
                controller.middleBannerResponseModel.data?.data?.isNotEmpty ==
                    true
            ? Column(
                children: [
                  const Divider(thickness: 6, color: AppColors.dividerColor)
                      .paddingSymmetric(vertical: 4),
                  Container(
                      width: Get.width,
                      decoration:
                          const BoxDecoration(color: AppColors.bannerColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .middleBannerResponseModel.data!.data!.length,
                              itemBuilder: (context, index) {
                                final bannerData = controller
                                    .middleBannerResponseModel
                                    .data!
                                    .data![index];
                                return InkWell(
                                  onTap: () {
                                    filterSelectctedData = FilterCampaignData(
                                      categoryId: bannerData.categoryId?.sId,
                                      subcategoryId:
                                          bannerData.subcategoryId?.sId,
                                    );

                                    Get.toNamed(
                                        AppRoutes.vendorsProductsScreenRoute,
                                        arguments: {
                                          argCategoryId:
                                              bannerData.categoryId?.sId,
                                          argSubCategoryId:
                                              bannerData.subcategoryId?.sId,
                                          argTitle: bannerData.title ?? "",
                                          argForViewVendorsProduct:
                                              strDealsOfDay,
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        NetworkImageWidget(
                                          imageUrl: bannerData.image,
                                          imageHeight: 240,
                                          imageWidth: Get.width,
                                          imageFitType: BoxFit.fill,
                                        ).paddingSymmetric(horizontal: 4),
                                      ],
                                    ).paddingSymmetric(vertical: 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ).paddingOnly(right: 4)),
                ],
              )
            : emptySizeBox(),
      );

  Widget bestOnQuantitySaver() => Visibility(
        visible: (controller.bestOnEcommerceResponseModel.data != null &&
                controller.bestOnEcommerceResponseModel.data?.totalCount != 0)
            ? true
            : false,
        child: Column(
          children: [
            const Divider(thickness: 6, color: AppColors.dividerColor)
                .paddingSymmetric(vertical: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemTitles(strBestOnQuantity, false, onTap: () {
                  Get.toNamed(AppRoutes.viewAllVendorsScreenRoute,
                      arguments: {argForAllVendors: strBestOnQuantity});
                }),
                _bestQuantitySaversItems(
                    controller.bestOnEcommerceResponseModel.data)
              ],
            ).paddingAll(margin_20),
          ],
        ),
      );

  _bestQuantitySaversItems(DealsOfTheDayDataModel? data) => Visibility(
        visible: true,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1 / 1.45,
          ),
          itemCount: data?.totalCount ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                  argCategoryId: data?.data?[index].categoryId?.sId ?? "",
                  argSubCategoryId: data?.data?[index].subcategoryId?.sId ?? "",
                  argTitle: data?.data?[index].title ?? "",
                  argForViewVendorsProduct: strDealsOfDay,
                });
              },
              child: _bestQuantitySaversItemsCard(data?.data?[index]),
            );
          },
        ).paddingOnly(top: 20),
      );

  _bestQuantitySaversItemsCard(dynamic data) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: AppColors.borderColor, width: width_0point5)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: Get.width,
                child: NetworkImageWidget(
                  imageUrl: data.image ?? "",
                  imageHeight: height_200,
                  imageWidth: Get.width,
                  imageFitType: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextView(
              text: "${data.title}",
              textStyle: textStyleHeadlineLarge()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(height: height_6),
            TextView(
              text: "\$${(data?.price).toStringAsFixed(2)}",
              textStyle: textStyleHeadlineLarge()
                  .copyWith(fontWeight: FontWeight.w500, fontSize: font_12),
            )
          ],
        ).paddingAll(margin_8),
      );
}
