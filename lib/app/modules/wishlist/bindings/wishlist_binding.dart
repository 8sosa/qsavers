import "../../../export.dart";

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(() => WishlistController());
  }
}
