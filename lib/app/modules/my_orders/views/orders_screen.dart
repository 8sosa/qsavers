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

import 'package:quantity_savers/app/core/widget/customtabindicator.dart';
import 'package:quantity_savers/generated/assets.dart';

import '../../../export.dart';
import '../data_model/order_data_model.dart';

class OrdersScreen extends StatelessWidget {
  final controller = Get.put(OrdersController());
  final themeController = Get.put(ThemeController());

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
        init: OrdersController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strORDERS,
              isBottomWidget: true,
              bottomWidget: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                indicator: CustomTabIndicator(),
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.white,
                labelStyle: textStyleTitleLarge()
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => controller.onTabChanged(index),
                tabs: const [
                  Tab(text: "All Orders"),
                  Tab(text: "Confirmed"),
                  Tab(text: "Delivered"),
                  Tab(text: "Cancelled")
                  // _buildTab("All Orders ", controller.all),
                  // _buildTab("Confirmed", controller.confirmed),
                  // _buildTab("Delivered", controller.delivered),
                  // _buildTab("Cancelled", controller.cancelled)
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                controller.orderResponseModel.totalCount == 0
                    ? _noCouponScreen()
                    : RefreshIndicator(child: _tabbarData(), onRefresh: ()async{
                      controller.refreshAllOrderList();
                },color: AppColors.gradient2nd,),
                controller.orderResponseModel.totalCount == 0
                    ? _noCouponScreen()
                    : RefreshIndicator(child: _tabbarData(), onRefresh: ()async{
                  controller.refreshConfirmedList();
                },color: AppColors.gradient2nd,),
                controller.orderResponseModel.totalCount == 0
                    ? _noCouponScreen()
                    : RefreshIndicator(child: _tabbarData(), onRefresh: ()async{
                      controller.refreshDeliveredList();
                },color: AppColors.gradient2nd,),
                controller.orderResponseModel.totalCount == 0
                    ? _noCouponScreen()
                    : RefreshIndicator(child: _tabbarData(), onRefresh: ()async{
                      controller.refreshCancelledList();
                },color: AppColors.gradient2nd,),
              ],
            ),
          );
        });
  }

  Tab _buildTab(String label, int count) {
    return Tab(
      child: count > 0 ? Text("$label ($count)") : Text(label),
    );
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
          itemCount: controller.orderResponseModel.totalCount ?? 0,
          itemBuilder: (context, index) {
            if (controller.orderResponseModel.data != null &&
                index >= 0 &&
                index < controller.orderResponseModel.data!.length &&
                controller.orderResponseModel.data![index].productId?.images !=
                    null &&
                controller.orderResponseModel.data![index].productId!.images!
                    .isNotEmpty) {
              return _card(index);
            } else {
              return SizedBox();
            }
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

  _card(index) => InkWell(
        onTap: () {
          if ((controller.currentIndex) == 0) {
             if(controller.orderResponseModel.data?[index].orderStatus=="PLACED")
              {
                Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
                  argForOrderPlaced: "Order Confirmed",
                  argTitle: "Order Details",
                  argIsRouteForOrderScreen: true,
                  argOrderId: controller.orderResponseModel.data?[index].sId
                });
              }
            else if(controller.orderResponseModel.data?[index].orderStatus=="DELIVERED")
              {
                Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
                  argForOrderPlaced: "Delivered",
                  argTitle: "Order Details",
                  argReviewId: controller
                      .orderResponseModel.data?[index].productId?.reviews?.sId,
                  argIsRouteForOrderScreen: true,
                  argOrderId: controller.orderResponseModel.data?[index].sId
                });
              }
             else if(controller.orderResponseModel.data?[index].orderStatus=="SHIPPED")
             {
               Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
                 argForOrderPlaced: "Order Confirmed",
                 argTitle: "Order Details",
                 argIsRouteForOrderScreen: true,
                 argOrderId: controller.orderResponseModel.data?[index].sId
               });
             }
            else if(controller.orderResponseModel.data?[index].orderStatus=="CANCELLED")
              {
                Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
                  argForOrderPlaced: "Order Cancelled",
                  argTitle: "Order Details",
                  argIsRouteForOrderScreen: true,
                  argOrderId: controller.orderResponseModel.data?[index].sId
                });
              }

             else if(controller.orderResponseModel.data?[index].orderStatus=="PENDING_CANCELLATION")
             {
               Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
                 argForOrderPlaced: "Order Cancelled",
                 argTitle: "Order Details",
                 argIsRouteForOrderScreen: true,
                 argOrderId: controller.orderResponseModel.data?[index].sId
               });
             }

          }
          else if ((controller.currentIndex) == 1) {
            Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
              argForOrderPlaced: "Order Confirmed",
              argTitle: "Order Details",
              argIsRouteForOrderScreen: true,
              argOrderId: controller.orderResponseModel.data?[index].sId
            });
          }
          else if ((controller.currentIndex) == 2) {
            Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
              argForOrderPlaced: "Delivered",
              argTitle: "Order Details",
              argReviewId: controller
                  .orderResponseModel.data?[index].productId?.reviews?.sId,
              argIsRouteForOrderScreen: true,
              argOrderId: controller.orderResponseModel.data?[index].sId
            });
          }
          else if ((controller.currentIndex) == 3) {
            Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
              argForOrderPlaced: "Order Cancelled",
              argTitle: "Order Details",
              argIsRouteForOrderScreen: true,
              argOrderId: controller.orderResponseModel.data?[index].sId
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor, width: 2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NetworkImageWidget(
                    imageUrl: controller.orderResponseModel.data?[index]
                            .productId?.images?[0] ??
                        '',
                    imageHeight: height_70,
                    imageWidth: height_80,
                    imageFitType: BoxFit.cover,
                  ).paddingOnly(right: margin_12, top: margin_16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextView(
                          maxLines: 2,
                          text: controller
                              .orderResponseModel.data?[index].productId?.name,
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ).paddingOnly(left: margin_30, top: margin_16),
                        TextView(
                          maxLines: 2,
                          text:
                              "(SKU:${controller.orderResponseModel.data?[index].productId?.productId})",
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                        ).paddingOnly(left: margin_30, top: margin_12),
                        TextView(
                          text:
                              "\$${controller.orderResponseModel.data?[index].totalPrice.toStringAsFixed(2)}",
                          textStyle: textStyleBodyMedium().copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ).paddingOnly(left: margin_30, top: margin_12),
                      ],
                    ),
                  )
                ],
              )
                  .paddingOnly(top: margin_8)
                  .paddingSymmetric(horizontal: margin_20),
              if ((controller.currentIndex==0 && controller.orderResponseModel.data?[index].orderStatus!="PENDING_CANCELLATION")||controller.currentIndex == 1 ||
                  controller.currentIndex == 2) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      text: strProductName,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.DustyGray),
                    ),
                    TextView(
                      text:
                          "${controller.orderResponseModel.data?[index].productId?.name}",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.DustyGray),
                    ),
                    TextView(
                      text:
                          "${controller.orderResponseModel.data?[index].quantity} Piece",
                      textStyle: textStyleBodyMedium()
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ).paddingSymmetric(vertical: margin_10, horizontal: margin_20),
              ],
              _dividerView(),
              (controller.currentIndex == 0)
                  ? _allView(controller.orderResponseModel.data?[index])
                  : (controller.currentIndex == 1)
                      ? _orderConfirmedView()
                      : (controller.currentIndex == 2)
                          ? _deliveredView(controller.orderResponseModel
                                  .data?[index].deliveryDate ??
                              "2")
                          : controller.orderResponseModel.data?[index].orderStatus=="CANCELLED"?_canceledView(controller.orderResponseModel
                                  .data?[index].cancelledDate ??
                              "2"):_canceledPendingView(controller.orderResponseModel
                  .data?[index].cancelledDate ??
                  "2")
            ],
          ),
        ).paddingSymmetric(vertical: margin_10),
      );

  _orderConfirmedView() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AssetSVGWidget(iconsOrderConfirmRight),
          TextView(
            text: " $strOrderConfirmed",
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          AssetSVGWidget(iconsQuestionMark),
          InkWell(
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
      ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);

  Widget _deliveredView(String? deliveryDate) {
    String? startFormattedDate;
    if (deliveryDate != null) {
      var startDate = int.parse(deliveryDate ?? "8");
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      startFormattedDate = DateFormat('dd/MMM/yyyy').format(confirmedDate);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AssetSVGWidget(iconsOrderConfirmRight).paddingOnly(top: margin_2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextView(
              text: deliveryDate != null
                  ? "Delivered on $startFormattedDate"
                  : "Delivered on 30 Sept",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
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
    ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);
  }

  Widget _canceledView(String? cancelledDate) {
    String? cancelledFormattedDate;
    if (cancelledDate != null) {
      var startDate = int.parse(cancelledDate ?? "8");
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      cancelledFormattedDate = DateFormat('dd/MMM/yyyy').format(confirmedDate);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsCancel).paddingOnly(top: margin_2),
            TextView(
              text: cancelledDate != null
                  ? "Order Cancelled , $cancelledFormattedDate"
                  : "Order Cancelled , 30 Sept",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ).paddingOnly(left: margin_10),
          ],
        ),
        TextView(
          text: strItemCanceled,
          textStyle: textStyleBodyMedium().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor),
        ).paddingOnly(top: margin_2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsQuestionMark),
            InkWell(
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
    ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);
  }

  Widget _canceledPendingView(String? cancelledDate) {
    String? cancelledFormattedDate;
    if (cancelledDate != null) {
      var startDate = int.parse(cancelledDate ?? "8");
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      cancelledFormattedDate = DateFormat('dd/MMM/yyyy').format(confirmedDate);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsCancel).paddingOnly(top: margin_2),
            TextView(
              text: cancelledDate != null
                  ? "Cancellation in progress. $cancelledFormattedDate"
                  : "Order Cancelled , 30 Sept",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ).paddingOnly(left: margin_10),
          ],
        ),
        TextView(
          text: strItemCanceledProgress,
          textStyle: textStyleBodyMedium().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor),
        ).paddingOnly(top: margin_2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AssetSVGWidget(iconsQuestionMark),
            InkWell(
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
    ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);
  }

  Widget _allView(OrderDataModel? data) {
    if (data?.orderStatus == "PLACED") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AssetSVGWidget(iconsOrderConfirmRight),
          TextView(
            text: " $strOrderConfirmed",
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          AssetSVGWidget(iconsQuestionMark),
          InkWell(
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
      ).paddingSymmetric(vertical: margin_12, horizontal: margin_20);
    }
    else if(data?.orderStatus=="DELIVERED")
      {
      return  _deliveredView(data?.deliveryDate ?? "2");
      }
    else if(data?.orderStatus=="CANCELLED")
      {
       return _canceledView(data?.cancelledDate ?? "2");
      }
    else if(data?.orderStatus=="PENDING_CANCELLATION")
    {
      return _canceledPendingView(data?.cancelledDate ?? "2");
    }

    return emptySizeBox();

  }
}
