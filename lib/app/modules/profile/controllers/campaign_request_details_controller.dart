import "package:quantity_savers/app/modules/profile/controllers/profile_request_controller.dart";
import "package:quantity_savers/app/modules/profile/models/response_model/campaign_request_details_response_model.dart";

import "../../../export.dart";

class CampaignRequestDetailsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  bool isLoading = false;
  String campaignRequestId = "";
  var title = "";
  CampaignRequestDetailsResponseModel campaignRequestDetailsResponseModel =
      CampaignRequestDetailsResponseModel();
  ProfileRequestController? profileRequestController;

  @override
  void onInit() {
    if (Get.isRegistered<ProfileRequestController>()) {
      profileRequestController = Get.find<ProfileRequestController>();
    }
    getArguments();
    hitGetCampaignRequestDetailsApi();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      campaignRequestId = Get.arguments[argCampaignRequestId] ?? "";
      title=Get.arguments[argTitle] ?? "";
    }
    update();
  }

  hitGetCampaignRequestDetailsApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        ProfileRequestModel.campaignDetailsRequestModel(id: campaignRequestId);
    _apiRepository
        .getCampaignRequestDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        campaignRequestDetailsResponseModel = value;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteCampaignRequestApi() {
    _apiRepository
        .deletePrivateCampaignRequestApiCall(
            id: campaignRequestDetailsResponseModel.data?.sId)
        .then((value) {
      if (value != null) {

        profileRequestController?.hitGetCampaignRequestDataApi();
        Get.back();
        showToast(message: "Deleted successfully");
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
