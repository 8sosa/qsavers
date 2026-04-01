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

import '../../../export.dart';

class NotificationScreen extends StatelessWidget {
  final controller = Get.put(NotificationController());
  final themeController = Get.put(ThemeController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strNotification.toUpperCase(),
              isBottomWidget: true,
              bottomWidget: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.white,
                labelStyle: textStyleTitleLarge()
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => controller.onTabChanged(index),
                tabs: [
                  TextView(
                    text: strAll.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_13),
                  ),
                  TextView(
                    text: strCampaigns.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_13),
                  ),
                  TextView(
                    text: strORDERS.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_13),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children:[
                (controller.userNotificationResponseModel.data
                                ?.readNotifications?.length ==
                            0 &&
                        controller.userNotificationResponseModel.data
                                ?.unreadNotifications?.length ==
                            0)
                    ? _noCouponScreen()
                    : _allList(),
                (controller.userNotificationResponseModel.data
                                ?.readNotifications?.length ==
                            0 &&
                        controller.userNotificationResponseModel.data
                                ?.unreadNotifications?.length ==
                            0)
                    ? _noCouponScreen()
                    : _campaignslist(),
                (controller.userNotificationResponseModel.data
                                ?.readNotifications?.length ==
                            0 &&
                        controller.userNotificationResponseModel.data
                                ?.unreadNotifications?.length ==
                            0)
                    ? _noCouponScreen()
                    : _ordersList(),
                // _forumsList()
              ],
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
              text: "No Data Found",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  _allList() => _showNotification();

  _campaignslist() => _showNotification();

  _ordersList() => _showNotification();

  _forumsList() => _showNotification();

  _showNotification() =>
      ListView(
        children: [
          controller.userNotificationResponseModel.data?.unreadCount!=0?Container(
            padding: EdgeInsets.only(
                left: margin_20,
                right: margin_20,
                top: margin_20,
                bottom: margin_14),
            child: _heading(strUnreadNotification, "Mark all read"),
          ):const SizedBox(),
          if (controller
                  .userNotificationResponseModel.data?.unreadNotifications !=
              null) ...[
            Container(
              color: AppColors.chatBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: margin_20),
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.userNotificationResponseModel.data
                          ?.unreadNotifications?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            'ORDER_CREATED') {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "ORDER_CREATED",
                                argTitle: "Order Details",
                                argIsRouteForNotificationScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderId
                              });
                        }
                        else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            "REQUESTED_CANCELLED") {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "REQUESTED_CANCELLED",
                                argTitle: "Order Details",
                                argIsRouteForOrderScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderProductId
                              });
                        }
                        else if (controller.userNotificationResponseModel.data
                            ?.unreadNotifications?[index].type ==
                            "ADD_IN_GROUP") {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.forumsChatRoute,
                              arguments: {

                              });
                        }
                        else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            'SHIPPED') {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "SHIPPED",
                                argTitle: "Order Details",
                                argIsRouteForOrderScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderProductId
                              });
                        } else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            'ORDER_CANCELLED_REQUESTED') {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "ORDER_CANCELLED_REQUESTED",
                                argTitle: "Order Details",
                                argIsRouteForNotificationScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderId
                              });
                        } else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            'CANCELLED') {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "CANCELLED",
                                argTitle: "Order Details",
                                argIsRouteForOrderScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderProductId
                              });
                        } else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            'DELIVERED') {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                              arguments: {
                                argForOrderPlaced: "DELIVERED",
                                argTitle: "Order Details",
                                argIsRouteForOrderScreen: true,
                                argOrderId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .orderProductId
                              });
                        } else if (controller.userNotificationResponseModel.data
                                ?.unreadNotifications?[index].type ==
                            "CAMPAIGN") {
                          controller.readSingleNotifications(controller
                              .userNotificationResponseModel
                              .data
                              ?.unreadNotifications?[index]
                              .sId);
                          Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
                              arguments: {
                                argCampaignId: controller
                                    .userNotificationResponseModel
                                    .data
                                    ?.unreadNotifications?[index]
                                    .campaignId
                              });
                        }
                      },
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        contentPadding: EdgeInsets.zero,
                        leading: (controller.userNotificationResponseModel.data
                                        ?.unreadNotifications?[index].images !=
                                    null &&
                                controller
                                        .userNotificationResponseModel
                                        .data
                                        ?.unreadNotifications?[index]
                                        .images
                                        ?.length !=
                                    0)
                            ? NetworkImageWidget(
                                imageUrl: controller
                                        .userNotificationResponseModel
                                        .data
                                        ?.unreadNotifications?[index]
                                        .images?[0] ??
                                    '',
                                imageHeight: height_40,
                                imageWidth: width_60,
                              )
                            : SizedBox(
                                height: 40,
                                width: 60,
                              ),
                        title: TextView(
                          text:
                              "${controller.userNotificationResponseModel.data?.unreadNotifications?[index].message}",
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: font_14),
                        ),
                        subtitle: TextView(
                          text:
                              "${convertMillisecondsToTimeAgo(int.parse(controller.userNotificationResponseModel.data?.unreadNotifications?[index].createdAt ?? '0'))}",
                          textStyle: TextStyle(
                              color: AppColors.darkGreyColor,
                              fontSize: font_12),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            controller.readSingleNotifications(controller
                                .userNotificationResponseModel
                                .data
                                ?.unreadNotifications?[index]
                                .sId);
                          },
                          child: const SizedBox(
                            height: double.infinity,
                            child: Icon(
                              Icons.circle,
                              color: AppColors.gradient2nd,
                              size: 6,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          if (controller
                  .userNotificationResponseModel.data?.readNotifications !=
              null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: margin_20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: margin_24),
                    child: _heading(strReadNotification, ""),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.userNotificationResponseModel.data
                            ?.readNotifications?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (controller.userNotificationResponseModel.data
                                  ?.readNotifications?[index].type ==
                              'ORDER_CREATED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced: "ORDER_CREATED",
                                  argTitle: "Order Details",
                                  argIsRouteForNotificationScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderId
                                });
                          }
                          if (controller.userNotificationResponseModel.data
                                  ?.readNotifications?[index].type ==
                              'REQUESTED_CANCELLED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced: "REQUESTED_CANCELLED",
                                  argTitle: "Order Details",
                                  argIsRouteForOrderScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderProductId
                                });
                          } else if (controller.userNotificationResponseModel
                                  .data?.readNotifications?[index].type ==
                              'SHIPPED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced: "SHIPPED",
                                  argTitle: "Order Details",
                                  argIsRouteForOrderScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderProductId
                                });
                          } else if (controller.userNotificationResponseModel
                                  .data?.readNotifications?[index].type ==
                              'ORDER_CANCELLED_REQUESTED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced:
                                      "ORDER_CANCELLED_REQUESTED",
                                  argTitle: "Order Details",
                                  argIsRouteForNotificationScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderId
                                });
                          } else if (controller.userNotificationResponseModel
                                  .data?.readNotifications?[index].type ==
                              'CANCELLED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced: "CANCELLED",
                                  argTitle: "Order Details",
                                  argIsRouteForOrderScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderProductId
                                });
                          } else if (controller.userNotificationResponseModel
                                  .data?.readNotifications?[index].type ==
                              'DELIVERED') {
                            Get.toNamed(AppRoutes.orderPlacedScreenRoute,
                                arguments: {
                                  argForOrderPlaced: "DELIVERED",
                                  argTitle: "Order Details",
                                  argIsRouteForOrderScreen: true,
                                  argOrderId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .orderProductId
                                });
                          } else if (controller.userNotificationResponseModel
                                  .data?.readNotifications?[index].type ==
                              "CAMPAIGN") {
                            Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
                                arguments: {
                                  argCampaignId: controller
                                      .userNotificationResponseModel
                                      .data
                                      ?.readNotifications?[index]
                                      .campaignId
                                });
                          }
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: (controller
                                          .userNotificationResponseModel
                                          .data
                                          ?.readNotifications?[index]
                                          .images !=
                                      null &&
                                  controller
                                          .userNotificationResponseModel
                                          .data
                                          ?.readNotifications?[index]
                                          .images
                                          ?.length !=
                                      0)
                              ? NetworkImageWidget(
                                  imageUrl: controller
                                          .userNotificationResponseModel
                                          .data
                                          ?.readNotifications?[index]
                                          .images![0] ??
                                      '',
                                  imageHeight: height_40,
                                  imageWidth: width_60,
                                )
                              : SizedBox(
                                  height: 40,
                                  width: 60,
                                ),
                          title: TextView(
                            text:
                                "${controller.userNotificationResponseModel.data?.readNotifications?[index].message}",
                            textStyle: TextStyle(
                                color: Colors.black, fontSize: font_14),
                          ),
                          subtitle: TextView(
                            text:
                                "${convertMillisecondsToTimeAgo(int.parse(controller.userNotificationResponseModel.data?.readNotifications?[index].createdAt ?? '0'))}",
                            textStyle: TextStyle(
                                color: AppColors.darkGreyColor,
                                fontSize: font_12),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ]
        ],
      );

  _heading(String head, String buttonTxt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: head,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: font_16),
        ),
        (buttonTxt != '')
            ? InkWell(
                onTap: () {
                  controller.readNotifications();
                },
                child: TextView(
                  text: buttonTxt,
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.gradient2nd,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
