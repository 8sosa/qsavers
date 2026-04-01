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

import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/product_campaigns_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';

import '../../../export.dart';

class CampaignDetailsWidgetScreen extends StatelessWidget {
  List<ProductCampaignsDataModel>? data;
  int? count;
  Map<int, String> timerText;

  CampaignDetailsWidgetScreen({
    super.key,
    this.data,
    this.count,
    required this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: count ?? (data?.length ?? 0),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _campaignDetail(index: index);
      },
    );
  }

  _campaignDetail({index}) {
    int endDateMillis = data?[index!].endDate ?? 0;
    String timer = timerText[endDateMillis] ?? "0d : 0h : 0m : 0s";

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
          agrForCompaignDetails: strForJoin,
          argCampaignId: data?[index].sId
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius_8),
                  topLeft: Radius.circular(radius_8)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradient1st, AppColors.gradient2nd],
              ),
            ),
            height: height_50,
            width: Get.width,
            child: Row(
              children: [
                TextView(
                  text: "${data?[index]?.campaignName}",
                  textStyle: textStyleTitleMedium().copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: font_16,
                      color: Colors.white),
                ),
                const Spacer(),
                Row(
                  children: [
                    if (data?[index].isLive) ...[
                      Row(
                        children: [
                          const AssetSVGWidget(iconsLive),
                          const SizedBox(width: 8),
                          TextView(
                            text: "Live",
                            textStyle: textStyleTitleMedium().copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                    SizedBox(width: font_12),
                    Container(
                      padding: EdgeInsets.all(margin_8),
                      height: height_35,
                      width: width_35,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white, width: width_1),
                          borderRadius: BorderRadius.circular(radius_4)),
                      child: AssetSVGWidget(
                        iconsVisibility,
                        imageWidth: width_25,
                      ),
                    ),
                    SizedBox(width: width_12),
                    Container(
                      height: height_35,
                      width: width_35,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white, width: width_1),
                          borderRadius: BorderRadius.circular(radius_4)),
                      child: IconButton(
                          onPressed: () {},
                          icon: AssetSVGWidget(
                            iconsJoinFill,
                            imageWidth: width_24,
                          )),
                    )
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8)),
              border: Border.all(color: AppColors.borderColor, width: 2),
              color: Colors.white,
            ),
            width: Get.width,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data?[index].isLive) ...[_liveStreamTag()],
                TextView(
                  text: "Join campaign fast! Time is running",
                  textStyle: textStyleTitleMedium().copyWith(
                      color: AppColors.categoriesgrey,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(top: margin_16),
                TextView(
                  text: timer,
                  textStyle: textStyleTitleMedium().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ).paddingOnly(bottom: margin_10),
                _campaignChips(
                    title: "Group Name:",
                    values: "${data?[index].groupId?.groupName}",
                    icon: true),
                _campaignChips(
                    title: "Available Quantity:",
                    values:
                        "${data?[index].quantity}/${data?[index].totalQuantity}",
                    icon: false),
                _campaignTitleWithIcon(
                  title: "Campaign duration:",
                  icon: const AssetSVGWidget(iconsClockGreen),
                ),
                TextView(
                  text:
                      "${millisecondsToCustomDateFormat(data?[index].startDate)} - ${millisecondsToCustomDateFormat(data?[index].endDate)}",
                  textStyle: textStyleTitleMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ).paddingOnly(left: margin_20),
                Row(
                  children: [
                    _campaignTitleWithIcon(
                      title: "User joined:",
                      icon: const AssetSVGWidget(iconsUserGreen),
                    ),
                    TextView(
                      text: "${data?[index].userJoined}",
                      textStyle: textStyleTitleMedium().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: font_14),
                    ).paddingOnly(left: margin_2, top: margin_10),
                  ],
                )

              ],
            ).paddingSymmetric(horizontal: margin_20),
          ),
        ],
      ).paddingOnly(bottom: margin_20),
    );
  }

  _campaignTitleWithIcon({title, icon})
  {
      return Row(
        children: [
          icon,
          TextView(
            text: title,
            textStyle: textStyleTitleMedium().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.categoriesgrey,
            ),
          ).paddingOnly(left: 10),
        ],
      ).paddingOnly(top: 20, bottom: 8);}

  _campaignChips({title, values, icon}) => Container(
        decoration: BoxDecoration(
          color: AppColors.catBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: title,
              textStyle: textStyleTitleMedium().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gradient2nd),
            ),
            Expanded(
              child: TextView(
                text: "  $values",
                textStyle: textStyleTitleMedium().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gradient2nd),
              ),
            ),
            icon
                ? const AssetSVGWidget(iconsCampaignLock)
                    .paddingOnly(left: margin_8)
                : const SizedBox()
          ],
        ).paddingAll(margin_16),
      ).paddingOnly(top: margin_10);

  _liveStreamTag() => Container(
        decoration: BoxDecoration(
            color: AppColors.titleRed, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AssetSVGWidget(iconsLive),
            const SizedBox(width: 8),
            TextView(
              text: "Streaming Live Now",
              textStyle: textStyleTitleMedium().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white),
            )
          ],
        ).paddingSymmetric(horizontal: 20),
      ).paddingOnly(top: margin_16);
}
