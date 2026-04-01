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

class ForgotPasswordController extends GetxController {
  final APIRepository _repository = Get.find<APIRepository>();
  ForgotPasswordResponseModel forgotPasswordResponseModel =
      ForgotPasswordResponseModel();
  TextEditingController emailTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  hitForgotPasswordApiCall() {
    var forgotReq = AuthRequestModel.forgotPasswordRequestModel(
        email: emailTextController.text.trim(), language: strLanguageEnglish);
    _repository.forgotPasswordApiCall(dataBody: forgotReq).then((value) {
      if (value != null) {
        forgotPasswordResponseModel = value;
        Get.toNamed(AppRoutes.otpVerificationRoute, arguments: {
          argFromSignUp: false,
          argEmail: emailTextController.text ?? "",
          argUniqueCode: forgotPasswordResponseModel.data?.uniqueCode ?? "",
          argFromForgot: true,
          argIsForEmail: true
        });
        showToast(
          message: forgotPasswordResponseModel.data?.message,
        );
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
