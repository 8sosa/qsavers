import "../../../export.dart";

class PersonalInformationController extends GetxController {
  LoginDataModel loginDataModel = LoginDataModel();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _repository = Get.find<APIRepository>();
  LoginResponseModel loginResponseModel = LoginResponseModel();
  var dataUpdate = false;
 var type;
  @override
  void onInit() {
    // TODO: implement onInit
    type = _localStorage.getSaveType();
    getArguments();
    dataUpdate = false;
    getUserPassWordType();
    super.onInit();
  }
  var isSetPassWord;

  void getUserPassWordType() async {
    var passWordType = await _localStorage.getSavedLoginData();
    isSetPassWord = passWordType.isPasswardSet;
    debugPrint("isSetPasswaord value is $isSetPassWord");
    update();
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  getArguments() {
    if (Get.arguments != null) {
      loginDataModel = Get.arguments[argProfileData];
      update();
    }
  }

  hitProfileApiCall() {
    Map<String, dynamic> requestModel =
    AuthRequestModel.getProfileRequestModel();
    _repository.getProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        unreadCount.value=loginResponseModel.data?.unreadMessageCount ?? 0;
        await saveDataToLocalStorage(loginResponseModel.data);
        debugPrint("Invoked");
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  saveDataToLocalStorage(LoginDataModel? loginDataModel) async {
    await _localStorage?.saveRegisterData(loginDataModel);
  }

  getDataFromLocalStorage() async {
    debugPrint("Work");
    loginDataModel = await _localStorage.getSavedLoginData();
    update();
  }

}
