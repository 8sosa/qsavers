import "package:quantity_savers/app/modules/reviews_and_ratings/response_Model/delete_review_response_model.dart";
import "package:quantity_savers/app/modules/reviews_and_ratings/response_Model/review_rating_response_model.dart";

import "../../../export.dart";
import "../../Details/models/details_request_model.dart";

class ReviewsAndRatingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ReviewRatingResponseModel reviewRatingResponseModel =
      ReviewRatingResponseModel();
  DeleteReviewResponseModel deleteReviewResponseModel =
      DeleteReviewResponseModel();
  String updatedDate = '';

  @override
  void onInit() {
    getReviewRatingListApi();
    super.onInit();
  }

  getReviewRatingListApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productReviewRequestModel();
    _apiRepository.userReviewListApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        reviewRatingResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  deleteReviewApi(String sId) {

    Map<String, dynamic> requestModel =
        DetailsRequestModel.deleteReviewRequestModel(id: sId);
    _apiRepository.deleteReviewApiCall(dataBody: requestModel).then((value) {
      if (value != null) {

        deleteReviewResponseModel=value;
        showToast(message: deleteReviewResponseModel.data?.message.toString());
        getReviewRatingListApi();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
