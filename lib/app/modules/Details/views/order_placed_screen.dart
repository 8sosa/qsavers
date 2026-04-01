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

import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/core/widget/image_preview_widget.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../export.dart';

class OrderPlacedScreen extends StatelessWidget {
  final controller = Get.put(OrderPlacedController());
  final themeController = Get.put(ThemeController());

  OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("controller.afterReviewed ${controller.afterReviewed}");
    return WillPopScope(
      onWillPop: () async {
        (controller.isForOrderScreen == true ||
                controller.isForNotificationScreen == true)
            ? Get.back()
            : Get.offAllNamed(AppRoutes.mainScreenRoute);
        return false;
      },
      child: GetBuilder<OrderPlacedController>(
          init: OrderPlacedController(),
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                onTap: () {
                  Get.back(result: true);
                },
                appBarTitleText: controller.title,
                // isBottomWidget: false,
                // isLeadingPresent: false,
                hideBackIcon: (controller.isForOrderScreen == true ||
                        controller.isForNotificationScreen == true)
                    ? false
                    : true,
              ),
              body: controller.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.gradient2nd,
                    ))
                  : Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.isForOrderScreen == true ||
                                  controller.isForNotificationScreen ==
                                      true) ...[
                                const SizedBox()
                              ] else ...[
                                tittleView(),
                                _dividerView(),
                                TextView(
                                  text: strOrderDetails.toUpperCase(),
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ).paddingSymmetric(horizontal: margin_20),
                              ],
                              _itemDetailView(),
                              _dividerView(),
                              controller.isForCampaign
                                  ? TextView(
                                      text: strCampaignDetails.toUpperCase(),
                                      textStyle: textStyleBodyMedium().copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ).paddingSymmetric(horizontal: margin_20)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? SizedBox(height: margin_12)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key: "Group Name ",
                                      value:
                                          "${controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.groupId?.groupName ?? ""}",
                                      icon: (controller
                                              .orderDetailsResponceModel
                                              ?.data
                                              ?.orderId
                                              ?.campaignId
                                              ?.groupId
                                              ?.groupType ==
                                          strPrivate.toUpperCase()))
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key: "Campaign Name  ",
                                      value:
                                          "${controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.campaignName ?? ""}",
                                      icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key:
                                          "Remaining Quantity to Complete Campaign ",
                                      value:
                                          "${(controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.quantity ?? 0) <= 0 ? 0 : controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.quantity}",
                                      icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key: "Users Joined Campaign ",
                                      value:
                                          "${controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.userJoined ?? ""}",
                                      icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                  key: "Quantity ",
                                  value:
                                  "${controller.orderDetailsResponceModel?.data?.otherOrderItems?.length ?? "0"}",
                                  icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key: "Campaign Start Date ",
                                      value: millisecondsToCustomDateFormat(
                                          int.parse(
                                              "${controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.startDate ?? 0}")),
                                      icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _detailsValue(
                                      key: "Campaign End Date ",
                                      value: millisecondsToCustomDateFormat(
                                          int.parse(
                                              "${controller.orderDetailsResponceModel?.data?.orderId?.campaignId?.endDate ?? 0}")),
                                      icon: false)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? SizedBox(height: margin_12)
                                  : SizedBox(),
                              controller.isForCampaign
                                  ? _dividerView()
                                  : SizedBox(),
                              TextView(
                                text: strShippingDetails.toUpperCase(),
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ).paddingSymmetric(horizontal: margin_20),
                              _customerDetailsView(),
                              _dividerView(),
                              TextView(
                                text: strDeliveryStatus.toUpperCase(),
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ).paddingSymmetric(horizontal: margin_20),
                              _deliveryStatusView(),
                              (controller.argument == strOrderConfirmed &&
                                      controller.activeIndex <= 3)
                                  ? _trackLinkView()
                                  : const SizedBox(),
                              (controller.argument == "ORDER_CREATED" &&
                                      controller.activeIndex <= 3)
                                  ? _trackLinkView()
                                  : const SizedBox(),
                              (controller.argument == "SHIPPED" &&
                                      controller.activeIndex <= 3)
                                  ? _trackLinkView()
                                  : const SizedBox(),
                              controller.afterReviewed
                                  ? _dividerView()
                                  : const SizedBox(),
                              controller.afterReviewed == true
                                  ? _givenRatingView()
                                  : const SizedBox(),
                              ((controller.argument == "SHIPPED" &&
                                          controller.orderDetailsResponceModel
                                                  .data?.reviews?.isNotEmpty ==
                                              true) ||
                                      (controller.argument == "DELIVERED" &&
                                          controller.orderDetailsResponceModel
                                                  .data?.reviews?.isNotEmpty ==
                                              true))
                                  ? _givenRatingView()
                                  : SizedBox(),
                              (controller.argument == strOrderCancelled ||
                                      controller.argument ==
                                          "ORDER_CANCELLED_REQUESTED")
                                  ? _orderCancelView()
                                  : const SizedBox(),
                              ((controller.argument == strOrderCancelled &&
                                          controller
                                                  .orderDetailsResponceModel
                                                  .data
                                                  ?.cancelRequestAccepted ==
                                              false) ||
                                      (controller.argument ==
                                              "ORDER_CANCELLED_REQUESTED" &&
                                          controller
                                                  .campaignCompletedOrderResponseModel
                                                  .data
                                                  ?.orderProducts![0]
                                                  .cancelRequestAccepted ==
                                              false))
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.dialog(CustomDialogWidget(
                                          title:
                                              "Are you sure you want to Cancel Your Cancellation request?",
                                          confirmTitle: strYes,
                                          cancelTitle: strNo,
                                          confirmBtnBgColor: Colors.red,
                                          image: controller.argument ==
                                                  "ORDER_CANCELLED_REQUESTED"
                                              ? controller
                                                      .campaignCompletedOrderResponseModel
                                                      .data
                                                      ?.orderProducts![0]
                                                      .products
                                                      ?.images![0] ??
                                                  ""
                                              : controller
                                                      .orderDetailsResponceModel
                                                      .data
                                                      ?.productId
                                                      ?.images?[0] ??
                                                  "",
                                          cancelTitleColor:
                                              AppColors.gradientColorSecondary,
                                          cancelBtnBorder: Border.all(
                                              color: AppColors.borderColor,
                                              width: 1),
                                          cancelBtnBgColor: Colors.transparent,
                                          onTapConfirm: () {
                                            Get.back();
                                            controller.argument ==
                                                    "ORDER_CANCELLED_REQUESTED"
                                                ? controller
                                                    .hitCancelRequestOrderApiFromNotificationRoute(
                                                        controller
                                                            .campaignCompletedOrderResponseModel
                                                            .data
                                                            ?.orderProducts![0]
                                                            .sId)
                                                : controller
                                                    .hitCancelRequestOrderApi();
                                          },
                                          isImage: true,
                                          isCloseBtn: true,
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextView(
                                          text: "CANCEL REQUEST",
                                          textStyle: textStyleBodyMedium()
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                        ).paddingSymmetric(
                                            horizontal: margin_12,
                                            vertical: margin_4),
                                      ).paddingSymmetric(
                                          horizontal: margin_20,
                                          vertical: margin_10),
                                    )
                                  : SizedBox(),
                            ],
                          ).paddingSymmetric(vertical: margin_20),
                        )),
                        (controller.afterReviewed ||
                                controller.argument == "SHIPPED" ||
                                // controller.argument == "ORDER_CREATED" ||
                                controller.argument ==
                                    "ORDER_CANCELLED_REQUESTED" ||
                                controller.argument == "CANCELLED")
                            ? const SizedBox()
                            :
                            /* : controller.canAddReviewResponseModel.data?.canReview ==
                              true || controller.argument==strOrderConfirmed || controller.argument==strForNormalOrderPlace|| controller.argument==
                          ?*/
                            _bottomButton()
                        // : const SizedBox(),
                      ],
                    ),
            );
          }),
    );
  }

  Widget tittleView() => Center(
          child: Column(
        children: [
          const AssetSVGWidget(iconsConfirmedplaced,),
          TextView(
            text: controller.bannerTitle,
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          ).paddingOnly(top: margin_12),
          TextView(
            text: controller.bannerSubTitle,
            textStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.categoriesgrey),
          ),
        ],
      ));

  _dividerView() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: Colors.grey.shade300,
        ),
      ).paddingSymmetric(vertical: margin_20);

  _itemDetailView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              TextView(
                text: strItemDetails,
                textStyle: textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Spacer(),
              TextView(
                text: controller.isForNotificationScreen == true
                    ? "#${controller.campaignCompletedOrderResponseModel.data?.orderId}"
                    : "#${controller.orderDetailsResponceModel?.data?.orderId?.orderId ?? ""}",
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.categoriesgrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height_60,
                width: height_60,
                child: controller.isForNotificationScreen == true
                    ? NetworkImageWidget(
                        imageUrl: controller.campaignCompletedOrderResponseModel
                                .data?.orderProducts?[0].products?.images?[0] ??
                            "",
                        imageHeight: height_70,
                        imageWidth: height_80,
                        radiusAll: radius_8,
                        imageFitType: BoxFit.cover)
                    : NetworkImageWidget(
                        imageUrl: controller.orderDetailsResponceModel.data
                                ?.productId?.images?.first ??
                            "",
                        imageHeight: height_70,
                        imageWidth: height_80,
                        radiusAll: radius_8,
                        imageFitType: BoxFit.cover),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: controller.isForNotificationScreen == true
                          ? controller.campaignCompletedOrderResponseModel.data
                                  ?.orderProducts![0].products?.name ??
                              ''
                          : controller.orderDetailsResponceModel.data?.productId
                                  ?.name ??
                              "",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ).paddingOnly(left: margin_10),
                    TextView(
                      maxLines: 4,
                      text: controller.isForNotificationScreen == true
                          ? "(SKU: ${controller.campaignCompletedOrderResponseModel.data?.orderProducts?[0].products?.productId})"
                          : "(SKU: ${controller.orderDetailsResponceModel.data?.productId?.productId})"
                              "",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.DustyGray),
                    ).paddingOnly(top: margin_4, left: margin_10),
                    TextView(
                      text: controller.isForNotificationScreen == true
                          ? "\$${(controller.campaignCompletedOrderResponseModel.data?.orderProducts?[0].totalPrice ?? 0.0).toStringAsFixed(2)}"
                          : "\$${(controller.orderDetailsResponceModel.data?.orderId?.totalPrice ?? 0.0).toStringAsFixed(2)}",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ).paddingOnly(top: margin_4, left: margin_10),
                  ],
                ).paddingOnly(left: margin_20),
              )
            ],
          ).paddingSymmetric(vertical: margin_20),
          (controller.show == true || controller.argument == "ORDER_CREATED")
              ? Row(
                  children: [
                    const AssetSVGWidget(iconsOrderConfirmRight),
                    TextView(
                      text: controller.argument == "ORDER_CREATED"
                          ? "Order ${controller.campaignCompletedOrderResponseModel.data?.orderProducts?[0].orderStatus}"
                          : "Order ${controller.orderDetailsResponceModel.data?.orderStatus ?? ""}",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                    ).paddingOnly(left: margin_4),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.contactUsRoute);
                      },
                      child: Row(
                        children: [
                          const AssetSVGWidget(iconsQuestionMark),
                          TextView(
                            text: strNeedHelp,
                            textStyle: textStyleBodyMedium().copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.DustyGray),
                          ).paddingOnly(left: margin_4)
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          (controller.argument == strOrderCancelled ||
                  controller.argument == "ORDER_CANCELLED_REQUESTED" ||
                  controller.argument == "CANCELLED")
              ? SizedBox()
              : controller.argument == strOrderConfirmed
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const AssetSVGWidget(iconsOrderConfirmRight),
                        TextView(
                          text:
                              "Order ${controller.orderDetailsResponceModel.data?.orderStatus ?? ""}",
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ).paddingOnly(left: margin_4),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.contactUsRoute);
                          },
                          child: Row(
                            children: [
                              const AssetSVGWidget(iconsQuestionMark),
                              TextView(
                                text: strNeedHelp,
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.DustyGray),
                              ).paddingOnly(left: margin_4)
                            ],
                          ),
                        ).paddingOnly(left: margin_32)
                      ],
                    )
                  : controller.orderDetailsResponceModel.data?.deliveryDate !=
                          null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AssetSVGWidget(iconsOrderConfirmRight)
                                .paddingOnly(top: margin_2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextView(
                                  text:
                                      "Delivered on ${DateFormat('E, d MMM').format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(controller.orderDetailsResponceModel.data?.deliveryDate ?? "8") ?? 8))}",
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextView(
                                  text: strItemDelivered,
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.DustyGray),
                                )
                              ],
                            ).paddingOnly(left: margin_10),
                          ],
                        )
                      : SizedBox(),
          (controller.bottomButtonTitle == strWriteAProductReview)
              ? InkWell(
                  onTap: () async {
                    debugPrint("order id is ${controller.orderId}");
                    var launchLink =
                        "https://quantitysavers.com/account/order/${controller.orderId}?access_token=${controller.token}";
                    launchUrl(Uri.parse(launchLink),
                        mode: LaunchMode.externalApplication);
                   // controller.openFile(path: launchLink,controller: controller);
                   //  downloadFiles(
                   //    openFileFunctionCall: (String value) {
                   //    controller.openFile(path: value, controller: controller);
                   //    },
                   //    url: '${item?.message ?? ""}',
                   //    name: '${item?.message?.split('/').last ?? ""}',
                   //    path: (String path) {
                   //      controller.directory = path;
                   //    },
                   //    extension: item?.message.toString().split('.').last,
                   //  );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_4),
                      border:
                          Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AssetSVGWidget(iconsDownload),
                        TextView(
                          text: strDownloadInvoice,
                          textStyle: textStyleBodyMedium().copyWith(
                              color: AppColors.gradient2nd,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ).paddingSymmetric(vertical: margin_8),
                  ).paddingOnly(top: margin_12),
                )
              : const SizedBox(),
          (controller.argument == strOrderCancelled ||
                  controller.argument == "ORDER_CANCELLED_REQUESTED" ||
                  controller.argument == "CANCELLED")
              ? _canceledView()
              : SizedBox()
        ],
      ).paddingSymmetric(horizontal: margin_20);

  _detailsValue({key, keyTextstyle, value, valuetextstyle, icon}) => Row(
        children: [
          Expanded(
            child: TextView(
              maxLines: 3,
              text: key.toString(),
              textStyle: keyTextstyle ??
                  textStyleBodyMedium().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          const Spacer(),
          TextView(
            maxLines: 3,
            text: value.toString(),
            textStyle: valuetextstyle ??
                textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          icon
              ? const AssetSVGWidget(iconsCompaignLocked)
                  .paddingOnly(left: margin_4)
              : const SizedBox(width: 0, height: 0)
        ],
      ).paddingSymmetric(horizontal: margin_20).paddingOnly(top: margin_12);

  _customerDetailsView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextView(
                text: controller.isForNotificationScreen == true
                    ? controller.campaignCompletedOrderResponseModel.data
                            ?.addressId?.name ??
                        ""
                    : controller
                            .orderDetailsResponceModel.data?.addressId?.name ??
                        "",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.gradient2nd,
                    borderRadius: BorderRadius.circular(5)),
                child: TextView(
                  text: controller.isForNotificationScreen == true
                      ? controller.campaignCompletedOrderResponseModel.data
                              ?.addressId?.addressType ??
                          ""
                      : controller.orderDetailsResponceModel.data?.addressId
                              ?.addressType ??
                          "",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ).paddingSymmetric(horizontal: margin_12, vertical: margin_4),
              )
            ],
          ),
          TextView(
            maxLines: 3,
            text: controller.isForNotificationScreen == true
                ? controller.campaignCompletedOrderResponseModel.data?.addressId
                        ?.fullAddress ??
                    ""
                : controller.orderDetailsResponceModel.data?.addressId
                        ?.fullAddress ??
                    "",
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          ).paddingOnly(top: margin_12),
          TextView(
            text: controller.isForNotificationScreen == true
                ? "${controller.campaignCompletedOrderResponseModel.data?.addressId?.countryCode ?? ""} ${controller.campaignCompletedOrderResponseModel.data?.addressId?.phoneNo ?? 0}"
                : "${controller.orderDetailsResponceModel.data?.addressId?.countryCode ?? ""} ${controller.orderDetailsResponceModel.data?.addressId?.phoneNo ?? 0}",
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          ).paddingOnly(top: margin_12),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20);

  _deliveryStatusView() => Column(
        children: [
          AnotherStepper(
            stepperList: controller.stepperData,
            stepperDirection: Axis.vertical,
            iconWidth: 18,
            iconHeight: 18,
            activeBarColor: AppColors.gradient2nd,
            inActiveBarColor: Colors.grey,
            inverted: false,
            verticalGap: 20,
            activeIndex: controller.activeIndex,
            barThickness: 4,
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20);

  _trackLinkView() => Container(
        width: Get.width,
        color: AppColors.chatBackgroundColor,
        child: (controller.orderDetailsResponceModel.data?.trackingLink !=
                    null ||
                controller.campaignCompletedOrderResponseModel.data
                        ?.orderProducts?[0].trackingLink !=
                    null)
            ? InkWell(
                onTap: () {
                  var link = controller.isForNotificationScreen == true
                      ? controller.campaignCompletedOrderResponseModel.data
                          ?.orderProducts![0].trackingLink
                      : controller.orderDetailsResponceModel.data?.trackingLink;
                  var launchLink = "https://$link";
                  launchUrl(Uri.parse(launchLink),
                      mode: LaunchMode.externalApplication);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: strTitleTrackUpdate,
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    InkWell(
                      onTap: () {},
                      child: TextView(
                        text: controller.isForNotificationScreen == true
                            ? controller.campaignCompletedOrderResponseModel
                                .data?.orderProducts![0].trackingLink
                            : controller
                                .orderDetailsResponceModel.data?.trackingLink,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: 12,
                            color: AppColors.gradient2nd,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ).paddingAll(margin_10),
              )
            : TextView(
                text: strTrackNotUpdate,
                textStyle: textStyleBodyMedium().copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ).paddingAll(margin_10),
      ).paddingAll(margin_20);
  _givenRatingView() {
    var date = (controller.argument == "SHIPPED" ||
            controller.argument == "DELIVERED")
        ? "${controller.orderDetailsResponceModel.data?.createdAt ?? ""}"
        : "${controller.userProductReviewResponseModel.data?.data?[0].createdAt ?? ""}";

    int? reviewDate;
    if (date.isNotEmpty) {
      reviewDate = int.tryParse(date);
    }

    if (reviewDate != null) {
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(reviewDate);
      controller.startFormattedDate =
          DateFormat('dd/MMM/yyyy').format(confirmedDate);
    } else {
      print("Failed to parse date: $date");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextView(
          text: strGivenRatingAndReviewByYou,
          textStyle: textStyleBodyMedium()
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(children: [
          RatingBar.builder(
            initialRating: (controller.argument == "SHIPPED" ||
                    controller.argument == "DELIVERED")
                ? controller.orderDetailsResponceModel.data?.reviews![0].ratings
                        ?.toDouble() ??
                    1
                : controller
                    .userProductReviewResponseModel.data?.data?[0].ratings
                    .toDouble(),
            itemSize: 14,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: AppColors.gradient2nd,
            ),
            onRatingUpdate: (rating) {
              debugPrint("$rating");
            },
          ),
          Expanded(
            child: TextView(
              text: (controller.argument == "SHIPPED" ||
                      controller.argument == "DELIVERED")
                  ? "${controller.orderDetailsResponceModel.data?.reviews?[0].ratings}"
                  : "${controller.userProductReviewResponseModel.data?.data?[0].ratings}",
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.gradient2nd,
                  fontWeight: FontWeight.w700,
                  fontSize: font_14),
            ).paddingOnly(left: margin_8),
          ),
          TextView(
            text: controller.startFormattedDate,
            textStyle: textStyleBodyMedium().copyWith(
                color: AppColors.DustyGray,
                fontWeight: FontWeight.w500,
                fontSize: font_14),
          )
        ]),
        TextView(
          text: (controller.argument == "SHIPPED" ||
                  controller.argument == "DELIVERED")
              ? "${controller.orderDetailsResponceModel.data?.reviews?[0].title}"
              : "${controller.userProductReviewResponseModel.data?.data?[0].title}",
          textStyle: textStyleBodyMedium()
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ).paddingSymmetric(vertical: margin_12),
        TextView(
          maxLines: 10,
          text: (controller.argument == "SHIPPED" ||
                  controller.argument == "DELIVERED")
              ? "${controller.orderDetailsResponceModel.data?.reviews?[0].description}"
              : "${controller.userProductReviewResponseModel.data?.data?[0].description}",
          textStyle: textStyleDisplayMedium()
              .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        if ((controller.userProductReviewResponseModel.data?.data?[0].images !=
                    null &&
                controller.userProductReviewResponseModel.data?.data?[0].images
                        ?.length !=
                    0) ||
            (controller.orderDetailsResponceModel.data?.reviews != null &&
                controller.orderDetailsResponceModel.data?.reviews?.length !=
                    0)) ...[
          SizedBox(
            height: height_60,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: (controller.argument == "SHIPPED" ||
                      controller.argument == "DELIVERED")
                  ? controller.orderDetailsResponceModel.data?.reviews![0]
                          .images?.length ??
                      0
                  : controller.userProductReviewResponseModel.data?.data?[0]
                          .images?.length ??
                      0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.dialog(ImagePreviewWidget(
                      imageProvider: (controller.argument == "SHIPPED" ||
                              controller.argument == "DELIVERED")
                          ? controller.orderDetailsResponceModel.data
                              ?.reviews![0].images![index]
                          : controller.userProductReviewResponseModel.data
                              ?.data![0].images![index],
                    ));
                  },
                  child: NetworkImageWidget(
                    imageUrl: (controller.argument == "SHIPPED" ||
                            controller.argument == "DELIVERED")
                        ? controller.orderDetailsResponceModel.data?.reviews![0]
                            .images![index]
                        : controller.userProductReviewResponseModel.data
                            ?.data![0].images![index],
                    imageHeight: height_50,
                    imageWidth: height_50,
                    imageFitType: BoxFit.cover,
                  ).paddingSymmetric(horizontal: margin_1),
                );
              },
            ),
          ).paddingSymmetric(vertical: margin_20),
        ],
        if ((controller.userProductReviewResponseModel.data?.data?[0].videos !=
                    null &&
                controller.userProductReviewResponseModel.data?.data?[0].videos
                        ?.length !=
                    0) ||
            (controller.orderDetailsResponceModel.data?.reviews != null &&
                controller.orderDetailsResponceModel.data?.reviews?.length !=
                    0)) ...[
          SizedBox(
            height: height_60,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: (controller.argument == "SHIPPED" ||
                      controller.argument == "DELIVERED")
                  ? controller.orderDetailsResponceModel.data?.reviews![0]
                          .videos?.length ??
                      0
                  : controller.userProductReviewResponseModel.data?.data?[0]
                          .videos?.length ??
                      0,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.borderColor, width: 1)),
                    child: VideoPreviewWidget(
                      mediaFile: MediaFile(
                          networkPath: (controller.argument == "SHIPPED" ||
                                  controller.argument == "DELIVERED")
                              ? controller.orderDetailsResponceModel.data
                                  ?.reviews![0].videos![index]
                              : controller.userProductReviewResponseModel.data
                                  ?.data?[0].videos?[index]),
                      height: height_135,
                      width: height_50,
                      padding: 60,
                    )).paddingSymmetric(horizontal: margin_1);
              },
            ),
          ).paddingSymmetric(vertical: margin_0)
        ]
      ],
    ).paddingSymmetric(horizontal: margin_20);
  }

  _orderCancelView() => Container(
        decoration: BoxDecoration(
          color: AppColors.chatBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius_12)),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextView(
              text: strOrderCancelRequest,
              textStyle: textStyleBodyMedium()
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            TextView(
              text: strRefundInProgress,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            const Divider(
              color: AppColors.borderColor,
            ).paddingSymmetric(vertical: margin_10),
            TextView(
              text: strRequestCancel,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ).paddingAll(margin_10),
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_10);

  _canceledView() {
    var cancelledDate = int.parse((controller.argument ==
            "ORDER_CANCELLED_REQUESTED")
        ? controller.campaignCompletedOrderResponseModel.data?.orderProducts![0]
                .cancelledAt ??
            '8'
        : (controller.argument == "CANCELLED")
            ? (controller.orderDetailsResponceModel.data?.cancelledAt ?? '8')
            : (controller.orderDetailsResponceModel.data?.cancelledAt ?? '8'));

    DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(cancelledDate);
    String cancelDate = DateFormat('dd/MMM/yyyy').format(confirmedDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AssetSVGWidget(iconsCancel).paddingOnly(top: margin_2),
            (controller.argument == "ORDER_CANCELLED_REQUESTED")
                ? TextView(
                    text: controller.campaignCompletedOrderResponseModel.data
                                ?.orderProducts![0].orderStatus ==
                            "CANCELLED"
                        ? "Order Cancelled"
                        : "Cancellation in progress.",
                    textStyle: textStyleBodyMedium()
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ).paddingOnly(left: margin_10)
                : (controller.argument == "CANCELLED")
                    ? TextView(
                        text: controller.orderDetailsResponceModel.data
                                    ?.orderStatus ==
                                "CANCELLED"
                            ? "Order Cancelled"
                            : "Cancellation in progress.",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ).paddingOnly(left: margin_10)
                    : TextView(
                        text: controller.orderDetailsResponceModel.data
                                    ?.orderStatus ==
                                "CANCELLED"
                            ? "Order Cancelled"
                            : "Cancellation in progress.",
                        textStyle: textStyleBodyMedium().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ).paddingOnly(left: margin_10),
          ],
        ),
        (controller.argument == "ORDER_CANCELLED_REQUESTED")
            ? TextView(
                text: controller.campaignCompletedOrderResponseModel.data
                            ?.orderProducts![0].orderStatus ==
                        "CANCELLED"
                    ? "Order Cancelled"
                    : "Your order has been cancelled as per your request.",
                textStyle: textStyleBodyMedium()
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ).paddingOnly(left: margin_10)
            : (controller.argument == "CANCELLED")
                ? TextView(
                    text: controller
                                .orderDetailsResponceModel.data?.orderStatus ==
                            "CANCELLED"
                        ? "Your item has been cancelled"
                        : "Your order has been cancelled as per your request.",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor),
                  ).paddingOnly(top: margin_2)
                : TextView(
                    text: controller
                                .orderDetailsResponceModel.data?.orderStatus ==
                            "CANCELLED"
                        ? "Your item has been cancelled"
                        : "Your order has been cancelled as per your request.",
                    textStyle: textStyleBodyMedium().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor),
                  ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AssetSVGWidget(iconsQuestionMark),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.contactUsRoute);
              },
              child: TextView(
                text: " $strNeedHelp",
                textStyle: textStyleBodyMedium().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.DustyGray),
              ),
            ),
          ],
        ).paddingOnly(top: margin_8)
      ],
    ).paddingOnly(top: margin_10);
  }

  _bottomButton() {
    if ((controller.argument == strOrderCancelled)) {
      return const SizedBox();
    } else if (controller.activeIndex >= 3 &&
        controller.canAddReviewResponseModel.data?.canReview == false) {
      return const SizedBox();
    } else if (controller.activeIndex >= 3 &&
        controller.canAddReviewResponseModel.data?.canReview == true &&
        controller.argument == "ORDER_CREATED") {
      return const SizedBox();
    } else {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_8),
            border:
                Border(top: BorderSide(width: 1, color: AppColors.borderColor)),
            color: (controller.bottomButtonTitle == strCancelOrder)
                ? AppColors.titleRed
                : AppColors.gradient2nd),
        child: InkWell(
          onTap: () async {
            if (controller.bottomButtonTitle == strCancelOrder) {
              Get.dialog(CustomDialogWidget(
                  title: strconfirmCancelOrder,
                  confirmTitle: stryesCancel,
                  cancelTitle: strdoNotCancel,
                  cancelTitleColor: AppColors.categoriesgrey,
                  isImage: true,
                  image: controller.argument == "ORDER_CREATED"
                      ? controller.campaignCompletedOrderResponseModel.data
                          ?.orderProducts![0].products?.images![0]
                      : controller.orderDetailsResponceModel.data?.productId
                          ?.images?[0],
                  cancelBtnBorder: Border.all(color: AppColors.categoriesgrey),
                  onTapConfirm: () {
                    Get.back();
                    Get.toNamed(AppRoutes.cancelOrderPlacedScreenRoute,
                        arguments: {
                          argId: controller.argument == "ORDER_CREATED"
                              ? controller.campaignCompletedOrderResponseModel
                                  .data?.orderProducts![0].sId
                              : controller
                                      .orderDetailsResponceModel.data?.sId ??
                                  '',
                          argOrderId: controller.argument == "ORDER_CREATED"
                              ? controller
                                  .campaignCompletedOrderResponseModel.data?.sId
                              : controller.orderDetailsResponceModel.data
                                      ?.orderId?.sId ??
                                  ''
                        });
                  },
                  confirmBtnBgColor: AppColors.titleRed));
            } else if ((controller.bottomButtonTitle ==
                strWriteAProductReview)) {
              controller.result = await Get.toNamed(
                  AppRoutes.editReviewsAndRatingsRoute,
                  arguments: {
                    argForWriteReview: strWriteAProductReview,
                    argTitle: strWriteAProductReview,
                    argIsFromProductDetails: true,
                    argId: controller.orderDetailsResponceModel.data?.sId,
                    argProductId: controller
                        .orderDetailsResponceModel.data?.productId?.sId
                  });
              controller.hitGetProductReviewApi(controller.result[argReviewId],
                  controller.result[argProductId]);
              controller.update();
            } else if (controller.bottomButtonTitle == strKeepShoping) {
              Get.offAllNamed(AppRoutes.mainScreenRoute);
            } else if (controller.bottomButtonTitle == strViewCampaign) {
              Get.offAllNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
                argIsRouteForOrderPlacedScreen: true,
                argCampaignId: controller.orderDetailsResponceModel.data
                        ?.orderId?.campaignId?.sId ??
                    "",
              });
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (controller.bottomButtonTitle == strWriteAProductReview)
                  ? AssetSVGWidget(iconsOutlineblankStarIcon,
                          imageWidth: height_15, imageHeight: height_15)
                      .paddingOnly(right: margin_4)
                  : SizedBox(),
              TextView(
                text: controller.bottomButtonTitle,
                textStyle: textStyleBodyMedium().copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ).paddingSymmetric(vertical: margin_12),
        ),
      ).paddingOnly(bottom: margin_42, left: margin_20, right: margin_20);
    }
  }
}
