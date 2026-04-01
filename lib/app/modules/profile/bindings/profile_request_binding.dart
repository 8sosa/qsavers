import "package:quantity_savers/app/modules/profile/controllers/profile_request_controller.dart";

import "../../../export.dart";

class ProfileRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRequestController>(() => ProfileRequestController());
  }
}
