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

class VerifiedScreen extends StatelessWidget {
  final controller = Get.put(VerifiedController());
  final themeController = Get.put(ThemeController());

  VerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<VerifiedController>(
            init: VerifiedController(),
            builder: (context) {
              return Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AssetImageWidget(iconsSuccessfullyDone),
                      SizedBox(height: margin_10),
                      Text(
                        'Verified!',
                        style: textStyleHeadlineLarge().copyWith(
                            fontSize: font_22,
                            color: themeController.isDarkMode.value == true
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w700),
                      ).paddingOnly(bottom: margin_8),
                      Text(
                        controller.forVerifyEmail
                            ? strVerifiedEmail
                            : strVerifiedPhone,
                        style: textStyleBodyLarge().copyWith(
                            color: Colors.grey.shade600,
                            fontSize: font_14,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                      .paddingSymmetric(horizontal: margin_25)
                      .paddingOnly(bottom: margin_30));
            }),
      ),
    );
  }
}
