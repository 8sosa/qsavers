import "../../../export.dart";

class AddNewAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewAddressController>(() => AddNewAddressController());
  }
}
