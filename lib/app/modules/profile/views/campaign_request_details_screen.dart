import "package:flutter_html/flutter_html.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/media_file.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart";
import "package:quantity_savers/app/modules/profile/controllers/campaign_request_details_controller.dart";

import "../../../export.dart";

class CampaignRequestDetailsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(CampaignRequestDetailsController());

  CampaignRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignRequestDetailsController>(
        init: CampaignRequestDetailsController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText:"${controller.title.toUpperCase()}"
                  // "${controller.campaignRequestDetailsResponseModel.data?.productId?.name} details"
                  //     .toUpperCase(),
            ),
            body: controller.isLoading == true
                ? Center(
                      child: LoadingAnimationWidget.fallingDot(
                          color: AppColors.gradientColorPrimary, size: 50),
                    )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(margin_20),
                              child: NetworkImageWidget(
                                  imageUrl: controller
                                          .campaignRequestDetailsResponseModel
                                          .data
                                          ?.image ??
                                      "",
                                  imageHeight: height_180,
                                  imageWidth: Get.width,
                                  radiusAll: radius_12,
                                  imageFitType: BoxFit.cover,
                                  placeHolder: iconsProfilePlaceholderS),
                            ),
                            if(controller.campaignRequestDetailsResponseModel.data?.description!="")...[
                              TextView(
                                text: "Description",
                                textStyle: textStyleBodyMedium()
                                    .copyWith(
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: font_18),
                              ).paddingOnly(left: 20),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: margin_20),
                                child: Html(
                                  data: controller
                                      .campaignRequestDetailsResponseModel
                                      .data
                                      ?.description ??
                                      "",
                                ),
                              ),
                              if(controller.campaignRequestDetailsResponseModel.data?.video!="")...[
                                Padding(
                                  padding: EdgeInsets.all(margin_20),
                                  child: VideoPreviewWidget(
                                    mediaFile: MediaFile(
                                        networkPath: controller
                                            .campaignRequestDetailsResponseModel
                                            .data
                                            ?.video),
                                    padding: 60,
                                  ),
                                )
                            ]

                            ]

                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: AppColors.borderColor,
                                    width: 1,
                                    style: BorderStyle.solid))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.gradient2nd,
                                    borderRadius:
                                        BorderRadius.circular(radius_8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const AssetSVGWidget(iconsPencil)
                                        .paddingOnly(right: margin_4),
                                    InkWell(
                                      onTap: () {
                                        Get.dialog(CustomDialogWidget(
                                            isImage: false,
                                            title: strEditCampaignRequest,
                                            confirmTitle: strYesEdit,
                                            cancelTitle: strDontEdit,
                                            confirmBtnBgColor:
                                                AppColors.titleRed,
                                            confirmTitleColor: Colors.white,
                                            cancelBtnBgColor: Colors.white70,
                                            cancelTitleColor: Colors.black54,
                                            cancelBtnBorder: Border.all(
                                                color: Colors.black12),
                                            onTapCancel: () {
                                              Get.back();
                                            },
                                            onTapConfirm: () {
                                              Get.back();
                                              Get.toNamed(
                                                  AppRoutes
                                                      .requestCampaignScreenRoute,
                                                  arguments: {
                                                    argIsRouteFromEditCampaignRequest:
                                                        true,
                                                    argCampaignRequestDetails:
                                                        controller
                                                            .campaignRequestDetailsResponseModel
                                                  });
                                            }));
                                      },
                                      child: TextView(
                                        text: strEdit.toUpperCase(),
                                        textStyle: textStyleTitleLarge()
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: font_14),
                                      ),
                                    )
                                  ],
                                ).paddingSymmetric(vertical: margin_12),
                              ),
                            ),
                            SizedBox(width: width_20),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.dialog(CustomDialogWidget(
                                      isImage: false,
                                      title: strDeleteCompaign,
                                      confirmTitle: strYesDelete,
                                      cancelTitle: strDontDelete,
                                      confirmBtnBgColor: AppColors.titleRed,
                                      confirmTitleColor: Colors.white,
                                      cancelBtnBgColor: Colors.white70,
                                      cancelTitleColor: Colors.black54,
                                      cancelBtnBorder:
                                          Border.all(color: Colors.black12),
                                      onTapCancel: () {
                                        Get.back();
                                      },
                                      onTapConfirm: () {
                                        Get.back();
                                        controller
                                            .hitDeleteCampaignRequestApi();
                                      }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.titleRed, width: 1),
                                      borderRadius:
                                          BorderRadius.circular(radius_8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const AssetSVGWidget(
                                        iconsDelete,
                                        color: AppColors.titleRed,
                                      ).paddingOnly(right: margin_4),
                                      TextView(
                                        text: strDelete.toUpperCase(),
                                        textStyle: textStyleTitleLarge()
                                            .copyWith(
                                                color: AppColors.titleRed,
                                                fontWeight: FontWeight.w700,
                                                fontSize: font_14),
                                      )
                                    ],
                                  ).paddingSymmetric(vertical: margin_12),
                                ),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(
                            vertical: margin_20, horizontal: margin_20),
                      ),
                    ],
                  ),
          );
        });
  }
}
