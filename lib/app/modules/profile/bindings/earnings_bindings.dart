import "../../../export.dart";
import "../controllers/earnings_controller.dart";

class EarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarningsController>(() => EarningsController());
  }
}