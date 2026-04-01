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

import 'package:quantity_savers/app/modules/home/models/data_model/vendors_data_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';

import '../../../export.dart';

class ViewAllVendorsScreen extends StatelessWidget {
  final controller = Get.put(ViewAllVendorsController());
  final themeController = Get.put(ThemeController());

  ViewAllVendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllVendorsController>(
        init: ViewAllVendorsController(),
        builder: (context) {
          return Shimmer(
            child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: controller.title.toUpperCase(),
              ),
              body: ShimmerLoading(
                isLoading: controller.isLoading,
                child: Column(
                  children: [
                    Expanded(
                      child: _buildContent(controller),
                    ),
                    controller.isPagination
                        ? const ProgressCircle()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildContent(ViewAllVendorsController controller) {
    if (controller.title == strBestOnQuantity) {
      return _bestQuantitySaversItems(controller
          .shopWithUsResponseModel.data); // Placeholder for loading state
    } else if (controller.title == strPopularVendors) {
      return _popularsVendors(controller.vendorsResponseModel.data);
    } else {
      return _shopWithUsItems(controller.shopWithUsResponseModel.data);
    }
  }

  _popularsVendors(VendorsDataModel? data) => GridView.builder(
        shrinkWrap: true,
        controller: controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1 / 1,
        ),
        itemCount: controller.vendorsResponseModel.data?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              filterSelectctedData = FilterCampaignData(
                  sellerId: data?.data?[index].sId ?? "",
                 );
              Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                argForViewVendorsProduct: strForVendors,
                argTitle: data?.data?[index].name ?? "",
                argSellerId: data?.data?[index].sId ?? "",
                argImage: data?.data?[index].image ?? "",
              });
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
                  SizedBox(
                    height: height_60,
                    width: height_60,
                    child: NetworkImageWidget(
                        imageUrl: data?.data?[index].image ?? "",
                        imageHeight: height_40,
                        imageWidth: height_40,
                        radiusAll: height_60,
                        placeHolder: iconsProfilePlaceholderS,
                        imageFitType: BoxFit.fill),
                  ),
                  SizedBox(height: margin_10),
                  Expanded(
                    child: TextView(
                      maxLines: 1,
                      text: "${data?.data?[index].name}",
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontSize: font_14,
                          fontWeight: FontWeight.w500),
                    ).paddingOnly(top: margin_16),
                  )
                ],
              ),
            ),
          );
        },
      ).paddingAll(margin_16);

  _shopWithUsItems(DealsOfTheDayDataModel? data) => Container(
        child: GridView.builder(
          shrinkWrap: true,
          controller: controller.scrollController,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: data?.data?.length ?? 0,
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
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ).paddingOnly(top: 16))
                  ],
                ).paddingAll(margin_4),
              ).paddingOnly(top: margin_16),
            );
          },
        ).paddingOnly(top: margin_4),
      ).paddingSymmetric(horizontal: margin_20);

  _bestQuantitySaversItems(DealsOfTheDayDataModel? data) => Visibility(
        visible: true,
        child: GridView.builder(
          shrinkWrap: true,
          controller: controller.scrollController,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1 / 1.45,
          ),
          itemCount: data?.data?.length ?? 0,
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
      ).paddingSymmetric(horizontal: margin_20);

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
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ),
            SizedBox(height: height_6),
            TextView(
              text: "\$${data?.price}",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_12),
            )
          ],
        ).paddingAll(margin_8),
      );
}
