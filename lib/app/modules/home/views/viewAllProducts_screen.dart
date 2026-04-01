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

import 'package:quantity_savers/app/core/widget/custom_skeleton_loader_widget.dart';
import 'package:quantity_savers/app/modules/home/models/data_model/deals_of_the_day_data_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';
import 'package:quantity_savers/app/modules/home/widgets/counter_widget.dart';

import '../../../core/widget/home_timer.dart';
import '../../../export.dart';

class ViewAllProductsScreen extends StatelessWidget {
  final controller = Get.put(ViewAllProductsController());
  final themeController = Get.put(ThemeController());

  ViewAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllProductsController>(
        init: ViewAllProductsController(),
        builder: (context) {
          return Shimmer(
            child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: controller.title.toUpperCase(),
              ),
              body: ShimmerLoading(
                isLoading: controller.isLoading,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _itemTitles(
                          "${controller.dealsOfTheDayResponseModel.data?.totalCount ?? 0} items"),
                      _dealOfDayItem()
                    ],
                  ).paddingAll(margin_20),
                ),
              ),
            ),
          );
        });
  }

  _itemTitles(String title) => Container(
        child: Row(
          children: [
            TextView(
              text: title,
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            controller.title == strDealsOfDay ? _timerOrViewall() : SizedBox()
          ],
        ),
      );

  _timerOrViewall() {
    final now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final time = endOfDay.millisecondsSinceEpoch;
    return Row(
      children: [
        const AssetSVGWidget(iconsClock),
        const SizedBox(width: 8),
        CountDownWidgetHomeScreen(
            time: DateTime.fromMillisecondsSinceEpoch(
                controller.dealOfDayTimerResponseModel.data?.validTill ?? 0),
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.gradient2nd,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
        TextView(
            text: 'Left',
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.gradient2nd,
                fontWeight: FontWeight.w500,
                fontSize: 14))
      ],
    );
  }

  _dealOfDayItem() => Visibility(
        visible: true,
        child: GridView.builder(
          controller: controller.scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1 / 1.5,
          ),
          itemCount:
              controller.dealsOfTheDayResponseModel.data?.totalCount ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                filterSelectctedData = FilterCampaignData(
                    categoryId: controller.dealsOfTheDayResponseModel.data
                        ?.data?[index].categoryId?.sId,
                    subcategoryId: controller.dealsOfTheDayResponseModel.data
                            ?.data?[index].subcategoryId?.sId ??
                        0);

                Get.toNamed(AppRoutes.vendorsProductsScreenRoute, arguments: {
                  argCategoryId: controller.dealsOfTheDayResponseModel.data
                          ?.data?[index].categoryId?.sId ??
                      "",
                  argSubCategoryId: controller.dealsOfTheDayResponseModel.data
                          ?.data?[index].subcategoryId?.sId ??
                      "",
                  argTitle: controller.dealsOfTheDayResponseModel.data
                          ?.data?[index].title ??
                      "",
                  argForViewVendorsProduct: strDealsOfDay,
                });
              },
              child: _dayOfdayitemCard(
                  controller.dealsOfTheDayResponseModel.data?.data?[index]),
            );
          },
        ).paddingOnly(top: 20),
      );

  _dayOfdayitemCard(DealsOfTheDayData? data) => Container(
        decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor, width: 0.5)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                child: NetworkImageWidget(
                  imageUrl: data?.image ?? "",
                  imageHeight: height_135,
                  imageWidth: width_130,
                  imageFitType: BoxFit.fill,
                  radiusAll: 6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextView(
              text: data?.title ?? "",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ),
            const SizedBox(height: 6),
            TextView(
              text: "From \$${data?.price ?? 0}",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: AppColors.DustyGray,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            const SizedBox(height: 6),
            TextView(
              text: "${data?.categoryId?.name ?? ""} & more",
              textStyle: textStyleHeadlineLarge().copyWith(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ).paddingAll(8),
      );
}
