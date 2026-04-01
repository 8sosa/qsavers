import "../../../export.dart";

class CreateGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupController>(() => CreateGroupController());
  }
}
