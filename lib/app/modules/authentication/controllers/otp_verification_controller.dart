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

import 'package:quantity_savers/app/modules/authentication/models/response_model/logout_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/resend_otp_response_module.dart';

import '../../../export.dart';

class OtpVerificationController extends GetxController {
  TextEditingController otpTextController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  final APIRepository _repository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  LoginResponseModel loginResponseModel = LoginResponseModel();
  LoginDataModel loginDataModel = LoginDataModel();
  OtpResendModel otpResendModel = OtpResendModel();
  ForgotPasswordResponseModel forgotPasswordResponseModel =
      ForgotPasswordResponseModel();
  LogoutResponseModel logOutResponseModel = LogoutResponseModel();

  Timer? timer;
  RxInt start = 59.obs;
  RxString secondsStr = '00:59'.obs;
  bool isFromForgot = false;
  String countryCode = "";
  String contactNumber = "";
  String emailTxt = "";
  String phoneNo = "";
  bool? isFromEmailVerification = false;
  String uniqueCode = "";
  bool? isFromSignup = false;
  String vendor = "Email";
  var logIn = false;
  RxBool isValidate = true.obs;

  @override
  void onInit() {
    getArguments();
    startTimer();
    _getLocalData();
    update();
    super.onInit();
  }

  hitLogoutApi() {
    customLoader.show(Get.context);
    _repository.logOutApiCall().then((value) async {
      customLoader.hide();
      if (value != null) {
        logOutResponseModel = value;
        _localStorage.clearLoginData();
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      showToast(message: error.toString());
    });
  }

  getArguments() {
    if (Get.arguments != null) {
      if(Get.arguments[argLogIn]==true && Get.arguments[argIsForEmail]==true)
      {
        vendor = "Email";
        start = 0.obs;
        emailTxt = Get.arguments[argEmail] ?? "";
        debugPrint("emailTxt is $emailTxt");
        phoneNo = Get.arguments[argPhoneNo] ?? "";
        countryCode = Get.arguments[argCountryCode] ?? "";
      }
      if (Get.arguments[argIsForEmail]) {
        vendor = "Email";
      } else {
        vendor = "Phone";
      }
      isFromForgot = Get.arguments[argFromForgot];
      logIn = Get.arguments[argLogIn] ?? false;
      if (isFromForgot) {
        uniqueCode = Get.arguments[argUniqueCode];
      }
      isFromSignup = Get.arguments[argFromSignUp];
      emailTxt = Get.arguments[argEmail] ?? "";
      debugPrint("emailTxt is $emailTxt");
      phoneNo = Get.arguments[argPhoneNo] ?? "";
      countryCode = Get.arguments[argCountryCode] ?? "";
      update();
    }
  }

  Future<void> _getLocalData() async {
    try {
      debugPrint("Getting data from local storage...");
      loginDataModel = await _localStorage.getSavedLoginData();
      if (loginDataModel != null) {
        debugPrint("Token: ${loginDataModel.accessToken ?? ""}");
      } else {
        debugPrint("No login data available");
      }
    } catch (e) {
      debugPrint("Error retrieving login data: $e");
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
          secondsStr.value = '00:${(start.value).toString().padLeft(2, '0')}';
          update();
        }
      },
    );
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  afterVerifyEmail() {
    emailTxt = "$countryCode $phoneNo";
    vendor = "Phone";
    isFromEmailVerification = true;
    update();
  }

  hitVerifyOtpApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.verifyOtpRequestModel(
        otp: otpTextController.text.trim());
    _repository
        .verifyEmailOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel?.data);
        Get.toNamed(AppRoutes.verifiedScreenRoute,
            arguments: {agrForVerifyEmail: true});
        timer?.cancel();
        start.value = 59;
        startTimer();
        isValidate.value = true;
        otpTextController.clear();
        afterVerifyEmail();
        update();
      }
    }).onError((error, stackTrace) {
      isValidate.value = false;
      showToast(message: error.toString());
    });
  }

  hitPhoneVerifyOtpApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.verifyOtpRequestModel(
        otp: otpTextController.text.trim());
    _repository
        .verifyOtpPhoneApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel?.data);
        Get.offAllNamed(AppRoutes.verifiedScreenRoute,
            arguments: {agrForVerifyEmail: false});
      }
    }).onError((error, stackTrace) {
      isValidate.value = false;
      showToast(message: error.toString());
    });
  }

  hitResendEmailOtpApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.resendOtpOnEmailRequestModel(email: emailTxt);
    _repository
        .resendEmailOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        otpResendModel = value;
        showToast(message: otpResendModel.data);
        timer?.cancel();
        start.value = 59;
        startTimer();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitResendPhoneOtpApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.resendOtpOnPhoneRequestModel(
            phoneNo: phoneNo, code: countryCode);
    _repository
        .resendPhoneOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        otpResendModel = value;
        showToast(message: otpResendModel.data);
        timer?.cancel();
        start.value = 59;
        startTimer();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitForgotPasswordVerifyOtpApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.verifyForgotOtpRequestModel(
            otp: otpTextController.text.trim(),
            uniqueCode: uniqueCode,
            language: strLanguageEnglish);
    print("payload info: ${requestModel}");
    _repository
        .verifyForgotOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        Get.offAllNamed(AppRoutes.verifiedScreenRoute, arguments: {
          agrForVerifyEmail: true,
          argFromForgot: true,
          argUniqueCode: uniqueCode
        });
      }
    }).onError((error, stackTrace) {
      isValidate.value = false;
      showToast(message: error.toString());
    });
  }

  hitResendForgotPasswordOtpApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.resendOtpOnForgotPasswordRequestModel(
            uniqueCode: uniqueCode);
    _repository
        .resendForgotPasswordOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        forgotPasswordResponseModel = value;
        showToast(message: forgotPasswordResponseModel.data?.message);
        timer?.cancel();
        start.value = 59;
        startTimer();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  handleResendApiForCorrespondingRoute() {
    if (vendor == "Email") {
      if (isFromForgot) {
        hitResendForgotPasswordOtpApiCall();
      } else {
      hitResendEmailOtpApiCall();
      }
    } else if (vendor == "Phone") {
      hitResendPhoneOtpApiCall();
    }
  }

  handleApiForCorrespondingRoute() {
    if (vendor == "Email") {
      if (isFromForgot) {
        hitForgotPasswordVerifyOtpApiCall();
      } else {
        hitVerifyOtpApiCall();
      }
    } else if (vendor == "Phone") {
      hitPhoneVerifyOtpApiCall();
    }
  }

  saveDataToLocalStorage(LoginDataModel? loginData) async {
    _localStorage.saveRegisterData(loginData);
    _localStorage.saveAuthToken(loginData?.accessToken);
  }
}
