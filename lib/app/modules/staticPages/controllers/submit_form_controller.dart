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

class SubmitFormController extends GetxController {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  final APIRepository _repository = Get.find<APIRepository>();
  final LocalStorage _LocalStorage = Get.find<LocalStorage>();

  MessageResponseModel messageResponseModel = MessageResponseModel();

  Rx<LoginDataModel> loginDataModel = LoginDataModel().obs;

  @override
  void onInit() {
  //  getProfileData();
    super.onInit();
  }


  @override
  void onClose() {
    clearEditText();
    super.onClose();
  }

  // getProfileData() async {
  //   _LocalStorage.getSavedLoginData().then((value) {
  //     if (value != null) {
  //       loginDataModel.value = value;
  //       nameTextController.text = loginDataModel.value.fullName;
  //       emailTextController.text = loginDataModel.value.email;
  //     }
  //   });
  // }

  clearEditText() {
    nameTextController.clear();
    emailTextController.clear();
    messageTextController.clear();
  }

  // hitContactUsApiCall() {
  //   Map<String, dynamic> requestModel = AuthRequestModel.contactUsRequestModel(
  //     name: nameTextController.text.trim(),
  //     email: emailTextController.text.trim(),
  //     contact: staticContactNumber,
  //     description: messageTextController.text.trim(),
  //   );
  //   _repository.loginApiCall(dataBody: requestModel).then((value) async {
  //     if (value != null) {
  //       messageResponseModel = value;
  //       Get.snackbar("ApplicationName".tr, messageResponseModel.message ?? "",
  //           colorText: Colors.black,
  //           duration: const Duration(seconds: 1),
  //           snackPosition: SnackPosition.TOP,
  //           snackStyle: SnackStyle.FLOATING,
  //           padding: EdgeInsets.symmetric(
  //               horizontal: margin_20, vertical: margin_15),
  //           margin: EdgeInsets.symmetric(
  //               horizontal: margin_15, vertical: margin_15),
  //           barBlur: 20.0,
  //           backgroundColor: AppColors.appColor.withOpacity(0.5));
  //     }
  //   }).onError((error, stackTrace) {
  //     showToast(message: error.toString());
  //   });
  // }
}