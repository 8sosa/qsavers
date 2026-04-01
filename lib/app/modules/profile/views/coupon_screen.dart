import 'package:clipboard/clipboard.dart';
import 'package:quantity_savers/app/modules/profile/controllers/coupon_controller.dart';

import '../../../export.dart';

class CouponScreen extends StatelessWidget {
  final controller = Get.put(CouponController());
  final themeController = Get.put(ThemeController());

  CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
        init: CouponController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strCOUPONS,
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
                tabs: const [
                  Tab(text: "AVAILABLE"),
                  Tab(text: "EXPIRED"),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [_buildAvailableCouponList(), _buildExpiredCouponList()],
            ),
          );
        });
  }
  Widget _buildAvailableCouponList() {
    if (controller.availableCouponResponseModel == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.availableCouponResponseModel.totalCount == 0) {
      return _noCouponScreen();
    } else {
      return _buildCouponList(controller.availableCouponResponseModel.totalCount ?? 0);
    }
  }
  Widget _buildCouponList(int itemCount) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return _card(index);
        },
      ).paddingSymmetric(horizontal: margin_20),
    );
  }

  Widget _buildExpiredCouponList() {
    if (controller.expiredCouponResponseModel == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.expiredCouponResponseModel.totalCount == 0) {
      return _expiredCouponScreen();
    } else {
      return _buildCouponExpiredList(controller.expiredCouponResponseModel.totalCount ?? 0);
    }
  }
  Widget _buildCouponExpiredList(int itemCount) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount<=5?itemCount:5,
        itemBuilder: (context, index) {
          return expired(index);
        },
      ).paddingSymmetric(horizontal: margin_20),
    );
  }

  _card(int index) {
    String? startDate =
        controller.availableCouponResponseModel.data?[index].startDate ?? '';
    String? endDate =
        controller.availableCouponResponseModel.data?[index].endDate ?? '';
    debugPrint("StartDate is $startDate");
    debugPrint("EndDate is $endDate");
    int daysDifference = 0;
    if (startDate!.isNotEmpty && endDate!.isNotEmpty) {
      DateTime startDateTime = DateTime.parse(startDate);
      DateTime endDateTime = DateTime.parse(endDate);
      Duration difference = endDateTime.difference(startDateTime);
      daysDifference = difference.inDays;
    }
    debugPrint("Day Difference is $daysDifference");
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius_12)),
          border: Border.all(color: AppColors.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              TextView(
                text: controller.availableCouponResponseModel.data?[index].code,
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_12,
                    color: AppColors.darkGreyColor),
              ),
              GestureDetector(
                child: const AssetImageWidget(iconsCopi),
                onTap: () {
                  FlutterClipboard.copy(controller.availableCouponResponseModel.data?[index].code).then((value) =>print('hello'));
                  showToast(message: "COPIED");
                },
              ),
              Spacer(),
              TextView(
                text: "Valid Till $daysDifference days",
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_12,
                    color: AppColors.darkGreyColor),
              ),
            ],
          ).paddingAll(margin_10),
          TextView(
            text: controller.availableCouponResponseModel.data?[index].price !=
                    0
                ? "Get extra ${controller.availableCouponResponseModel.data?[index].price} off(Price inclusive of discount)"
                : "Get extra ${controller.availableCouponResponseModel.data?[index].percentage} off(Price inclusive of discount)",
            textStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: font_12,
                color: AppColors.darkGreyColor),
          ).paddingOnly(left: margin_10),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.termsAndConditions,
                      arguments: {argTitle: strTermsAndConditions});
                },
                child: TextView(
                  text: "View T&C",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: font_12,
                      color: AppColors.darkGreyColor),
                ).paddingOnly(
                    right: margin_10, top: margin_10, bottom: margin_10),
              ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: margin_10, vertical: margin_10);
  }

  expired(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius_12)),
          border: Border.all(color: AppColors.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextView(
                  text: controller.expiredCouponResponseModel.data?[index].code,
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: font_12,
                      color: AppColors.darkGreyColor),
                ),
              ),
              TextView(
                text: "Expired",
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_12,
                    color: AppColors.darkGreyColor),
              ),
            ],
          ).paddingAll(margin_10),
          TextView(
            text: controller.expiredCouponResponseModel.data?[index].price != 0
                ? "Get extra ${controller.expiredCouponResponseModel.data?[index].price} off(Price inclusive of discount)"
                : "Get extra ${controller.expiredCouponResponseModel.data?[index].percentage} off(Price inclusive of discount)",
            textStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: font_12,
                color: AppColors.darkGreyColor),
          ).paddingOnly(left: margin_10),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.termsAndConditions,
                      arguments: {argTitle: strTermsAndConditions});
                },
                child: TextView(
                  text: "View T&C",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: font_12,
                      color: AppColors.darkGreyColor),
                ).paddingOnly(
                    right: margin_10, top: margin_10, bottom: margin_10),
              ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: margin_10, vertical: margin_10);
  }

  _noCouponScreen() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetSVGWidget(iconsNotPurchased)
            .paddingOnly(bottom: margin_20),
        TextView(
          text: strNoCouponAvailable,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(bottom: margin_16),

      ],
    ),
  );
  _expiredCouponScreen() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetSVGWidget(iconsNotPurchased)
            .paddingOnly(bottom: margin_20),
        TextView(
          text: strNotFoundCoupon,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(bottom: margin_16),

      ],
    ),
  );
}
