import "../../../export.dart";

class ForumsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForumsController>(() => ForumsController());
  }
}
