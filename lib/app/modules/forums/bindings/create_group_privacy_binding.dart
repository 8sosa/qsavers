import "../../../export.dart";

class CreateGroupPrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGroupController>(() => CreateGroupController());
  }
}
