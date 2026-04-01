


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

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarTitleText: "keySettings".tr,
        ),
        body: _othersItemsList());
  }

  Widget _othersItemsList() => Obx(
        () => ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, int index) => GetInkWell(
            onTap: () {
              switch (index) {
                case 1:
                  Get.toNamed(AppRoutes.changePasswordRoute);
                  break;
                case 2:
                  Get.toNamed(
                    AppRoutes.faqRoute,
                  );
                  break;
                case 3:
                  Get.toNamed(AppRoutes.staticPageRoute,
                      arguments: {argStaticPageType: pageTypePrivacyPolicy});
                  break;
                case 4:
                  Get.toNamed(AppRoutes.staticPageRoute,
                      arguments: {argStaticPageType: pageTypeTerms});
                  break;
                case 5:
                  Get.toNamed(AppRoutes.contactUsRoute);
                  break;
                default:
                  break;
              }
            },
            child: Row(
              children: [
                Expanded(
                    child: TextView(
                text:   controller.othersListTitle[index],
                  textAlign: TextAlign.start,
                  textStyle: textStyleBodyLarge().copyWith(
                      fontWeight: FontWeight.w400, color: Colors.black87),
                )),
                index == 0
                    ? _switchButton(index)
                    : Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: height_12,
                        color: AppColors.appColor,
                      )
              ],
            ).paddingSymmetric(vertical: margin_15),
          ),
          separatorBuilder: (context, int index) => Divider(
            color: Colors.grey,
            thickness: margin_0point6,
          ),
          itemCount: controller.othersListTitle.length,
        ).paddingSymmetric(vertical: margin_15, horizontal: margin_20),
      );

  _switchButton(int index) => SizedBox(
        height: height_15,
        width: width_36,
        child: Transform.scale(
          scaleX: 0.65,
          scaleY: 0.6,
          child: Obx(
            () => CupertinoSwitch(
                value: controller.isNotifications.value,
                thumbColor: Colors.white,
                activeColor: AppColors.appColor,
                trackColor:
                    controller.isNotifications.value ? AppColors.appColor : AppColors.darkGreyColor,
                onChanged: (value) {
                  controller.isNotifications.value = value;
                }),
          ),
        ),
      );
}
