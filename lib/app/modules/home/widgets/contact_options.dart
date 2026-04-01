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

class ContactOptionsWidget extends StatelessWidget {
  final onCallTap;
  const ContactOptionsWidget({super.key, this.onCallTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _button(
          color: AppColors.appColor,
            icon: iconsSplashLogo,
          text: "keyCall".tr,
          onTap: onCallTap ?? (){}
        ),
        SizedBox(width: width_20,),
        _button(
          color: AppColors.appColor,
            icon: iconsSplashLogo,
          text: "keyChat".tr,

        ),
        SizedBox(width: width_20,),
        _button(
          color: AppColors.appColor,
            icon: iconsSplashLogo,
          text: 'Cancel',
            cancelButtonColor: AppColors.darkGreyColor,

        )
      ],
    );
  }
  
  _button({color, icon, text, onTap, cancelButtonColor}) {
    return Expanded(
      child: GetInkWell(
        onTap: onTap ?? () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: margin_8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius_10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetImageWidget(icon, imageHeight:text == 'Cancel'? height_17 : height_12, imageWidth: height_15).paddingOnly(bottom:text == 'Cancel'? 0: margin_5),
              TextView( text: text,
                  textStyle: textStyleBodySmall().copyWith(color: cancelButtonColor ?? Colors.white, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }

  _cancelRideDialogBox() => Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_20)
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_30),
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              text: "keyWantToCancelRide".tr,
              maxLines: 2,
              textStyle: textStyleTitleSmall(),
            ).paddingOnly(bottom: margin_15),
            TextView(
              text:  "keyCancelRideMessage".tr,
              maxLines: 10,
              textAlign: TextAlign.center,
              textStyle: textStyleBodySmall(),
            ).paddingOnly(bottom: margin_15),
            _backCancelButtons()
          ],
        ).paddingSymmetric(vertical: margin_5),
      )
    ),
        barrierDismissible: false
  );

  _backCancelButtons() => Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: MaterialButtonWidget(
          onPressed: () => Get.back(),
          buttonText: "keyBack".tr,
        ),
      ),
      SizedBox(
        width: width_10,
      ),
      Expanded(
        child: MaterialButtonWidget(
          onPressed: () {
            Get.back();

          },
          buttonText: "keyCancelRide".tr,
          buttonBgColor: AppColors.redColor,
          horizontalPadding: margin_10,
        ),
      ),
    ],
  );

}
