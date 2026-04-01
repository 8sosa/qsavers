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

import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/modules/campaigns/controller/compaigns_controller.dart';

import '../../../core/widget/customtabindicator.dart';
import '../../../core/widget/text_view_limit.dart';
import '../../../export.dart';
import '../../home/widgets/counter_widget.dart';

class CampaignsScreen extends StatelessWidget {
  final controller = Get.put(CampaignsController());
  final themeController = Get.put(ThemeController());

  CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignsController>(
        init: CampaignsController(),
        builder: (context) {
          if (controller.campaignCreatorResponseModel.count == 0 ||
              controller.campaignCustomerResponseModel.count == 0) {
            return Scaffold(
                appBar: CustomAppBar(
                  appBarTitleText: strCampaigns.toUpperCase(),
                  onTap: () {
                    Get.back();
                  },
                  isBottomWidget: true,
                  bottomWidget: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    controller: controller.tabController,
                    indicatorColor: Colors.white,
                    // labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: Colors.white.withOpacity(0.8),
                    labelColor: Colors.white,
                    labelStyle: textStyleTitleLarge().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w600),
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) => controller.onTabChanged(index),
                    // tabs: controller.forCustomerCampaign
                    //     ? [
                    //         Tab(text: "JOINED (${controller.Joined})"),
                    //         Tab(
                    //             text:
                    //                 "COMPLETED (${controller.customerCompleted})"),
                    //         Tab(text: "EXITED (${controller.customerExited})"),
                    //         Tab(
                    //             text:
                    //                 "CANCELLED (${controller.customerCancelled})")
                    //       ]
                    //     : [
                    //         Tab(text: "ONGOING (${controller.ongoing})"),
                    //         Tab(
                    //             text:
                    //                 "COMPLETED (${controller.createrCompleted})"),
                    //         Tab(text: "FAILED (${controller.createrFailed})"),
                    //         Tab(
                    //           text: "CANCELLED(${controller.createrCancelled})",
                    //         )
                    //       ],
                    tabs: _buildTabs(controller),
                  ),
                ),
                body: _noCouponScreen());
          } else {
            return Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: strCampaigns.toUpperCase(),
                isBottomWidget: true,
                bottomWidget: TabBar(
                  isScrollable: true,
                  indicator: CustomTabIndicator(),
                  tabAlignment: TabAlignment.start,
                  controller: controller.tabController,
                  indicatorColor: Colors.white,
                  // labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Colors.white.withOpacity(0.8),
                  labelColor: Colors.white,
                  labelStyle: textStyleTitleLarge()
                      .copyWith(fontSize: font_14, fontWeight: FontWeight.w600),
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) => controller.onTabChanged(index),
                  // tabs: controller.forCustomerCampaign
                  //     ? [
                  //         Tab(text: "JOINED (${controller.Joined})"),
                  //         Tab(
                  //             text:
                  //                 "COMPLETED (${controller.customerCompleted})"),
                  //         Tab(text: "EXITED (${controller.customerExited})"),
                  //         Tab(
                  //             text:
                  //                 "CANCELLED (${controller.customerCancelled})")
                  //       ]
                  //     : [
                  //         Tab(text: "ONGOING (${controller.ongoing})"),
                  //         Tab(
                  //             text:
                  //                 "COMPLETED (${controller.createrCompleted})"),
                  //         Tab(text: "FAILED (${controller.createrFailed})"),
                  //         Tab(
                  //           text: "CANCELLED(${controller.createrCancelled})",
                  //         )
                  //       ],
                  tabs: _buildTabs(controller),
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: controller.forCustomerCampaign == true
                    ? [
                        _tabbarData(),
                        _tabbarData(),
                        _tabbarData(),
                        _tabbarData(),
                        _tabbarData(),
                      ]
                    : [
                        _tabbarData(),
                        _tabbarData(),
                        _tabbarData(),
                        _tabbarData(),
                      ],
              ),
            );
          }
        });
  }

  List<Tab> _buildTabs(CampaignsController controller) {
    List<Tab> tabs = [];
    if (controller.forCustomerCampaign) {
      if (controller.Joined != 0) {
        tabs.add(Tab(text: "JOINED (${controller.Joined})"));
      } else {
        tabs.add(Tab(text: "JOINED"));
      }
      if (controller.customerCompleted != 0) {
        tabs.add(Tab(text: "COMPLETED (${controller.customerCompleted})"));
      } else {
        tabs.add(Tab(text: "COMPLETED"));
      }
      if (controller.customerExited != 0) {
        tabs.add(Tab(text: "EXITED (${controller.customerExited})"));
      } else {
        tabs.add(Tab(text: "EXITED"));
      }
      if (controller.customerCancelled != 0) {
        tabs.add(Tab(text: "CANCELLED (${controller.customerCancelled})"));
      } else {
        tabs.add(Tab(text: "CANCELLED"));
      }
      if (controller.customerFailed != 0) {
        tabs.add(Tab(text: "FAILED (${controller.customerFailed})"));
      } else {
        tabs.add(Tab(text: "FAILED"));
      }
    } else {
      if (controller.ongoing != 0) {
        tabs.add(Tab(text: "ONGOING (${controller.ongoing})"));
      } else {
        tabs.add(Tab(text: "ONGOING"));
      }
      if (controller.createrCompleted != 0) {
        tabs.add(Tab(text: "COMPLETED (${controller.createrCompleted})"));
      } else {
        tabs.add(Tab(text: "COMPLETED"));
      }
      if (controller.createrFailed != 0) {
        tabs.add(Tab(text: "FAILED (${controller.createrFailed})"));
      } else {
        tabs.add(Tab(text: "FAILED"));
      }
      if (controller.createrCancelled != 0) {
        tabs.add(Tab(text: "CANCELLED (${controller.createrCancelled})"));
      } else {
        tabs.add(Tab(text: "CANCELLED"));
      }
    }
    return tabs;
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
  _tabbarData() => SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.forCustomerCampaign
              ? controller.campaignCustomerResponseModel.data?.length ?? 0
              : controller.campaignCreatorResponseModel.data?.length ?? 0,
          itemBuilder: (context, index) {
            return controller.forCustomerCampaign
                ? _card(index, controller.currentIndex)
                : _ongoing(index, controller.currentIndex);
          },
        ).paddingSymmetric(horizontal: margin_20),
      );

  _dividerView() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: Colors.grey.shade300,
        ),
      );

  Widget _card(int index, int tabindex) {
    var campaign = controller.campaignCustomerResponseModel.data?[index];
    var campaignName = campaign?.campaignId?.campaignName;
    var productId = campaign?.campaignId?.productId?.prodctId;
    var price = campaign?.campaignId?.oneProductPrice;
    var quantity = campaign?.campaignId?.totalQuantity;
    var startDuration = campaign?.campaignId?.startDate;
    var endDuration = campaign?.campaignId?.endDate;
    DateTime? startDate =
        DateTime.fromMillisecondsSinceEpoch(startDuration ?? 0);
    DateTime? endDate = DateTime.fromMillisecondsSinceEpoch(endDuration ?? 0);
    String endFormattedDate = DateFormat('dd/MMM/yyyy').format(endDate);
    int endDateMills = controller
            .campaignCustomerResponseModel.data?[index].campaignId?.endDate ??
        0;
    debugPrint("End Date Millis is $endDateMills");

    return InkWell(
      onTap: () {
        if (tabindex == 0) {
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: controller
                .campaignCustomerResponseModel.data?[index].campaignId?.sId,
            argForJoined: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabindex == 1) {
          debugPrint("TabIndex is:----$tabindex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: controller
                .campaignCustomerResponseModel.data?[index].campaignId?.sId,
            argForCustomerCompleted: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabindex == 2) {
          debugPrint("TabIndex is:----$tabindex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: controller
                .campaignCustomerResponseModel.data?[index].campaignId?.sId,
            argForCustomerExited: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabindex == 3) {
          debugPrint("TabIndex is:----$tabindex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: controller
                .campaignCustomerResponseModel.data?[index].campaignId?.sId,
            argForCustomerCancelled: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabindex == 4) {
          debugPrint("TabIndex is:----$tabindex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId: controller
                .campaignCustomerResponseModel.data?[index].campaignId?.sId,
            argForCustomerFailed: true,
            argForCustomer: controller.forCustomerCampaign
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_12),
            border: Border.all(color: AppColors.borderColor, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // AssetImageWidget(demoImagesRectangle183572,
                //     imageWidth: height_70, imageHeight: height_60).paddingOnly(top: 10),
                SizedBox(
                  height: height_70,
                  width: height_70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: NetworkImageWidget(
                      imageUrl: controller.campaignCustomerResponseModel
                              .data?[index].campaignId?.image ??
                          "",
                      imageHeight: height_60,
                      imageWidth: height_70,
                      imageFitType: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextViewLimit(
                            text: controller.campaignCustomerResponseModel
                                .data?[index].campaignId?.productId?.name,
                            textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                            maxLines: 3,
                            charLimit: 22)
                        .paddingOnly(top: margin_10, bottom: margin_10),
                    TextView(
                      maxLines: 3,
                      text: "$productId",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: font_12,
                          color: Colors.grey),
                    ),
                    TextView(
                      text: "\$$price",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontSize: font_16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ).paddingOnly(left: margin_12)
              ],
            )
                .paddingOnly(top: margin_8)
                .paddingSymmetric(horizontal: margin_20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  text: strCampaignName,
                  textStyle: textStyleBodyMedium().copyWith(
                      fontSize: font_12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.DustyGray),
                ),
                TextView(
                  text: "$campaignName",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontSize: font_12, fontWeight: FontWeight.w600),
                ),
              ],
            )
                .paddingOnly(top: margin_8)
                .paddingSymmetric(horizontal: margin_20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  text: strQuantity,
                  textStyle: textStyleBodyMedium().copyWith(
                      fontSize: font_12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.DustyGray),
                ),
                TextView(
                  text: "${quantity} Piece",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontSize: font_12, fontWeight: FontWeight.w600),
                ),
              ],
            ).paddingSymmetric(vertical: margin_10, horizontal: margin_20),
            _dividerView(),
            (controller.currentIndex == 0)
                ? _orderConfirmedView(tabindex, endDateMills)
                : (controller.currentIndex == 1)
                    ? _orderConfirmedView(tabindex, endDateMills)
                    : _canceledView(endFormattedDate)
          ],
        ),
      ).paddingSymmetric(vertical: margin_10),
    );
  }

  _orderConfirmedView(int index, int endDatemills) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (controller.currentIndex == 1)
              ? AssetSVGWidget(iconsOrderConfirmRight)
              : _timerView(index, endDatemills),
          (controller.currentIndex == 1)
              ? TextView(
                  text: " $strOrderConfirmed",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontSize: font_12, fontWeight: FontWeight.w500),
                )
              : SizedBox(),
          Spacer(),
          AssetSVGWidget(iconsQuestionMark),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.contactUsRoute);
            },
            child: TextView(
              text: " $strNeedHelp",
              textStyle: textStyleBodyMedium().copyWith(
                  fontSize: font_12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.DustyGray),
            ),
          ),
        ],
      ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);

  Widget _timerView(int index, int endDatemills) {
    if (index == 1) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.Porcelain,
          borderRadius: BorderRadius.all(Radius.circular(radius_4)),
        ),
        child: TextView(
          text: "COMPLETED",
          textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_12,
            fontWeight: FontWeight.w500,
            color: AppColors.gradient2nd,
          ),
        ).paddingSymmetric(vertical: margin_2, horizontal: margin_4),
      );
    } else if (index == 2) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.all(Radius.circular(radius_4)),
        ),
        child: TextView(
          text: "Failed",
          textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ).paddingSymmetric(vertical: margin_2, horizontal: margin_4),
      );
    } else if (index == 3) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.all(Radius.circular(radius_4)),
        ),
        child: TextView(
          text: "Cancelled",
          textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ).paddingSymmetric(vertical: margin_2, horizontal: margin_4),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.Porcelain,
          borderRadius: BorderRadius.all(Radius.circular(radius_4)),
        ),
        child: CountDownWidget(
                time: DateTime.fromMillisecondsSinceEpoch(endDatemills))
            .paddingSymmetric(vertical: margin_2, horizontal: margin_4),
      );
    }
  }

  Widget _canceledView(String endDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsCancel).paddingOnly(top: margin_2),
            if (controller.currentIndex == 2) ...[
              TextView(
                text: "You exited this Campaign $endDate",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontSize: font_12, fontWeight: FontWeight.w500),
              ).paddingOnly(left: margin_10),
            ],
            if (controller.currentIndex == 3) ...[
              TextView(
                text: "This campaign has been cancelled",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontSize: font_12, fontWeight: FontWeight.w500),
              ).paddingOnly(left: margin_10),
            ],
            if (controller.currentIndex == 4) ...[
              TextView(
                text: "FAILED",
                textStyle: textStyleBodyMedium().copyWith(
                    fontSize: font_12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ).paddingOnly(left: margin_10),
            ],
          ],
        ),
        if (controller.currentIndex == 2) ...[
          TextView(
            text: strCampaignExited,
            textStyle: textStyleBodyMedium().copyWith(
                fontSize: font_12,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor),
          ).paddingOnly(top: margin_2),
        ],
        if (controller.currentIndex == 3) ...[
          TextView(
            text: strCampaignCancelled,
            textStyle: textStyleBodyMedium().copyWith(
                fontSize: font_12,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor),
          ).paddingOnly(top: margin_2),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsQuestionMark),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.contactUsRoute);
              },
              child: TextView(
                text: " $strNeedHelp",
                textStyle: textStyleBodyMedium().copyWith(
                    fontSize: font_12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.DustyGray),
              ),
            ),
          ],
        ).paddingOnly(top: margin_8)
      ],
    ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);
  }

  Widget _ongoing(int index, int tabIndex) {
    var campaign = controller.campaignCreatorResponseModel.data?[index];
    var campaignName = campaign?.campaignName;
    debugPrint('campaingn name is $campaignName');
    var groupName = campaign?.groupId?.groupName;
    debugPrint('groupName is $groupName');
    var startDuration = campaign?.startDate;
    var endDuration = campaign?.endDate;
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startDuration);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDuration);
    String startFormattedDate = DateFormat('dd/MMM/yyyy').format(startDate);
    String endFormattedDate = DateFormat('dd/MMM/yyyy').format(endDate);
    print('Start Date: $startFormattedDate');
    print('End Date: $endFormattedDate');
    var userJoined = campaign?.userJoined;
    var price = campaign?.oneProductPrice;
    int endDateMills =
        controller.campaignCreatorResponseModel.data?[index].endDate ?? 0;

    return InkWell(
      onTap: () {
        if (tabIndex == 0) {
          debugPrint("TabIndex is:----$tabIndex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId:
                controller.campaignCreatorResponseModel.data?[index].sId,
            argForOngoing: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabIndex == 1) {
          debugPrint("TabIndex is:----$tabIndex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId:
                controller.campaignCreatorResponseModel.data?[index].sId,
            argForCompleted: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabIndex == 2) {
          debugPrint("TabIndex is:----$tabIndex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId:
                controller.campaignCreatorResponseModel.data?[index].sId,
            argForFailed: true,
            argForCustomer: controller.forCustomerCampaign
          });
        } else if (tabIndex == 3) {
          debugPrint("TabIndex is:----$tabIndex");
          Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
            argCampaignId:
                controller.campaignCreatorResponseModel.data?[index].sId,
            argForCustomer: controller.forCustomerCampaign,
            argForCancelled: true,
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_8),
            border: Border.all(color: AppColors.borderColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // AssetImageWidget(demoImagesRectangle183572,
                //     imageWidth: height_70, imageHeight: height_60),
                SizedBox(
                  height: height_70,
                  width: height_70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: NetworkImageWidget(
                      imageUrl: controller.campaignCreatorResponseModel
                              .data?[index].image ??
                          "",
                      imageHeight: height_60,
                      imageWidth: height_70,
                      imageFitType: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: controller.campaignCreatorResponseModel.data?[index]
                          .campaignName,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontSize: font_16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: margin_15),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.Porcelain,
                          borderRadius: BorderRadius.circular(radius_4)),
                      child: TextView(
                        text: controller.campaignCreatorResponseModel
                            .data?[index].productId?.name,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: font_12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gradient2nd),
                      ).paddingSymmetric(
                          horizontal: margin_4, vertical: margin_4),
                    )
                  ],
                ).paddingOnly(left: margin_12),
              ],
            ),
            _ongoingCompaignDiscription(
                titleImage: iconsGroup,
                tittle: strGroupName,
                value: groupName,
                isvalueimage: true),
            _ongoingCompaignDiscription(
                titleImage: iconsClockGreen,
                tittle: strCampaignDuration,
                value: '$startFormattedDate-$endFormattedDate',
                isvalueimage: false),
            _ongoingCompaignDiscription(
                titleImage: iconsGroup,
                tittle: strUserJoined,
                value: "$userJoined",
                isvalueimage: false),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _timerView(tabIndex, endDateMills),
                Spacer(),
                TextView(
                  text: "\$$price",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontSize: font_16, fontWeight: FontWeight.w600),
                ),
              ],
            ).paddingOnly(top: margin_20)
          ],
        ).paddingSymmetric(vertical: margin_12, horizontal: margin_20),
      ).paddingOnly(top: margin_15),
    );
  }

  _ongoingCompaignDiscription({titleImage, tittle, value, isvalueimage}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tittle == strUserJoined
              ? AssetSVGWidget(titleImage).paddingOnly(top: margin_4)
              : AssetSVGWidget(titleImage).paddingOnly(top: margin_8),
          Expanded(
            child: tittle == strUserJoined
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text: tittle,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: font_12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.categoriesgrey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isvalueimage
                              ? TextView(
                                  text: value,
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontSize: font_12,
                                      fontWeight: FontWeight.w500),
                                )
                              : TextView(
                                  text: value,
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontSize: font_12,
                                      fontWeight: FontWeight.w500),
                                ).paddingOnly(left: margin_4),
                          isvalueimage
                              ? const AssetSVGWidget(
                                  iconsLockOpen,
                                  imageHeight: 16,
                                  imageWidth: 16,
                                ).paddingOnly(left: margin_4)
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ).paddingOnly(left: margin_8)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tittle == strGroupName
                          ? TextView(
                              text: tittle,
                              textStyle: textStyleBodyMedium().copyWith(
                                  fontSize: font_12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.categoriesgrey),
                            ).paddingOnly(left: margin_4)
                          : TextView(
                              text: tittle,
                              textStyle: textStyleBodyMedium().copyWith(
                                  fontSize: font_12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.categoriesgrey),
                            ),
                      tittle == strGroupName
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                isvalueimage
                                    ? TextView(
                                        text: value,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                fontSize: font_12,
                                                fontWeight: FontWeight.w500),
                                      )
                                    : TextView(
                                        text: value,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                fontSize: font_12,
                                                fontWeight: FontWeight.w500),
                                      ).paddingOnly(left: margin_4),
                                isvalueimage
                                    ? const AssetSVGWidget(
                                        iconsLockOpen,
                                        imageHeight: 16,
                                        imageWidth: 16,
                                      ).paddingOnly(left: margin_4)
                                    : const SizedBox(),
                              ],
                            ).paddingOnly(left: margin_4)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                isvalueimage
                                    ? TextView(
                                        text: value,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                fontSize: font_12,
                                                fontWeight: FontWeight.w500),
                                      )
                                    : TextView(
                                        text: value,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                fontSize: font_12,
                                                fontWeight: FontWeight.w500),
                                      ).paddingOnly(left: margin_4),
                                isvalueimage
                                    ? const AssetSVGWidget(
                                        iconsLockOpen,
                                        imageHeight: 16,
                                        imageWidth: 16,
                                      ).paddingOnly(left: margin_4)
                                    : const SizedBox(),
                              ],
                            )
                    ],
                  ).paddingOnly(left: margin_8),
          )
        ],
      ).paddingOnly(top: margin_20);
}
