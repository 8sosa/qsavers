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

import 'package:quantity_savers/app/modules/authentication/models/response_model/set_password_response_model.dart';

import '../../../export.dart';

class SetPasswordController extends GetxController {
  TextEditingController passwordTextController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

  String uniqueCode = "";
  bool? isFromSignup = false;
  RxBool viewPassword = true.obs;
  RxBool viewConfirmPassword = true.obs;

  final APIRepository _repository = Get.find<APIRepository>();
  SetPasswordResponseModel setPasswordResponseModel =
      SetPasswordResponseModel();

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      uniqueCode = Get.arguments[argUniqueCode];
    }
  }

  hitNewPasswordApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.newPasswordRequestModel(
      uniqueCode: uniqueCode,
      password: passwordTextController.text.trim(),
    );
    _repository.newPasswordApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        setPasswordResponseModel = value;
        showToast(message: setPasswordResponseModel.data);
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
