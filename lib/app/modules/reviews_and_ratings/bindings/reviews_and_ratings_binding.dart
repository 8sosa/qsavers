import "../../../export.dart";

class ReviewsAndRatingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsAndRatingsController>(
        () => ReviewsAndRatingsController());
  }
}
