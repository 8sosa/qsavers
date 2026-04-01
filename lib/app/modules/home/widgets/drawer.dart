


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

import '../../../export.dart';

class DrawerWidget extends StatelessWidget {
  final closeDrawer;
  final onLogoutPressed;

  const DrawerWidget({super.key, 
    this.closeDrawer,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(children: [profileView(), drawerItems()])),
    );
  }

  profileView() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(iconsSplashLogo), fit: BoxFit.cover)),
      padding: EdgeInsets.only(bottom: margin_30, top: margin_20),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(margin_1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius_5)),
            child: NetworkImageWidget(
                imageUrl: Get.find<MainController>().loginDataModel.accessToken ?? "",//
                imageHeight: height_50,
                imageWidth: height_50,
                radiusAll: margin_5),
          ).paddingOnly(right: margin_8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView( text: Get.find<MainController>().loginDataModel.accessToken ?? "",//
                  textStyle:
                  textStyleLabelLarge().copyWith(color: Colors.white)),
              GetInkWell(
                onTap: () async {
                  closeDrawer();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextView(text: "keyViewProfile".tr,
                        textStyle:
                        textStyleBodyMedium().copyWith(color: Colors.white)),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: height_11,
                    ).paddingOnly(left: margin_2)
                  ],
                ).paddingOnly(top: margin_3),
              ),
            ],
          ),
        ],
      ).paddingOnly(top: margin_50, left: margin_20),
      ),
    );
  }

  drawerItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemView(
            icon: iconsSplashLogo,
            text: "keyHome".tr,
            page: () {

            }),
        itemView(
            icon: iconsSplashLogo,
            text: "keyMyBookings".tr,
            page: () {

            }),
        itemView(
            icon: iconsSplashLogo,
            text: "keyMyAddress".tr,
            page: () {

            }),
        itemView(
            icon: iconsSplashLogo,
            text: "keyMyWallet".tr,
            page: () {

            }),
        itemView(
            icon: iconsSplashLogo,
            text: "keyPayments".tr,
            page: () {

            }),
        itemView(
            icon: iconsSplashLogo,
            text: "keySettings".tr,
            page: () {

            }),
        _logoutButton()
      ],
    ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);
  }

  itemView({icon, text, page}) {
    return GetInkWell(
      onTap: () {
        closeDrawer();
        page();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AssetImageWidget(
            icon,
            imageHeight: height_16,
            imageWidth: height_16,
            imageFitType: BoxFit.contain,
          ).paddingOnly(right: margin_15),
          TextView(text:text,
              textStyle: textStyleBodyLarge()
                  .copyWith(color: AppColors.appColor, fontWeight: FontWeight.w500))
        ],
      ).paddingSymmetric(vertical: margin_12),
    );
  }

  _logoutButton() => GetInkWell(
    onTap: () {
      closeDrawer();
      Get.bottomSheet(LogOutDialogWidget(
        title: "keyLogoutTitle".tr,
        description: "keyLogoutDescription".tr,
        onYesPressed: onLogoutPressed,
      ));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: margin_25),
      padding: EdgeInsets.symmetric(horizontal: margin_30),
      decoration: BoxDecoration(
          color: AppColors.appColor, borderRadius: BorderRadius.circular(radius_5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageWidget(
            iconsSplashLogo,
            imageHeight: height_16,
            imageWidth: height_16,
            imageFitType: BoxFit.contain,
          ).paddingOnly(right: margin_5),
          TextView(text:"keyLogout".tr,
              textStyle: textStyleBodyLarge().copyWith(
                  color: Colors.white, fontWeight: FontWeight.w500))
        ],
      ).paddingSymmetric(vertical: margin_10),
    ),
  );
}
