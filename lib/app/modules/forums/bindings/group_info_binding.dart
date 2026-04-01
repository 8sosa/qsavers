import "../../../export.dart";

class GroupInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupInfoController>(() => GroupInfoController());
  }
}
