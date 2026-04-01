import "package:quantity_savers/app/modules/forums/controllers/progress_controller.dart";

import "../../../export.dart";

class ProgressDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressController>(() => ProgressController());
  }
}
