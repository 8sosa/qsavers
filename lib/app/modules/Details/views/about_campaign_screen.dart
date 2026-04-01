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

import 'package:quantity_savers/app/modules/Details/controllers/about_campaign_controller.dart';

import '../../../export.dart';

class AboutCampaignScreen extends StatelessWidget {
  final controller = Get.put(AboutCampaignController());
  final themeController = Get.put(ThemeController());

  AboutCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutCampaignController>(
        init: AboutCampaignController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strAboutCompaign,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [CampaignDetails(), _campaignButtons()],
            ).paddingSymmetric(horizontal: margin_20, vertical: margin_20),
          );
        });
  }

  Widget _campaignButtons() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButtonWidget(
            onPressed: () {
              if (controller.productDetails?.data?.canCreateCampaign == true) {
                if (controller.productDetails?.data?.createCampaign == false) {
                controller.startCampaign();
                } else {
                  showToast(message: "Campaign is already going on");
                }
              }
            },
            buttonText: strStartCampaign.toUpperCase(),
            buttonTextStyle: textStyleTitleMedium().copyWith(
                fontSize: height_14,
                fontWeight: FontWeight.w700,
                color: controller.productDetails?.data?.canCreateCampaign ==
                            false ||
                        (controller.productDetails?.data?.canCreateCampaign ==
                                true &&
                            controller.productDetails?.data?.createCampaign ==
                                false)
                    ? Colors.white
                    : Colors.white.withOpacity(0.5)),
            buttonBgColor: AppColors.gradient2nd,
            minHeight: height_42,
          ),
          SizedBox(height: margin_10),
          MaterialButtonWidget(
            onPressed: () {
              Get.toNamed(AppRoutes.termsAndConditions,arguments: {argTitle:"Terms & Conditions"});
            },
            buttonText: "MORE DETAILS".toUpperCase(),
            buttonTextStyle: textStyleTitleMedium().copyWith(
                fontSize: height_14,
                fontWeight: FontWeight.w700,
                color: AppColors.gradient2nd),
            buttonBgColor: Colors.white,
            borderColor: AppColors.gradient2nd,
            borderWidth: 2,
            isOutlined: true,
            minHeight: height_42,
          )
        ],
      ).paddingSymmetric(vertical: margin_20);

  Widget CampaignDetails() => Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 4,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext ctxt, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle, weight: margin_2, size: margin_2)
                    .paddingOnly(top: margin_10),
                Expanded(
                  child: TextView(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    textStyle: textStyleTitleMedium()
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    maxLines: 5,
                  ).paddingOnly(left: margin_10),
                )
              ],
            ).paddingOnly(right: margin_20);
          },
        ),
      );
}
