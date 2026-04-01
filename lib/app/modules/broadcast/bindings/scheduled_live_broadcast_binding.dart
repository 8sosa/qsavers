import "../../../export.dart";

class ScheduledLiveBroadcastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduledLiveBroadcastController>(
        () => ScheduledLiveBroadcastController());
  }
}
