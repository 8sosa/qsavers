import "package:quantity_savers/app/modules/profile/models/response_model/campaign_request_list_response_model.dart";

import "../../../export.dart";

class ProfileRequestController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  CampaignRequestListResponseModel campaignRequestListResponseModel =
      CampaignRequestListResponseModel();

  @override
  void onInit() {
    hitGetCampaignRequestDataApi();
    super.onInit();
  }

  hitGetCampaignRequestDataApi() async {
    _apiRepository.getCampaignRequestListApiCall().then((value) async {
      if (value != null) {
        campaignRequestListResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
