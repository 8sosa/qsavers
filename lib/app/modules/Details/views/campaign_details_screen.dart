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

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/core/values/app_values.dart';
import 'package:quantity_savers/app/core/widget/groupName_toast.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';

import '../../../core/utils/read_more.dart';
import '../../../export.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final controller = Get.put(CampaignDetailsController());
  final themeController = Get.put(ThemeController());

  CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.completedCampaign == true ||
            controller.failedCampaign == true ||
            controller.cancelledCampaign == true ||
            controller.customerFailed == true ||
            controller.isRouteForCustomerExited == true ||
            controller.isRouteForCustomerCancelled == true ||
            controller.joinedCampaign == true ||
            controller.isRouteForCustomerCompleted == true ||
            controller.isForSearchScreen == true ||
            controller.isRouteForViewAllCampaign == true ||
            controller.creatorCampaign == true ||
            controller.isForWishList == true) {
          Get.back();
        } /*else if (controller.creatorCampaign == true) {
          Get.offAllNamed(AppRoutes.mainScreenRoute,
              arguments: {argBottomNavigationIndex: 1});
        }*/
        else {
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        }
        return false;
      },
      child: GetBuilder<CampaignDetailsController>(
          init: CampaignDetailsController(),
          builder: (controller) {
            int endDateMillis =
                controller.campaignDetailsResponseModel.data?.endDate ?? 0;
            return Scaffold(
              appBar: CustomAppBar(
                onTap: () {
                  if (controller.isRouteForOrderPlacedScreen == true) {
                    Get.offAllNamed(AppRoutes.mainScreenRoute);
                  } /*else if (controller.creatorCampaign == true) {
                    Get.offAllNamed(AppRoutes.campaignsScreenRoute,
                        arguments: {argForOngoing: false});
                  } */
                  /* else if (controller.creatorCampaign == true) {
                    Get.offAllNamed(AppRoutes.mainScreenRoute,
                        arguments: {argBottomNavigationIndex: 1});
                  }*/
                  else {
                    Get.back();
                  }
                },
                appBarTitleText: strCampaignDetail.toUpperCase(),
                isBottomWidget: false,
                actionWidget: [
                  GestureDetector(
                    onTap: () {
                      dynamicLinkingController.generateDeepLink(controller.campaignDetailsResponseModel.data?.sId, "campaign");
                    },
                    child: const AssetSVGWidget(iconsShare)
                        .paddingOnly(right: margin_20),
                  )
                ],
              ),
              body: Shimmer(
                child: ShimmerLoading(
                  isLoading: controller.isLoading,
                  isImage: true,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SizedBox(
                                      height: height_180,
                                      width: Get.width,
                                      child: NetworkImageWidget(
                                        imageUrl: controller
                                                .campaignDetailsResponseModel
                                                .data
                                                ?.image ??
                                            "",
                                        imageHeight: height_150,
                                        imageWidth: Get.width,
                                        imageFitType: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (controller.campaignDetailsResponseModel
                                              .data?.createdBy?.sId ==
                                          controller.userLoggedInId &&
                                      (controller.isRouteForViewAllCampaign ==
                                              true ||
                                          controller.creatorCampaign == true ||
                                          controller.joinedCampaign == true ||
                                          controller.isRouteForHome ==
                                              true)) ...[
                                    Positioned(
                                        bottom: margin_20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.redColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius_4)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const AssetSVGWidget(iconsLive),
                                              GestureDetector(
                                                onTap: () {
                                                  showStartLiveBroadcastDialog(
                                                      Get.context!,
                                                      controller
                                                          .campaignDetailsResponseModel
                                                          .data
                                                          ?.sId,
                                                      "PUBLISHER",
                                                      DateTime.fromMillisecondsSinceEpoch(
                                                          controller
                                                              .campaignDetailsResponseModel
                                                              .data
                                                              ?.endDate));
                                                },
                                                child: TextView(
                                                  text: "Start Live BroadCast",
                                                  textStyle:
                                                      textStyleTitleLarge()
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  font_10),
                                                ),
                                              )
                                            ],
                                          ).paddingAll(margin_6),
                                        ))
                                  ],
                                  if (controller.campaignDetailsResponseModel
                                              .data?.isLive ==
                                          true &&
                                      controller.campaignDetailsResponseModel
                                              .data?.createdBy !=
                                          controller.userLoggedInId) ...[
                                    Positioned(
                                        bottom: margin_20,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.redColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius_4)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const AssetSVGWidget(iconsLive),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.hitStartLiveSocket(
                                                      controller
                                                          .campaignDetailsResponseModel
                                                          .data
                                                          ?.sId,
                                                      "SUBSCRIBER");
                                                },
                                                child: TextView(
                                                  text: "JOIN NOW",
                                                  textStyle:
                                                      textStyleTitleLarge()
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  font_10),
                                                ),
                                              )
                                            ],
                                          ).paddingAll(margin_6),
                                        ))
                                  ]
                                ],
                              ).paddingSymmetric(horizontal: margin_20),
                              Row(
                                children: [
                                  TextView(
                                    text:
                                        "${controller.campaignDetailsResponseModel.data?.campaignName}",
                                    textStyle: textStyleBodyMedium().copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: font_18),
                                  ),
                                  const Spacer(),
                                  if (controller.completedCampaign == true) ...[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.gradient2nd,
                                          borderRadius:
                                              BorderRadius.circular(radius_4)),
                                      child: TextView(
                                        text: strCompleted,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: font_12),
                                      ).paddingAll(margin_6),
                                    )
                                  ] else if (controller.failedCampaign ==
                                      true) ...[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.lightRedColor,
                                          borderRadius:
                                              BorderRadius.circular(radius_4)),
                                      child: TextView(
                                        text: strFailed,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: font_12),
                                      ).paddingAll(margin_6),
                                    )
                                  ] else if (controller.cancelledCampaign ==
                                      true) ...[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.lightRedColor,
                                          borderRadius:
                                              BorderRadius.circular(radius_4)),
                                      child: TextView(
                                        text: strCancelled,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: font_12),
                                      ).paddingAll(margin_6),
                                    )
                                  ]
                                ],
                              )
                                  .paddingOnly(top: margin_20)
                                  .paddingSymmetric(horizontal: margin_20),
                              Obx(() => TextView(
                                    text:
                                        controller.timers[endDateMillis] ?? "",
                                    textStyle: textStyleBodyMedium().copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: font_16,
                                        color: AppColors.gradient2nd),
                                  )
                                      .paddingOnly(top: margin_12)
                                      .paddingSymmetric(horizontal: margin_20)),
                              _itemDetails(),
                              if (controller.isRouteForCustomerExited == true ||
                                  controller.isRouteForCustomerCancelled ==
                                      true) ...[
                                _exitedDetails().paddingOnly(bottom: margin_20),
                              ],
                              if (controller.userLoggedInId ==
                                  controller.campaignDetailsResponseModel.data
                                      ?.createdBy?.sId) ...[
                                _priceDetailsView(),
                              ],
                              if (controller.customerCampaign == true) ...[
                                //_canceledOrExitedView(),
                              ],
                              if (controller.campaignDetailsResponseModel.data
                                          ?.addressDetail !=
                                      null &&
                                  (controller.customerCampaign == true ||
                                      controller.isRouteForHome == true ||
                                      controller.isRouteForViewAllCampaign ==
                                          true)) ...[
                                _shippingAddressView(),
                              ],
                              if (controller.isRouteForCustomerCompleted ==
                                  true) ...[
                                BottomButtonWidget(
                                  onPressed: () {
                                    Get.toNamed(
                                        AppRoutes.orderPlacedScreenRoute,
                                        arguments: {
                                          argIsForViewOrderDetails: true,
                                          argOrderId: controller
                                              .campaignDetailsResponseModel
                                              .data
                                              ?.orderId,
                                          argForOrderPlaced:
                                              strForCampaignOrderPlace,
                                          argForCompaign: true,
                                          argForOrderPlacedData:
                                              controller.checkOutResponseModel,
                                          argForOrderProductID: controller
                                              .campaignDetailsResponseModel
                                              .data
                                              ?.orderProductID
                                        });
                                  },
                                  btnTitle: strViewOrderDetails,
                                  isBorderColor: false,
                                ),
                              ],
                              TextView(
                                text: strMembers.toUpperCase(),
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_18),
                              )
                                  .paddingOnly(top: margin_20)
                                  .paddingSymmetric(horizontal: margin_20),
                              TabBar(
                                onTap: (index) {
                                  controller.membersTabIndex = index;
                                  controller.update();
                                  controller.hitGetCampaignMembersApiCall();
                                },
                                unselectedLabelColor: AppColors.DustyGray,
                                unselectedLabelStyle: textStyleBodyMedium()
                                    .copyWith(
                                        fontSize: font_14,
                                        fontWeight: FontWeight.w500),
                                labelColor: AppColors.gradient2nd,
                                labelStyle: textStyleBodyMedium().copyWith(
                                    fontSize: font_14,
                                    fontWeight: FontWeight.w600),
                                indicatorColor: AppColors.gradient2nd,
                                controller: controller.tabController,
                                // Provide your controller
                                tabs: const [
                                  Tab(text: strJoined),
                                  Tab(text: strExited),
                                ],
                              ),
                              controller.campaignGroupMembersResponseModel.data
                                          ?.length ==
                                      0
                                  ? _noMembers()
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller
                                              .campaignGroupMembersResponseModel
                                              .data
                                              ?.length ??
                                          0,
                                      padding: const EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _joinedUserView(index: index);
                                      },
                                    ),
                              if ((controller.campaignGroupMembersResponseModel
                                          .data?.length ??
                                      0) >
                                  5) ...[
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.seeAllMembersScreenRoute,
                                        arguments: {
                                          argCampaignId: controller.campaignId
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(radius_12),
                                        border: Border.all(
                                            color: AppColors.borderColor,
                                            width: width_1)),
                                    child: Row(
                                      children: [
                                        TextView(
                                          text: strSeeAllJoinedMembers,
                                          textStyle: textStyleBodyMedium()
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: font_16,
                                                  color: AppColors.gradient2nd),
                                        ),
                                        const Spacer(),
                                        const AssetSVGWidget(
                                            iconsArrowRightSLineforwordArrow),
                                      ],
                                    ).paddingSymmetric(
                                        horizontal: margin_20,
                                        vertical: margin_12),
                                  ).paddingSymmetric(horizontal: margin_20),
                                )
                              ],
                              Column(
                                children: [
                                  (controller.campaignDetailsResponseModel.data
                                                  ?.description ??
                                              '')
                                          .isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text: "Campaign Description",
                                              textStyle: textStyleBodyMedium()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: font_18),
                                            )
                                                .paddingOnly(
                                                    top: margin_20, right: 80)
                                                .paddingSymmetric(
                                                    horizontal: margin_20),
                                            /* TextFieldWidget(
                                      maxLines: 4,
                                      minLine: 4,
                                      initialValue: _parseHtmlString(controller
                                          .campaignDetailsResponseModel
                                          .data
                                          ?.description ??
                                          ''),
                                      readOnly: true,
                                    )*/
                                            ReadMoreTextWidget(
                                              trimLines: 3,
                                              moreStyle: textStyleBodyMedium()
                                                  .copyWith(
                                                      color:
                                                          AppColors.gradient2nd,
                                                      fontSize: font_14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              lessStyle: textStyleBodyMedium()
                                                  .copyWith(
                                                      color:
                                                          AppColors.gradient2nd,
                                                      fontSize: font_14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              text: _parseHtmlString(controller
                                                      .campaignDetailsResponseModel
                                                      .data
                                                      ?.description ??
                                                  ''),
                                              textStyle: textStyleBodyMedium()
                                                  .copyWith(
                                                      color: AppColors
                                                          .lightBlackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: font_13),
                                            ).paddingSymmetric(
                                                vertical: margin_20,
                                                horizontal: margin_20)
                                          ],
                                        )
                                      : Container(),
                                  ((controller.campaignDetailsResponseModel.data
                                                  ?.video !=
                                              "") &&
                                          controller
                                                  .campaignDetailsResponseModel
                                                  .data
                                                  ?.video !=
                                              "string" &&
                                          controller
                                                  .campaignDetailsResponseModel
                                                  .data
                                                  ?.video !=
                                              null)
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius_12),
                                              border: Border.all(
                                                  color: AppColors.borderColor,
                                                  width: width_1)),
                                          margin: EdgeInsets.all(margin_20),
                                          child: VideoPreviewWidget(
                                            mediaFile: MediaFile(
                                                networkPath: controller
                                                    .campaignDetailsResponseModel
                                                    .data
                                                    ?.video),
                                            height: height_135,
                                            width: Get.width,
                                            padding: 60,
                                          ),
                                        )
                                      : Container()
                                ],
                              )
                            ],
                          ).paddingSymmetric(vertical: margin_20),
                        ),
                      ),
                      if (controller.creatorCampaign == true ||
                          controller.userLoggedInId ==
                              controller.campaignDetailsResponseModel.data
                                  ?.createdBy?.sId) ...[
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: AppColors.borderColor,
                                      width: 1,
                                      style: BorderStyle.solid))),
                          child: Row(
                            children: [
                              // ((controller.campaignGroupMembersResponseModel.data?.length ?? 0) >= 2)
                              if ((controller.campaignGroupMembersResponseModel
                                          .data?.length ??
                                      0) >=
                                  2) ...[
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
                                            Get.toNamed(
                                                AppRoutes
                                                    .deleteCampaignScreenRoute,
                                                arguments: {
                                                  argCampaignId: controller
                                                      .campaignDetailsResponseModel
                                                      .data
                                                      ?.sId
                                                });
                                          }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.titleRed,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(radius_8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              if ((controller.campaignGroupMembersResponseModel
                                          .data?.length ??
                                      0) <=
                                  1) ...[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.gradient2nd,
                                        borderRadius:
                                            BorderRadius.circular(radius_8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const AssetSVGWidget(iconsPencil)
                                            .paddingOnly(right: margin_4),
                                        InkWell(
                                          onTap: () {
                                            Get.dialog(CustomDialogWidget(
                                                isImage: false,
                                                title: strEditCampaign,
                                                confirmTitle: strYesEdit,
                                                cancelTitle: strDontEdit,
                                                confirmBtnBgColor:
                                                    AppColors.titleRed,
                                                confirmTitleColor: Colors.white,
                                                cancelBtnBgColor:
                                                    Colors.white70,
                                                cancelTitleColor:
                                                    Colors.black54,
                                                cancelBtnBorder: Border.all(
                                                    color: Colors.black12),
                                                onTapCancel: () {
                                                  Get.back();
                                                },
                                                onTapConfirm: () {
                                                  Get.offNamed(
                                                      AppRoutes
                                                          .startCampaignScreenRoute,
                                                      arguments: {
                                                        argIsForCampaignEdit:
                                                            true,
                                                        argIsRouteFromCampaignDetails:
                                                            true,
                                                        argCampaignDetails:
                                                            controller
                                                                .campaignDetailsResponseModel,
                                                        argCampaignId:
                                                            controller
                                                                .campaignId
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
                                            Get.toNamed(
                                                AppRoutes
                                                    .deleteCampaignScreenRoute,
                                                arguments: {
                                                  argCampaignId: controller
                                                      .campaignDetailsResponseModel
                                                      .data
                                                      ?.sId
                                                });
                                          }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.titleRed,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(radius_8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              ]
                            ],
                          )
                              .paddingSymmetric(
                                  vertical: margin_20, horizontal: margin_20)
                              .paddingOnly(bottom: margin_12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = html_parser.parse(htmlString);
    String plainText = document.body!.children.map((element) {
      if (element.localName == 'p') {
        return element.text.trim();
      }
      return '';
    }).join('\n');
    return plainText;
  }

  _canceledOrExitedView() => Column(
        children: [
          Container(
            color: AppColors.titleRed.withOpacity(0.1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AssetSVGWidget(iconsCancel).paddingOnly(top: margin_2),
                Expanded(
                  child: TextView(
                    text: "Order Cancelled Today, Dec 08 ",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontSize: font_12, fontWeight: FontWeight.w400),
                  ).paddingOnly(left: margin_10),
                ),
              ],
            ).paddingSymmetric(vertical: margin_8, horizontal: margin_8),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetSVGWidget(iconsQuestionMark),
              TextView(
                text: " $strNeedHelp",
                textStyle: textStyleBodyMedium().copyWith(
                    fontSize: font_12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.DustyGray),
              ),
            ],
          ).paddingOnly(top: margin_12)
        ],
      ).paddingSymmetric(horizontal: margin_20).paddingOnly(bottom: margin_20);

  _joinedUserView({index}) {
    var item = controller.campaignGroupMembersResponseModel.data;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_12),
          border: Border.all(color: AppColors.borderColor, width: width_1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  maxLines: 3,
                  text: "${item?[index].userId?.name ?? ""}",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
                ),
                Row(
                  children: [
                    TextView(
                      text: strQuantity,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.bottombarColor),
                    ),
                    TextView(
                      text: "${item?[index].totalQuantity ?? "0"}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600, fontSize: font_12),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: strPrice.capitalize,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.bottombarColor),
                    ),
                    Expanded(
                      child: TextView(
                        maxLines: 3,
                        text: "${item?[index].totalPrice ?? "0"}",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "$strDate: ",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.bottombarColor),
                    ),
                    TextView(
                      text: millisecondsToCustomDateFormat(
                          int.parse(item?[index].createdAt ?? "")),
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600, fontSize: font_12),
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
                          fontSize: font_12,
                          color: AppColors.bottombarColor),
                    ),
                    TextView(
                      text: "${item?[index].status ?? ""}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: font_12,
                          color: AppColors.GreenHaze),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ).paddingAll(margin_10),
    ).paddingSymmetric(horizontal: margin_20, vertical: margin_10);
  }

  _itemDetails() {
    var item = controller.campaignDetailsResponseModel.data;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _itemDetailView(),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(margin_8),
              color: AppColors.Porcelain,
            ),

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: strGroupName,
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: font_13,
                      color: AppColors.gradient2nd),
                ),
                Expanded(
                  child: TextView(
                    text:
                        "${controller.campaignDetailsResponseModel.data?.groupId?.groupName}",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: font_13,
                        color: AppColors.gradient2nd),
                  ),
                ),
                // const Spacer(),
                AssetSVGWidget(iconsLockOpen,
                    imageWidth: width_15, imageHeight: height_15)
              ],
            ).paddingAll(margin_8),
          ).paddingSymmetric(horizontal: margin_20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetSVGWidget(iconsClockGreen).paddingOnly(top: margin_8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextView(
                    text: strCampaignDuration,
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: font_14,
                        color: AppColors.categoriesgrey),
                  ).paddingOnly(left: margin_4),
                  TextView(
                    text:
                        "${millisecondsToCustomDateFormat(item?.startDate ?? 0)} - ${millisecondsToCustomDateFormat(item?.endDate ?? 0)}",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600, fontSize: font_14),
                  ).paddingOnly(left: margin_8),
                ],
              ).paddingOnly(left: margin_8),
            ],
          ).paddingSymmetric(vertical: margin_12, horizontal: margin_20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetSVGWidget(iconsPersonalInformation).paddingOnly(top: margin_4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        text: strUserJoined,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: font_14,
                            color: AppColors.categoriesgrey),
                      ),
                      TextView(
                        text: "${item?.userJoined}",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_14),
                      ).paddingOnly(left: margin_2),
                    ],
                  ),

                ],
              ).paddingOnly(left: margin_8),
            ],
          ).paddingSymmetric(vertical: margin_12, horizontal: margin_20),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(margin_8),
                border:
                    Border.all(color: AppColors.borderColor, width: width_1)),
            child: (controller.campaignDetailsResponseModel.data?.isJoined ==
                    false)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: strAvailableQuantity,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w400, fontSize: font_14),
                      ),
                      TextView(
                        text:
                            "${(item?.quantity ?? 0) > 0 ? item?.quantity : 0}/${item?.totalQuantity ?? 0}",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_14),
                      ),
                    ],
                  ).paddingSymmetric(vertical: margin_4, horizontal: margin_4)
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: strAvailableQuantity,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: font_14),
                      ),
                      TextView(
                        text:
                            "${(item?.quantity ?? 0) > 0 ? item?.quantity : 0}/${item?.totalQuantity ?? 0}",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_14),
                      )
                    ],
                  ).paddingSymmetric(vertical: margin_8),
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_6),
           if (controller.campaignDetailsResponseModel.data?.isJoined ==
               false) ...[
                if (controller.isRouteForCustomerExited == false &&
                    controller.isRouteForCustomerCancelled == false
                    ) ...[
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (controller.campaignDetailsResponseModel.data
                                    ?.isGroupJoined ==
                                true) {
                              Get.toNamed(AppRoutes.startCampaignSecondScreenRoute,
                                  arguments: {
                                    argProductDetails:
                                        controller.campaignDetailsResponseModel,
                                    argIsRouteFromStartCampaign: true,
                                    argCampaignId: item?.sId,
                                    argJoin: true,
                                    argProductId: controller
                                        .campaignDetailsResponseModel
                                        .data
                                        ?.productDetails
                                        ?.sId
                                  });
                            } else {
                              // showToast(
                              //     message:
                              //         "You have to join the group ${controller.campaignDetailsResponseModel.data?.groupId?.groupName} before joining the campaign");
                              showCustomSnackbar(controller.campaignDetailsResponseModel.data?.groupId?.groupName);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(margin_8),
                            decoration: BoxDecoration(
                                color: AppColors.gradient2nd,
                                borderRadius: BorderRadius.circular(radius_8)),
                            child: Center(
                              child: TextView(
                                text: "Join Campaign",
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_14,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ).paddingOnly(left: margin_20),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildRowWithBulletPoint(
                                        'Join a associated group or community where campaigns are announced.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'A campaign is announced within the group, offering a product at a discounted price.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'Users within the group express their interest in the campaign and commit to buying the product at the discounted price.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'Once enough users have committed to the campaign, the group purchase is initiated.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'Users in the group proceed to checkout with the discounted price applied.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'Users receive an order confirmation and tracking information for their purchase.',
                                      ),
                                      _buildRowWithBulletPoint(
                                        'Please keep in mind that product delivery will begin once the campaign has been completed.',
                                      ),

                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: AppColors.gradient2nd),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.help_outline,
                            color: AppColors.gradient2nd,
                            size: 35,
                          )).paddingOnly(right: margin_10)
                    ],
                  ).paddingOnly(bottom: margin_6),
                ],
                if (controller.isRouteForCustomerExited == false &&
                    controller.isRouteForCustomerCancelled == false &&
                    controller
                            .campaignDetailsResponseModel.data?.isGroupJoined ==
                        false) ...[
                  SizedBox(
                    width: Get.width,
                    child: InkWell(
                      onTap: () async{
                        // Get.toNamed(AppRoutes.forumsRoute,
                        //     arguments: {argBottomNavigationIndex: 2});
                        await Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
                          argForumGroupType:
                          controller.campaignDetailsResponseModel.data?.groupId?.groupType,
                          argGroupId: controller.campaignDetailsResponseModel.data?.groupId?.sId,
                          argIsSearchedForum: true,
                          argIsSearchedForumCampaign:true,
                          argGroupJoined:controller.campaignDetailsResponseModel.data?.isGroupJoined
                        });
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(margin_8),
                        decoration: BoxDecoration(
                            color: AppColors.gradient2nd,
                            borderRadius: BorderRadius.circular(radius_8)),
                        child: Center(
                          child: TextView(
                            text: "Join Group",
                            textStyle: textStyleBodyMedium().copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: font_14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ).paddingOnly(left: margin_20,right: margin_20,bottom: margin_10),
                  )
                ],
              ],
           ]
      ),
    ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);
  }

  _itemDetailView() {
    var item = controller.campaignDetailsResponseModel.data;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: height_80,
          child: SizedBox(
            width: width_65,
            height: height_65,
            child: NetworkImageWidget(
              imageUrl: item?.productDetails?.images?[0] ?? "",
              imageHeight: height_65,
              imageWidth: width_65,
              imageFitType: BoxFit.contain,
              radiusAll: margin_8,
            ),
          ),
        ).paddingOnly(right: margin_12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextView(
                maxLines: 3,
                text: "${item?.productDetails?.name}",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: font_12),
              ),
              TextView(
                maxLines: 3,
                text: "${item?.productDetails?.description}",
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: font_12,
                    color: AppColors.categoriesgrey),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextView(
                    maxLines: 3,
                    text: strPrice.capitalize,
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: font_12,
                        color: AppColors.categoriesgrey),
                  ),
                  TextView(
                    maxLines: 3,
                    text: "\$${item?.productDetails?.wholesalePrice}",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: font_14,
                        color: Colors.black),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      TextView(
                        maxLines: 3,
                        text: "\$${item?.productDetails?.price}",
                        textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_14,
                          color: AppColors.categoriesgrey,
                        ),
                      ).paddingSymmetric(horizontal: margin_4),
                      const Positioned(
                        left: 0,
                        right: 0,
                        child: Divider(
                          color: AppColors
                              .categoriesgrey, // Set your desired color for the line
                          thickness: 1, // Adjust thickness as needed
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextView(
                      maxLines: 3,
                      text:
                          "${(controller.getDiscountPercentage()).toStringAsFixed(2)}% off",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.gradient2nd),
                    ),
                  ),
                ],
              ).paddingOnly(top: margin_4),
            ],
          ),
        )
      ],
    ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);
  }

  _shippingAddressView() {
    var item = controller.campaignDetailsResponseModel.data;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_12),
          border: Border.all(color: AppColors.borderColor, width: width_1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: strShippingAddress,
            textStyle: textStyleBodyMedium()
                .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_12),
          Row(
            children: [
              TextView(
                text: "${item?.addressDetail?.addressId?.name}",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
              ),
              Container(
                color: AppColors.gradient2nd,
                child: TextView(
                  text: "${item?.addressDetail?.addressId?.addressType}",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontSize: font_12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ).paddingSymmetric(horizontal: margin_8, vertical: margin_2),
              ).paddingOnly(left: margin_4),
            ],
          ).paddingSymmetric(horizontal: margin_20),
          TextView(
            maxLines: 3,
            text: "${item?.addressDetail?.addressId?.fullAddress}",
            textStyle: textStyleBodyMedium()
                .copyWith(fontWeight: FontWeight.w400, fontSize: font_12),
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_12),
          Row(
            children: [
              TextView(
                text: strTitlePhoneNumber,
                textStyle: textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
              ),
              TextView(
                text: "${item?.addressDetail?.addressId?.phoneNo}",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w400, fontSize: font_14),
              )
            ],
          ).paddingSymmetric(horizontal: margin_20),
          Container(
            color: AppColors.Porcelain,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextView(
                  text: strQuantity,
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: font_12,
                      color: AppColors.gradient2nd),
                ),
                TextView(
                  text: "${item?.addressDetail?.buyQuantity} piece",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: font_12,
                      color: AppColors.gradient2nd),
                )
              ],
            ).paddingAll(margin_8),
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_15),
          _dividerView(),
          controller.isRouteForCustomerExited == true
              ? BottomButtonWidget(
                  onPressed: () {
                    if (controller
                            .campaignDetailsResponseModel.data?.isGroupJoined ==
                        true) {
                      Get.toNamed(AppRoutes.startCampaignSecondScreenRoute,
                          arguments: {
                            argProductDetails:
                                controller.campaignDetailsResponseModel,
                            argIsRouteFromStartCampaign: true,
                            argCampaignId: item?.sId,
                            argProductId: controller
                                .campaignDetailsResponseModel
                                .data
                                ?.productDetails
                                ?.sId
                          });
                    } else {
                      // showToast(
                      //     message:
                      //         "You have to join the group ${controller.campaignDetailsResponseModel.data?.groupId?.groupName} before joining the campaign");
                      showCustomSnackbar(controller.campaignDetailsResponseModel.data?.groupId?.groupName);
                    }
                  },
                  btnTitle: strJoinCampaignAgain.toUpperCase(),
                  isBorderColor: false,
                )
              : item?.isJoined == false ||
                      controller.isRouteForCustomerCompleted == true ||
                      controller.isRouteForCustomerCancelled == true ||
                      controller.customerFailed == true
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        Get.dialog(CustomDialogWidget(
                          title:
                              controller.userLoggedInId == item?.createdBy?.sId
                                  ? strDeleteCompaign
                                  : strExitThisCampaign,
                          confirmTitle: strYes,
                          cancelTitle: strNo,
                          confirmBtnBgColor: Colors.red,
                          cancelTitleColor: AppColors.gradientColorSecondary,
                          cancelBtnBorder: Border.all(
                              color: AppColors.borderColor, width: 1),
                          cancelBtnBgColor: Colors.transparent,
                          onTapConfirm: () {
                            if (controller.userLoggedInId ==
                                item?.createdBy?.sId) {
                              Get.toNamed(AppRoutes.deleteCampaignScreenRoute,
                                  arguments: {
                                    argCampaignId: controller.campaignId
                                  });
                            } else {
                              Get.toNamed(AppRoutes.exitCampaignScreenRoute,
                                  arguments: {
                                    argCampaignId: controller.campaignId
                                  });
                            }
                          },
                          isImage: false,
                          isCloseBtn: true,
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.titleRed,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: AppColors.borderColor, width: 1)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AssetSVGWidget(iconsWhiteCross)
                                .paddingOnly(right: margin_4),
                            TextView(
                              text: controller.userLoggedInId ==
                                      item?.createdBy?.sId
                                  ? strDeleteCampaign
                                  : strExitCampaign,
                              textStyle: textStyleBodyMedium().copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: font_14,
                                  color: Colors.white),
                            )
                          ],
                        ).paddingSymmetric(vertical: margin_8),
                      )
                          .paddingSymmetric(horizontal: margin_20)
                          .paddingOnly(bottom: margin_20),
                    )
        ],
      ),
    ).paddingSymmetric(horizontal: margin_20);
  }

  _dividerView() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: Colors.grey.shade300,
        ),
      ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);

  _noMembers() => Center(
        child: Column(
          children: [
            const AssetSVGWidget(iconsNoData),
            TextView(
              maxLines: 3,
              text: controller.membersTabIndex == 0
                  ? strNoMember
                  : strNoMemberExited,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.DustyGray,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ).paddingOnly(top: margin_12),
          ],
        ).paddingAll(margin_32),
      );

  Widget _exitedDetails() {
    String? exitedFormattedDate;
    if (controller.campaignDetailsResponseModel.data?.endDate != null) {
      if (controller.isRouteForCustomerExited == true) {
        var campaign = controller
                    .campaignDetailsResponseModel.data?.exitedAt.runtimeType ==
                String
            ? int.parse(controller.campaignDetailsResponseModel.data?.exitedAt)
            : controller.campaignDetailsResponseModel.data?.exitedAt;
        if (campaign != null) {
          DateTime? exitedDate = DateTime.fromMillisecondsSinceEpoch(campaign!);
          exitedFormattedDate = DateFormat('dd/MMM/yyyy').format(exitedDate);
        }

        return Center(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_4),
              color: AppColors.titleRed.withOpacity(0.1)),
          child: TextView(
            textAlign: TextAlign.center,
            text: 'You exited this campaign on $exitedFormattedDate',
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.titleRed,
                fontSize: font_12,
                fontWeight: FontWeight.w500),
          ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
        ));
      } else {
        var campaignCancelled = controller.campaignDetailsResponseModel.data
                    ?.cancelledAt.runtimeType ==
                String
            ? int.parse(
                controller.campaignDetailsResponseModel.data?.cancelledAt)
            : controller.campaignDetailsResponseModel.data?.cancelledAt;
        DateTime cancelledDate =
            DateTime.fromMillisecondsSinceEpoch(campaignCancelled!);
        String cancelledFormatedDate =
            DateFormat('dd/MMM/yyyy').format(cancelledDate);
        return Center(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_4),
              color: AppColors.titleRed.withOpacity(0.1)),
          child: TextView(
            textAlign: TextAlign.center,
            text:
                'This campaign has been cancelled by the \nOrganizer on $cancelledFormatedDate',
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.titleRed,
                fontSize: font_12,
                fontWeight: FontWeight.w500),
          ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
        ));
      }
    } else {
      return Container();
    }
  }

  _priceDetailsView() {
    var item = controller.campaignDetailsResponseModel.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: strPriceDetails.capitalize,
          textStyle: textStyleBodyMedium()
              .copyWith(fontWeight: FontWeight.w600, fontSize: font_18),
        ),
        Row(
          children: [
            TextView(
              text: strUserJoined,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.DustyGray,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ),
            const Spacer(),
            TextView(
              text: "${item?.userJoined}",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
            ),
          ],
        ).paddingOnly(top: margin_20),
        Row(
          children: [
            TextView(
              text: strPriceOneProduct,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.DustyGray,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ),
            const Spacer(),
            TextView(
              text: "\$${item?.productDetails?.wholesalePrice}",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
            ),
          ],
        ).paddingOnly(top: margin_12),
        const Divider(
          color: AppColors.borderColor,
        ).paddingOnly(top: margin_12),
        Row(
          children: [
            TextView(
              text: "$strTotalPrice: ",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
            ),
            const Spacer(),
            TextView(
              text: "\$${item?.totalPrice}",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w700, fontSize: font_14),
            ),
          ],
        ).paddingOnly(top: margin_15),
        const Divider(
          color: AppColors.borderColor,
        ).paddingOnly(top: margin_15),
        if (controller.creatorCampaign == true ||
            controller.completedCampaign == true ||
            controller.failedCampaign == true ||
            controller.cancelledCampaign == true) ...[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4),
                color: controller.cancelledCampaign == true ||
                        controller.failedCampaign == true
                    ? AppColors.redColor.withOpacity(0.1)
                    : AppColors.GreenHaze.withOpacity(0.1)),
            child: TextView(
              textAlign: TextAlign.center,
              text: (controller.creatorCampaign == true)
                  ? "You will receive 1% of the total price after the completion of campaign"
                  : controller.completedCampaign == true
                      ? "Campaign Completed! You will receive your earning of \$100 on 13/Aug/2023"
                      : (controller.failedCampaign == true)
                          ? "Campaign Failed! Didn't get minimum product order in the time duration."
                          : controller.cancelledCampaign == true
                              ? "Campaign Cancelled! You cancelled this campaign on ${DateFormat('E, d MMM').format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(controller.campaignDetailsResponseModel.data?.cancelledAt ?? "8") ?? 8))}"
                              : '',
              textStyle: textStyleBodyMedium().copyWith(
                  color: controller.failedCampaign == true ||
                          controller.cancelledCampaign == true
                      ? AppColors.titleRed
                      : AppColors.GreenHaze,
                  fontSize: font_12,
                  fontWeight: FontWeight.w500),
            ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
          ).paddingOnly(top: margin_20),
        ]
      ],
    ).paddingSymmetric(horizontal: margin_20).paddingOnly(bottom: margin_20);
  }

  void showStartLiveBroadcastDialog(
      BuildContext context, String id, String type, DateTime providedDate) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Start Live Broadcast'),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.only(left: 10.0, top: 16.0, bottom: 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: const Text(
                'Start Live Broadcast Now',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                controller.hitStartLiveSocket(
                    controller.campaignDetailsResponseModel.data?.sId,
                    "PUBLISHER");
                Get.back();
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: const Text(
                'Schedule Live Broadcast',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Get.back();
                bool isScheduled = false;

                controller.getScheduleLiveBroadCastResponseModel.data?.data
                    ?.forEach((element) {
                  if (element.sId ==
                      controller.campaignDetailsResponseModel.data?.sId) {
                    isScheduled = true;
                    debugPrint("sid is ${element.sId}");
                    showToast(
                        message: "You have already scheduled live streaming");
                  }
                  debugPrint("sid is ${element.sId}");
                });

                if (!isScheduled) {
                  showScheduleLiveBroadcastDialog(Get.context!, providedDate);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showScheduleLiveBroadcastDialog(
      BuildContext context, DateTime providedDate) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Schedule Live Broadcast'),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(
                left: 16.0, right: 10.0, top: 10.0, bottom: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 14),
                ).paddingOnly(top: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: providedDate.subtract(const Duration(days: 0)),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppColors
                                  .gradient2nd, // header background color
                              onPrimary: Colors.white, // header text color
                              onSurface:
                                  AppColors.gradient2nd, // body text color
                            ),
                            dialogBackgroundColor:
                                Colors.white, // background color
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : 'yyyy-mm-dd'),
                        const Icon(
                          Icons.calendar_today,
                          color: AppColors.gradient2nd,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 10),
                const SizedBox(height: 10.0),
                const Text(
                  'Select Time',
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppColors
                                  .gradient2nd, // header background color
                              onPrimary: Colors.white, // header text color
                              onSurface:
                                  AppColors.gradient2nd, // body text color
                            ),
                            dialogBackgroundColor:
                                Colors.white, // background color
                          ),
                          child: child!,
                        );
                      },
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedTime != null
                            ? selectedTime!.format(context)
                            : '--:--'),
                        const Icon(
                          Icons.access_time,
                          color: AppColors.gradient2nd,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 10),
              ],
            ),
            actions: [
              MaterialButtonWidget(
                onPressed: () {
                  if (selectedDate != null && selectedTime != null) {
                    controller.hitScheduleBroadCast(
                        controller.campaignDetailsResponseModel.data?.sId,
                        selectedDate.toString(),
                        selectedTime!.format(context).toString());
                    Get.back();
                  } else {
                    if (selectedDate == null && selectedTime == null) {
                      showToast(message: "Please Select Date and Time");
                    } else if (selectedDate == null) {
                      showToast(message: "Please Select Date");
                    } else if (selectedTime == null) {
                      showToast(message: "Please Select Time");
                    }
                  }
                },
                buttonText: "Schedule Live Broadcast",
                buttonBgColor: AppColors.gradient2nd,
                minHeight: height_40,
                textColor: Colors.white,
                buttonTextStyle: const TextStyle(fontSize: 14),
              ).paddingOnly(top: 12)
            ],
          );
        },
      ),
    );
  }

  Widget _buildRowWithBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 12),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
