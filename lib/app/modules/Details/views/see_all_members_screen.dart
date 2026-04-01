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

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/campaign_members_group_data_model.dart';

import '../../../core/utils/time_conversion.dart';
import '../../../export.dart';

class SeeAllMembersScreen extends StatelessWidget {
  final controller = Get.put(SeeAllMembersController());
  final themeController = Get.put(ThemeController());

  SeeAllMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeeAllMembersController>(
        init: SeeAllMembersController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strTtlSeeAllMembers,
              isBottomWidget: true,
              bottomWidget: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.white,
                labelStyle: textStyleTitleLarge()
                    .copyWith(fontSize: font_14, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => controller.onTabChanged(index),
                tabs: const [Tab(text: strJoined), Tab(text: strExited)],
              ),
            ),
            body: Column(
              children: [
                TextFieldWidget(
                  prefixIcon: const AssetSVGWidget(iconsSearchIcon)
                      .paddingAll(margin_10),
                  borderRadius: margin_1,
                  hint: strSearchByName,
                ),
                Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        _usersList(
                            controller.campaignGroupMembersResponseModel.data),
                        _usersList(
                            controller.campaignGroupMembersResponseModel.data)
                      ]),
                ),
              ],
            ).paddingAll(margin_20),
          );
        });
  }

  _usersList(List<CampaignGroupMemberDataModel>? data) => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data?.length ?? 0,
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _joinedUserView(data?[index], index);
        },
      );

  _joinedUserView(CampaignGroupMemberDataModel? data, int index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor, width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AssetImageWidget(controller.list[index].image ?? "",
            //     imageHeight: 48,
            //     imageWidth: 48,
            //     radiusAll: 24,
            //     imageFitType: BoxFit.fill),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    maxLines: 3,
                    text: data?.userId?.name ?? "",
                    textStyle: textStyleBodyMedium()
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Row(
                    children: [
                      TextView(
                        text: strQuantity,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: font_14,
                            color: AppColors.bottombarColor),
                      ),
                      TextView(
                        text: (data?.totalQuantity ?? 0).toString(),
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_14),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: strPrice,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: font_14,
                            color: AppColors.bottombarColor),
                      ),
                      Expanded(
                        child: TextView(
                          maxLines: 3,
                          text: "\$${data?.totalPrice ?? 0}".toString(),
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w600, fontSize: font_14),
                        ),
                      ),
                    ],
                  )
                ],
              ).paddingOnly(left: margin_20),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextView(
                    text: "#${index + 1}",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: font_14,
                        color: AppColors.bottombarColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextView(
                        text: strDate,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: font_14,
                            color: AppColors.bottombarColor),
                      ),
                      TextView(
                        text: millisecondsToCustomDateFormat(
                            int.parse(data?.createdAt)),
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextView(
                        text: strStatus,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: font_14,
                            color: AppColors.bottombarColor),
                      ),
                      TextView(
                        text: data?.status ?? "",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: font_14,
                            color: AppColors.GreenHaze),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ).paddingAll(margin_10),
      ).paddingSymmetric(vertical: margin_10);
}
