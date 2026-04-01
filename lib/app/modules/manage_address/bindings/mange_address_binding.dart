import "../../../export.dart";

class ManageAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageAddressController>(() => ManageAddressController());
  }
}
