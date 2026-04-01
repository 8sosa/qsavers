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

import 'package:quantity_savers/app/modules/profile/models/response_model/profile_faq_response_model.dart';

import '../../../export.dart';

class AllFAQsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ProfileFaqResponseModel profileFaqResponseModel = ProfileFaqResponseModel();
  bool isLoading = false;

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    hitGetFaqDataApi();
    super.onInit();
  }

  hitGetFaqDataApi() {
    isLoading = true;
    _apiRepository.getProfileFaqData().then((value) async {
      if (value != null) {
        profileFaqResponseModel = value;
      }
      isLoading = false;
      update();
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
