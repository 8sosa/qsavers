import "../../../export.dart";

class DeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountController>(() => DeleteAccountController());
  }
}
