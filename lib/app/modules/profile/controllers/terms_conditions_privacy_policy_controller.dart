import 'package:quantity_savers/app/export.dart';

import '../models/data_models/list_content_data_model.dart';
import '../models/response_model/list_content_response_model.dart';

class TermsCondAndPvtPolicyController extends GetxController {
  final APIRepository _repository = Get.find<APIRepository>();
  ListContentResponseModel? listContentResponseModel =
      ListContentResponseModel();
  ListContentDataModel? listContentDataModel = ListContentDataModel();
  bool isLoading = false;
  var title = '';
  var screenInfo = '';

  @override
  void onInit() {
    getArguments();
    checkWhichScreen();
    getListContent();
    update();
    super.onInit();
  }

  void getArguments() {
    if (Get.arguments != null) {
      title = Get.arguments[argTitle];
    }
  }

  void checkWhichScreen() {
    if (title == 'About Us') {
      screenInfo = 'ABOUT_US';
    } else if (title == 'Privacy Policy') {
      screenInfo = 'PRIVACY_POLICY';
    } else {
      screenInfo = 'TERMS_AND_CONDITIONS';
    }
  }

  getListContent() {
    isLoading = true;
    Map<String, dynamic> requestData =
        ProfileRequestModel.termsConditionsPrivacyRequestModel(
            type: screenInfo);

    _repository.getListContent(queryBody: requestData).then((value) {
      if (value != null) {
        listContentResponseModel = value;
        listContentDataModel = listContentResponseModel?.data?[0];
        isLoading = false;
        update();
      }
    });
  }
}

enum PageType {
  ABOUT_US,
  PRIVACY_POLICY,
  TERMS_AND_CONDITIONS,
}
