import "package:quantity_savers/app/modules/profile/controllers/campaign_request_details_controller.dart";

import "../../../export.dart";

class CampaignRequestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CampaignRequestDetailsController>(
        () => CampaignRequestDetailsController());
  }
}
