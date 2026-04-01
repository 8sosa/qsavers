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

import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';

import '../../../export.dart';

class AboutCampaignController extends GetxController {
  ProductDetailsResponseModel? productDetails;
  LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      productDetails = Get.arguments[argProductDetails];
    }
    update();
  }

  startCampaign()
  {
    if (_localStorage.getAuthToken() == null) {
      Get.dialog(CustomDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
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
    }
    else
      {
        Get.toNamed(AppRoutes.startCampaignScreenRoute);
      }
  }

}
