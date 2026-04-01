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

import 'package:quantity_savers/app/modules/authentication/models/dataModel/login_data_model.dart';

import '../../../export.dart';

class ContactUsController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();

  var selectedCountry = const Country(
    name: "United Kingdom",
    flag: "🇬🇧",
    code: "GB",
    dialCode: "44",
    minLength: 8,
    maxLength: 15,
    nameTranslations: {},
  );

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();

  final APIRepository _apiRepository = Get.find<APIRepository>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  LoginDataModel loginDataModel = LoginDataModel();
  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    fetchLoginData();
  }

  Future<void> fetchLoginData() async {
    loginDataModel = await localStorage.getSavedLoginData();
    if (loginDataModel.name != null) {
      nameTextController.text=loginDataModel.name;
      debugPrint("Name is ${loginDataModel.name}");
    }
    if(loginDataModel.email!=null)
      {
        emailTextController.text=loginDataModel.email;
      }
    if(loginDataModel.phoneNo!=null)
    {
      mobileNumberTextController.text=loginDataModel.phoneNo.toString();
    }
  }

  hitContactUsApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.contactUsRequestModel(
      name: nameTextController.text.trim(),
      email: emailTextController.text.trim(),
      countryCode: selectedCountry.dialCode,
      phoneNumber: int.parse(mobileNumberTextController.text.trim()),
      message: messageTextController.text.trim(),
    );
    _apiRepository.contactUsApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        showToast(message: "Request has been successfully submitted");
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 3});
      }
      update();
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
