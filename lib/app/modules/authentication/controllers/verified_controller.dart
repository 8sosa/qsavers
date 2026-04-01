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

class VerifiedController extends GetxController {
  var forVerifyEmail = true;
  var isFromForgot = false;
  String uniqueCode = "";
  Timer? timer;

  @override
  void onInit() {
    getArguments();
    _navigateToNextScreen();
    super.onInit();
  }

  void _navigateToNextScreen() =>
      timer = Timer(const Duration(seconds: 3), () async {
        if (forVerifyEmail) {
          if (isFromForgot) {
            Get.toNamed(AppRoutes.setPasswordRoute,
                arguments: {argUniqueCode: uniqueCode});
          } else {
            Get.back();
          }
        } else {
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        }
      });

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      forVerifyEmail = Get.arguments[agrForVerifyEmail] ?? true;
      isFromForgot = Get.arguments[argFromForgot] ?? false;
      uniqueCode = Get.arguments[argUniqueCode] ?? "";
      update();
    }
  }
}
