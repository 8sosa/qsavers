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

import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:quantity_savers/app/modules/authentication/models/response_model/logout_response_model.dart";
import "package:sign_in_with_apple/sign_in_with_apple.dart";

import "../../../export.dart";

class ProfileController extends GetxController {
  Timer? timer;
  bool dataUpdate = false;
  bool showLoader = false;
  LoginDataModel loginDataModel = LoginDataModel();
  ProfileModel profileModel = ProfileModel();
  final APIRepository _repository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  LogoutResponseModel logOutResponseModel = LogoutResponseModel();
  var type;

  @override
  void onInit() {
    super.onInit();
    type = _localStorage.getSaveType();
  }

  @override
  void onReady() {
    if (_localStorage.getAuthToken() != null) {
      getLocalProfileData();
    }
    super.onReady();
  }

  void getLocalProfileData() =>
      timer = Timer(const Duration(seconds: 1, milliseconds: 500), () async {
        loginDataModel = await _localStorage.getSavedLoginData();
        update();
      });

  hitLogoutApi() {
    customLoader.show(Get.context);
    _repository.logOutApiCall().then((value) async {
      customLoader.hide();
      if (value != null) {
        logOutResponseModel = value;
        showToast(message: logOutResponseModel.data?.message);
        await GoogleSignIn().signOut();

        _localStorage.clearLoginData();
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      showToast(message: error.toString());
    });
  }
}
