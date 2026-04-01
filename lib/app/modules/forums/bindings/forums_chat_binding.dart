import "../../../export.dart";

class ForumsChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForumsChatController>(() => ForumsChatController());
  }
}
