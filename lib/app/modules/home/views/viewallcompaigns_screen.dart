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

import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';

import '../../../export.dart';
import '../widgets/counter_widget.dart';

class ViewAllCompaignsScreen extends StatelessWidget {
  final controller = Get.put(ViewAllCampaignsController());
  final themeController = Get.put(ThemeController());

  ViewAllCompaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllCampaignsController>(
        init: ViewAllCampaignsController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              onTap: () {
                Get.offAllNamed(AppRoutes.mainScreenRoute,
                    arguments: {BottomNavigationBar: 0});
              },
              appBarTitleText: controller.title.toUpperCase(),
              isLeadingPresent: (controller.isFromTabbar),
              isDrawerIcon: !controller.isFromTabbar,
              hideBackIcon: controller.handleBackButton(),
            ),
            body: RefreshIndicator(
              color: AppColors.gradient2nd,
              onRefresh: () async {
                await controller.refreshList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sortAndFilter(),
                  const Divider(thickness: 1, color: AppColors.borderColor),
                  campaignsList()
                ],
              ),
            ),
          );
        });
  }

  Widget sortAndFilter() => SizedBox(
        height: 50,
        child: Row(
          children: [
            Stack(children: [
              MaterialButtonWidget(
                minWidth: Get.width / 2.1,
                onPressed: () {
                  Get.bottomSheet(bottomSheet());
                },
                buttonBgColor: Colors.transparent,
                buttonText: "SORT BY".toUpperCase(),
                buttonTextStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                iconInRight: true,
                iconWidget: const AssetSVGWidget(iconsDropDownArrow)
                    .paddingOnly(left: margin_3),
              ),
              if (controller.sorted == false) ...[
                const Positioned(
                    right: 0,
                    left: 60,
                    top: 10,
                    child: Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 10,
                    ))
              ]
            ]),
            const VerticalDivider(
                color: AppColors.borderColor,
                thickness: 1,
                indent: 12,
                endIndent: 12),
            Stack(
              children: [
                MaterialButtonWidget(
                  minWidth: Get.width / 2.1,
                  onPressed: () async {
                    FilterCampaignData returnData = await Get.toNamed(
                        AppRoutes.campaignFilterRoute,
                        arguments: {
                          argTitle: strFilters,
                          argForVendors: false,
                          argForCampaign: true,
                          argFilterMaxPrice: 1000
                        });

                    controller.filterParameters = returnData;

                    if (controller.filterParameters?.isFilterApply == true) {
                      controller.filter = true;
                      controller.hitGetCampaignFilteredApi();
                    } else if (controller.filterParameters?.isFilterApply ==
                        false) {
                      controller.filter = false;
                      controller.filterValuesUpdate();
                      controller.getAllCampaignsData();
                    }
                    controller.update();










                    if (returnData.isFilterApply == true) {
                      debugPrint("Data is${filterSelectctedData?.categoryId}");
                      controller.filter = true;
                      controller.hitGetCampaignFilteredApi();
                    } else if (controller.filterParameters?.isFilterApply ==
                        false) {
                      controller.filter = false;
                      controller.filterValuesUpdate();
                      controller.getAllCampaignsData();
                    }
                    controller.update();
                  },
                  buttonBgColor: Colors.transparent,
                  buttonText: "FILTERS".toUpperCase(),
                  buttonTextStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                if (controller.filter == true) ...[
                  const Positioned(
                      right: 0,
                      left: 60,
                      top: 10,
                      child: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 10,
                      ))
                ]
              ],
            )
          ],
        ),
      );

  Widget campaignsList() => Expanded(
        child: GetBuilder<ViewAllCampaignsController>(
          builder: (controller) {
            final isFiltered = controller.loadfilterdData == true;
            final totalCount = isFiltered
                ? controller.campaignFilterResponseModel.data?.data?.length ?? 0
                : controller.campaignDataResponseModel.data?.data?.length ?? 0;

            if (totalCount == 0) {
              return _noCouponScreen();
            }

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1 / 0.95,
              ),
              itemCount: totalCount,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (controller.localStorage.getAuthToken() == null) {
                      Get.dialog(CustomDialogWidget(
                          cancelTitleColor: AppColors.gradientColorSecondary,
                          cancelBtnBorder: Border.all(
                              color: AppColors.gradientColorSecondary),
                          confirmBtnBgColor: AppColors.gradientColorSecondary,
                          title: strNotAuthorized,
                          confirmTitle: strLogin,
                          cancelTitle: strSignup,
                          isCustomizedTapCancel: true,
                          onTapCancel: () {
                            Get.offAllNamed(AppRoutes.signupRoute);
                          },
                          onTapConfirm: () {
                            Get.offAllNamed(AppRoutes.loginRoute);
                          }));
                    } else {
                      Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
                          arguments: {
                            argCampaignId: controller.campaignDataResponseModel
                                .data?.data?[index].sId,
                            argForOngoing: false,
                            argForViewAllCampaign: true
                          });
                    }
                  },
                  child: _campaignsItem(index),
                );
              },
            ).paddingOnly(left: 20,right: 20,bottom: 20);
          },
        ),
      );

  Widget _campaignsItem(int index) {
    var campaign = controller.campaignDataResponseModel.data?.data?[index];
    var campaignName = campaign?.campaignName;
    var price = campaign?.oneProductPrice;
    var totalQuantity = campaign?.totalQuantity;
    var soldQuantity = campaign?.soldQuantity;
    var userJoined = campaign?.userJoined;
    var remainingQuantity = totalQuantity - soldQuantity;

    var startDuration = campaign?.startDate;
    var endDuration = campaign?.endDate;
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startDuration!);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endDuration!);
    String startFormattedDate = DateFormat('dd/MMM/yyyy').format(startDate);
    String endFormattedDate = DateFormat('dd/MMM/yyyy').format(endDate);
    var totalrating = campaign?.productId?.totalRatings;
    var creater =
        controller.campaignDataResponseModel.data?.data?[index].createdBy;
    var loggedId = controller.userLoggedInId;
    debugPrint("Creator id is $creater");
    debugPrint("Logged id is $loggedId");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: height_140,
          child: Stack(
            children: [
              Positioned.fill(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: NetworkImageWidget(
                  imageUrl: controller
                          .campaignDataResponseModel.data?.data?[index].image ??
                      "",
                  imageHeight: height_60,
                  imageWidth: height_70,
                  imageFitType: BoxFit.fitWidth,
                ),
              )),
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  children: [
                    if (controller.campaignDataResponseModel.data?.data?[index]
                                .isLive ==
                            true &&
                        controller.campaignDataResponseModel.data?.data?[index]
                                .createdBy !=
                            controller.userLoggedInId) ...[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            const AssetSVGWidget(iconsLive),
                            GestureDetector(
                              onTap: () {
                                controller.hitStartLiveSocket(
                                    controller.campaignDataResponseModel.data
                                        ?.data?[index].sId,
                                    "SUBSCRIBER");
                              },
                              child: TextView(
                                text: "Join Now",
                                textStyle: textStyleTitleLarge().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                            )
                          ],
                        ).paddingAll(margin_4),
                      ),
                    ],
                    if (controller.campaignDataResponseModel.data?.data?[index]
                            .createdBy ==
                        controller.userLoggedInId) ...[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            const AssetSVGWidget(iconsLive),
                            GestureDetector(
                              onTap: () {
                                showStartLiveBroadcastDialog(
                                    Get.context!, index, "PUBLISHER", endDate);
                                // controller.hitStartLiveSocket(controller
                                //     .campaignDataResponseModel
                                //     .data
                                //     ?.data?[index]
                                //     .sId,"PUBLISHER");
                              },
                              child: TextView(
                                text: "Start Live BroadCast",
                                textStyle: textStyleTitleLarge().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                            )
                          ],
                        ).paddingAll(margin_4),
                      ),
                    ],
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          bool isAuthorized = controller.handleWishlist(
                              campaign?.sId, campaign?.wishlist);
                          if (isAuthorized) {
                            campaign?.wishlist = !(campaign.wishlist ?? false);
                            controller.update();
                          }
                        },
                        child: AssetSVGWidget((campaign?.wishlist == true)
                            ? iconsHeartlikered
                            : iconsHeartDisLike)),
                  ],
                ),
              ),
              Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: CountDownWidget(
                            time: DateTime.fromMillisecondsSinceEpoch(controller
                                    .campaignDataResponseModel
                                    .data
                                    ?.data?[index]
                                    .endDate ??
                                0))
                        .paddingSymmetric(
                            vertical: margin_2, horizontal: margin_8),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextView(
                text: campaignName,
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: font_16),
              ),
              const Spacer(),
              TextView(
                text: "\$$price",
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.gradient2nd,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              )
            ],
          ).paddingOnly(top: margin_13),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(4)),
              child: TextView(
                text: "$remainingQuantity/$totalQuantity",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.catBackgroundColor,
                  borderRadius: BorderRadius.circular(4)),
              child: TextView(
                text: controller.campaignDataResponseModel.data?.data?[index]
                    .productId?.name,
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.gradient2nd,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
            ).paddingOnly(left: margin_15),
            const Spacer(),
            if (totalrating != 0) ...[
              const AssetSVGWidget(
                iconsRatingStar,
                imageFitType: BoxFit.fill,
                imageHeight: 16,
                color: AppColors.gradient2nd,
              ),
              TextView(
                text: "$totalrating",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ).paddingOnly(left: margin_2)
            ]
          ],
        ).paddingOnly(top: margin_13),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetSVGWidget(
                iconsClockGreen,
                imageFitType: BoxFit.fill,
                imageHeight: 16,
                imageWidth: 16,
              ),
              TextView(
                text: "Campaign duration:",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ).paddingOnly(left: margin_13, top: margin_1),
              TextView(
                text: "$startFormattedDate-$endFormattedDate",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ).paddingOnly(top: margin_1, left: margin_2)
            ],
          ),
        ).paddingOnly(top: margin_13),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetSVGWidget(
                iconsUserGreen,
                imageFitType: BoxFit.fill,
                imageHeight: 16,
                imageWidth: 16,
              ),
              TextView(
                text: "User joined:",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ).paddingOnly(left: margin_13, top: margin_1),
              TextView(
                text: "$userJoined",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ).paddingOnly(top: margin_1, left: margin_2)
            ],
          ),
        ).paddingOnly(top: margin_13)
      ],
    ).paddingOnly(top: margin_12);
  }

  Widget bottomSheet() => GetBuilder<ViewAllCampaignsController>(
        init: ViewAllCampaignsController(),
        builder: (context) {
          return Container(
            width: Get.width,
            height: Get.height / 2.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 4,
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ).paddingOnly(top: margin_13),
                TextView(
                  text: "Sort By",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
                SizedBox(
                  height: margin_2,
                  width: Get.width,
                  child: const Divider(
                    thickness: 1.5,
                    color: AppColors.dividerColor,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.sortByElement.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        if (controller.sortByElement[index] == "All") {
                          controller.sorted = true;
                          debugPrint("value is${controller.sorted}");
                        } else {
                          controller.sorted = false;
                          debugPrint("value is${controller.sorted}");
                        }
                        controller.onSelectSortByItem(index);
                        Get.back();
                        print(
                            controller.bottomSheetSelectedIndex.value.toInt());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextView(
                                text: controller.sortByElement[index],
                                textStyle: (index ==
                                        controller
                                            .bottomSheetSelectedIndex.value
                                            .toInt())
                                    ? textStyleTitleLarge().copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)
                                    : textStyleTitleLarge().copyWith(
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                              ),
                              const Spacer(),
                              (index ==
                                      controller.bottomSheetSelectedIndex.value
                                          .toInt())
                                  ? const AssetSVGWidget(iconsRightChecked)
                                  : const SizedBox(),
                            ],
                          ).paddingSymmetric(vertical: margin_15),
                          if ((controller.sortByElement.length - 1) != index)
                            SizedBox(
                              height: margin_3,
                              width: double.infinity,
                              child: const Divider(
                                thickness: 1.5,
                                color: AppColors.dividerColor,
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                    );
                  },
                ).paddingOnly(left: margin_15, right: margin_15),
              ],
            ),
          );
        },
      );
  _noCouponScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsNotPurchased)
                .paddingOnly(bottom: margin_20),
            TextView(
              text: "No Campaign Found",
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ).paddingOnly(bottom: margin_16),
          ],
        ),
      );

  void showStartLiveBroadcastDialog(
      BuildContext context, int index, String type, DateTime providedDate) {
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
                    controller.campaignDataResponseModel.data?.data?[index].sId,
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
                  controller.getAllCampaignsData();
                  controller.campaignDataResponseModel.data?.data?[index]
                              .isSchedule ==
                          true
                      ? showToast(
                          message: "You already schedule live streaming")
                      : showScheduleLiveBroadcastDialog(
                          Get.context!, index, providedDate);
                }),
          ],
        ),
      ),
    );
  }

  void showScheduleLiveBroadcastDialog(
      BuildContext context, int index, DateTime providedDate) {
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
                const Text('Select Date').paddingOnly(top: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
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
                      lastDate: providedDate.subtract(const Duration(days: 0)),
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
                        const Icon(Icons.calendar_today,size: 25,
                            color: AppColors.gradient2nd),
                      ],
                    ),
                  ),
                ).paddingOnly(top: 10),
                const SizedBox(height: 10.0),
                const Text('Select Time'),
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
                        const Icon(Icons.access_time,size: 25,
                            color: AppColors.gradient2nd),
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
                        controller
                            .campaignDataResponseModel.data?.data?[index].sId,
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
              ).paddingOnly(top: 16)
            ],
          );
        },
      ),
    );
  }
}
