import "../../../export.dart";

class ViewRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewRequestsController>(() => ViewRequestsController());
  }
}
