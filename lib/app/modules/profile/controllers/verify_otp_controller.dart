import 'package:quantity_savers/app/modules/authentication/models/response_model/resend_otp_response_module.dart';

import '../../../export.dart';

class VerifyOtpController extends GetxController {
  Timer? timer;
  RxInt start = 59.obs;
  RxString secondsStr = '00:30'.obs;
  bool isForEmail = true;
  RxBool isValidate = true.obs;
  var phoneNo = "";
  var countryCode = "";
  var emailTxt = "";

  final APIRepository _repository = APIRepository();
  final LocalStorage _localStorage = Get.find<LocalStorage>();

  LoginDataModel loginDataModel = LoginDataModel();
  LoginResponseModel loginResponseModel = LoginResponseModel();

  TextEditingController otpTextController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  OtpResendModel otpResendModel = OtpResendModel();

  @override
  void onInit() {
    // TODO: implement onInit
    getArguments();
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  getArguments() {
    if (Get.arguments != null) {
      loginDataModel = Get.arguments[argProfileData];
      if (Get.arguments[argIsForEmail] ?? true) {
        isForEmail = true;
      } else {
        isForEmail = false;
      }
      update();
      _hitApi();
    }
  }

  _hitApi() {
    Timer(Duration(seconds: 1), () {
      isForEmail ? hitResendEmailOtpApiCall() :  hitResendPhoneOtpApiCall();
    });
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

  hitVerifyOtpApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.verifyOtpRequestModel(
        otp: otpTextController.text.trim());
    _repository
        .verifyEmailOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        await saveDataToLocalStorage(loginResponseModel.data);
        Get.back(result: true);
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
        await saveDataToLocalStorage(loginResponseModel.data);
        Get.back(result: true);
      }
    }).onError((error, stackTrace) {
      isValidate.value = false;
      showToast(message: error.toString());
    });
  }

  hitResendEmailOtpApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.resendOtpOnEmailRequestModel(
            email: (loginDataModel.email ?? ""));
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

  hitResendPhoneOtpApiCall() async {
    Map<String, dynamic> requestModel =
        await AuthRequestModel.resendOtpOnPhoneRequestModel(
            phoneNo: "${loginDataModel.phoneNo ?? 0}",
            code: (loginDataModel.countryCode ?? ""));
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

  saveDataToLocalStorage(LoginDataModel? loginData) async {
    _localStorage.saveRegisterData(loginData);
    _localStorage.saveAuthToken(loginData?.accessToken);
  }
}
