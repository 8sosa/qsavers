import "../../../export.dart";
import "../../authentication/models/response_model/logout_response_model.dart";

class DeleteAccountController extends GetxController {
  bool viewPassword = true;
  bool enableRemember = false;
  final PageController pageViewController = PageController();
  TextEditingController otherReasonTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  List<Map<String, dynamic>> deleteReasons = DeleteScreenModel().deleteReasons;
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _repository = Get.find<APIRepository>();
  int currentPageView = 1;
  int selectedDeleteReasonValue = 0;
  LogoutResponseModel logoutResponseModel = LogoutResponseModel();
  FocusNode? otherReasonFocusNode = FocusNode();
  LoginDataModel loginDataModel =LoginDataModel();
  var type;
  @override
  void onInit()
  {
    super.onInit();
   type = _localStorage.getSaveType();
   debugPrint("LoginType is $type");

  }

  hitDeleteAccountApi() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.deleteAccountRequestModel(
      deactivateReason:
          deleteReasons[selectedDeleteReasonValue]["reason"] == strOther
              ? otherReasonTextController.text
              : deleteReasons[selectedDeleteReasonValue]["reason"],
      password:type==null? passwordTextController.text.trim():"",
    );
    _repository
        .deleteAccountApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        logoutResponseModel = value;
        // showToast(message: logoutResponseModel.data?.message);
        _localStorage.clearLoginData();
        _localStorage.clearRememberMeData();
        dismissKeyboard();
        navigateToNextPage();
      }
      update();
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void navigateToNextPage() {
    pageViewController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    currentPageView = currentPageView + 1;
    update();
  }
}
