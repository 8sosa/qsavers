import "package:quantity_savers/app/core/utils/time_conversion.dart";
import "package:quantity_savers/app/modules/profile/controllers/profile_request_controller.dart";

import "../../../export.dart";

class ProfileRequestScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ProfileRequestController());

  ProfileRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileRequestController>(
        init: ProfileRequestController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(appBarTitleText: strRequests.toUpperCase()),
            body: controller.campaignRequestListResponseModel.data?.length == 0
                ? Center(
                  child: _noCouponScreen()
                )
                : Container(
                    padding: EdgeInsets.all(margin_20),
                    child: ListView.builder(
                        itemCount: controller.campaignRequestListResponseModel
                                .data?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _campaignRequestListItem(index);
                        }),
                  ),
          );
        });
  }
  _noCouponScreen() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetSVGWidget(iconsNotPurchased)
            .paddingOnly(bottom: margin_20),
        TextView(
          text: "No Request Found",
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(bottom: margin_16),
      ],
    ),
  );
  _campaignRequestListItem(int index) {
    var item = controller.campaignRequestListResponseModel.data;
    return Container(
      padding: EdgeInsets.all(margin_16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_12),
          border: Border.all(color: AppColors.borderColor, width: width_2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width_70,
                child: NetworkImageWidget(
                  imageUrl: item?[index].productId?.images?[0] ?? "",
                  imageHeight: height_40,
                  imageWidth: height_40,
                  imageFitType: BoxFit.contain,
                ),
              ).paddingOnly(right: margin_12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    maxLines: 1,
                    text: item?[index].productId?.name,
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600, fontSize: font_16),
                  ),
                  Row(
                    children: [
                      TextView(
                        text: "Date: ",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: font_12,
                            color: AppColors.categoriesgrey),
                      ),
                      TextView(
                        text: millisecondsToCustomDateFormat(
                            int.parse(item?[index].createdAt)),
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: font_12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              TextView(
                text: "${index + 1}",
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_14,
                    color: AppColors.categoriesgrey),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.campaignRequestDetailsRoute,
                  arguments: {argCampaignRequestId: item?[index].sId,argTitle:item?[index].productId?.name});
            },
            child: Center(
              child: Container(
                height: height_32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_4),
                    color: AppColors.catBackgroundColor),
                child: Center(
                  child: TextView(
                    text: strViewDetails.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        fontSize: font_12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gradient2nd),
                  ),
                ),
              ).paddingOnly(top: margin_16),
            ),
          )
        ],
      ),
    ).paddingOnly(bottom: margin_20);
  }
}
