import "../../../export.dart";

import "../models/data_models/wishlist_data_model.dart";

class WishlistScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(WishlistController());

  WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
      init: WishlistController(),
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strWishlist.toUpperCase(),
              isBottomWidget: true,
              bottomWidget: TabBar(
                onTap: (index) {
                  if (index == 0) {
                    controller.wishlistType = "PRODUCT";
                    controller.update();
                  } else {
                    controller.wishlistType = "CAMPAIGN";
                    controller.update();
                  }
                  controller.getWishlistData();
                },
                dividerColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  TextView(
                    text: strProducts.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_13),
                  ).paddingOnly(bottom: margin_4),
                  TextView(
                    text: strCampaigns
                        .substring(0, strCampaigns.length - 1)
                        .toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_13),
                  ).paddingOnly(bottom: margin_4),
                ],
              ),
            ),
            body: controller.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.gradient2nd,
                  ))
                : TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                        // Shimmer(
                        //     child: _productList(controller.wishlistResponseModel?.data)),
                        controller.wishlistResponseModel?.data?.totalCount == 0
                            ? _noCouponScreen()
                            : RefreshIndicator(
                                color: AppColors.gradient2nd,
                                onRefresh: () async {
                                  await controller.refreshList();
                                },
                                child: _productList(
                                  controller.wishlistResponseModel?.data,
                                )),
                        controller.wishlistResponseModel?.data?.totalCount == 0
                            ? _noCouponScreen()
                            : RefreshIndicator(
                                child: _campaignList(
                                    controller.wishlistResponseModel?.data),
                                onRefresh: () async {
                                  await controller.refreshCampaignList();
                                })
                      ]),
          ),
        );
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
  Widget _productList(WishlistDataModel? data) => GridView.builder(
        shrinkWrap: true,
        // physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: .69,
        ),
        itemCount: data?.totalCount,
        itemBuilder: (context, index) {
          var item = data?.data?[index].productId;
          return InkWell(
            onTap: () async {
              debugPrint('$index');
              var result = await Get.toNamed(
                  AppRoutes.productsDetailsScreenRoute,
                  arguments: {argProductId: item?.id, argWishList: true});
              if (result != null && result[argIndex] == true) {
                debugPrint("Result is $result");
                controller.getWishlistData("PRODUCTS");
              }
            },
            child: ProductCardWidget(
              ontap: () {
                print('tapped');
                controller.hitDeleteFromWishlistApi(item?.id);
                controller.getWishlistData();
                controller.update();
              },
              rating: item?.totalRatings.toStringAsFixed(1) ?? '',
              name: item?.name ?? '',
              description: item?.description ?? '',
              discount: item?.discountPercantage.toString() ?? '',
              markPrice: item?.price.toStringAsFixed(2) ?? '',
              sellingPrice: item?.discountPrice.toStringAsFixed(2) ?? '',
              totalReviews: item?.totalReviews.toString() ?? '',
              imageUrl: item?.images[0] ?? 'abc',
              isOnWishlist: true,
            ),
          );
        },
      ).paddingAll(margin_16);

  _campaignList(WishlistDataModel? data) => ListView.builder(
        shrinkWrap: true,
        itemCount: data?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
                argCampaignId: data?.data?[index].campaignId?.sId,
                argForWishList: true
              });
              debugPrint("$index");
            },
            child: CampaignProductCardWidget(
              data: data?.data?[index],
            ),
          );
        },
      );
}
