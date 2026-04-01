import "../../../export.dart";

class EditReviewsAndRatingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditReviewsAndRatingsController>(
        () => EditReviewsAndRatingsController());
  }
}
