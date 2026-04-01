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

import 'package:quantity_savers/app/modules/staticPages/models/responseModels/static_page_response_model.dart';

import '../../../export.dart';

class StaticPageController extends GetxController {
  int pageType = 0;
  final APIRepository _repository = Get.find<APIRepository>();

  Rx<StaticPagesResponseModel> staticPagesResponseModel =
      StaticPagesResponseModel().obs;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[argStaticPageType] != null) {
        pageType = Get.arguments[argStaticPageType];
      }
    }
  }

  hitGetPagesApiCall() async {
    _repository.loginApiCall().then((value) async {
      if (value != null) {
        staticPagesResponseModel.value = value;
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      showToast(message: error.toString());
    });
  }
}
