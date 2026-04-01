
import "../../../export.dart";

class AddNewCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewCardController());
  }
}
