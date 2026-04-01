


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


import 'package:quantity_savers/app/data/models/common_message_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/login_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/set_password_response_model.dart';

import '../../../export.dart';

class ChangePasswordController extends GetxController {

  RxBool viewPassword = true.obs;
  RxBool confirmPassword = true.obs;
  RxBool oldViewPassword = true.obs;
  bool isFromForgot = false;

  TextEditingController oldPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  CommonMessageResponseModel commonMessageResponseModel = CommonMessageResponseModel();
  SetPasswordResponseModel setPasswordResponseModel = SetPasswordResponseModel();

  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode confirmFocus = FocusNode();

  final APIRepository _repository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  Rx<MessageResponseModel> messageResponseModel = MessageResponseModel().obs;
  LoginResponseModel loginResponseModel = LoginResponseModel();
  RxBool isSetPassWord = false.obs;

  @override
  void onInit() {
    if(Get.arguments != null){
      isFromForgot = Get.arguments[argIsFromForgot];
    }
    getUserPassWordType();
    super.onInit();
  }

  void getUserPassWordType() async {
    var passWordType = await _localStorage.getSavedLoginData();
    isSetPassWord.value = passWordType.isPasswardSet;
    debugPrint("isSetPasswaord value is $isSetPassWord");
    update();
  }


  hitChangePasswordApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.changePasswordRequestModel(
        newPassword: newPasswordTextController.text.trim(),
        oldPassword: oldPasswordTextController.text.trim(),
    );
    _repository.changePasswordApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        commonMessageResponseModel = value;
        Get.back();
        showToast(message: commonMessageResponseModel.data?.message ?? "");
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitSetPasswordApiCall(){
    Map<String, dynamic> requestModel = AuthRequestModel.setPasswordRequestModel(
      password: newPasswordTextController.text.trim()
    );
    _repository.setPasswordApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        setPasswordResponseModel = value;
          hitProfileApiCall();
        Get.back(result: {
          argUpdate:true
        });
        showToast(message: "Password set successfully" ?? "");
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }


  hitProfileApiCall() {
    Map<String, dynamic> requestModel =
    AuthRequestModel.getProfileRequestModel();
    _repository.getProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        unreadCount.value=loginResponseModel.data?.unreadMessageCount ?? 0;
        await saveDataToLocalStorage(loginResponseModel.data);
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  saveDataToLocalStorage(LoginDataModel? loginDataModel) async {
    await _localStorage?.saveRegisterData(loginDataModel);
  }


}