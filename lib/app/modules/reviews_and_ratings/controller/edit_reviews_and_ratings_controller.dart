import "package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart";
import "package:quantity_savers/app/modules/reviews_and_ratings/response_Model/delete_review_response_model.dart";
import "package:quantity_savers/app/modules/reviews_and_ratings/response_Model/edit_review_response_model.dart";
import "package:quantity_savers/app/modules/reviews_and_ratings/response_Model/product_review_response_model.dart";

import "../../../export.dart";
import "../../Details/models/data_models/product_details_data_model.dart";
import "../../Details/models/details_request_model.dart";
import "../data_model/review_rating_data_model.dart";

class EditReviewsAndRatingsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ProductDetailsResponseModel productDetailsResponseModel =
      ProductDetailsResponseModel();
  DeleteReviewResponseModel deleteReviewResponseModel =
      DeleteReviewResponseModel();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> uploadedImageFileList = [];
  List<XFile> uploadedVideoFileList = [];
  List<String> images = [];
  List<String> videos = [];
  var title = '';
  var argument = "";
  var productId = "";
  var reviewId = "";
  Map<String, dynamic>? requestModel;
  String docImagePath = "";
  Rx<double> rating = 1.0.obs;
  bool isFromProductDetails = false;
  var isRouteForEditReview = false;
  var editedUploadImages = false;
  var editedUploadVideos = false;
  var count = 0;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController reviewEditingController = TextEditingController();
  ImageResposemodel? imageUploadResponse = ImageResposemodel();
  ProductReviewResponseModel productReviewResponseModel =
      ProductReviewResponseModel();
  ReviewRatingData reviewRatingData = ReviewRatingData();
  EditReviewResponseModel editReviewResponseModel = EditReviewResponseModel();
  ReviewsAndRatingsController? reviewsAndRatingsController;

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty && isRouteForEditReview == false) {
      uploadedImageFileList.addAll(selectedImages);
    } else {
      if (selectedImages.isNotEmpty && reviewRatingData.images!=null) {
        uploadedImageFileList.addAll(selectedImages);
        for (var element in uploadedImageFileList) {
          docImagePath = element.path;
          imageUploadResponse = await _apiRepository.uploadImageAndVideoApi(
              docImagePath, "image");
          reviewRatingData.images?.add(imageUploadResponse?.data?.fileName);
          debugPrint('path is ${reviewRatingData.images?.length}');
        }
        uploadedImageFileList = [];
      }
      else
        {
          if(selectedImages.isNotEmpty)
            {
              uploadedImageFileList.addAll(selectedImages);
              for (var element in uploadedImageFileList) {
                docImagePath = element.path;
                imageUploadResponse = await _apiRepository.uploadImageAndVideoApi(
                    docImagePath, "image");
                images.add(imageUploadResponse?.data?.fileName);
                debugPrint('path is ${reviewRatingData.images?.length}');
              }
            }
        }
    }
    update();
  }

  void unselectImage(int index) {
    if (isRouteForEditReview == true) {
      debugPrint("Index is $index");
      reviewRatingData.images?.removeAt(index);
    } else {
      uploadedImageFileList.removeAt(index);
      debugPrint("Method Invoked");
    }
    update();
  }

  void selectVideos() async {
    final XFile? selectedVideos =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    if (isRouteForEditReview == false) {
      uploadedVideoFileList.add(selectedVideos!);
    } else {
      if (selectedVideos != null && reviewRatingData.videos!=null) {
        debugPrint('path is ${reviewRatingData.videos?.length}');
        uploadedVideoFileList.add(selectedVideos);
        for (var element in uploadedVideoFileList) {
          docImagePath = element.path;
          imageUploadResponse = await _apiRepository.uploadImageAndVideoApi(
              docImagePath, "video");
          reviewRatingData.videos?.add(imageUploadResponse?.data?.fileName);
        }
        uploadedVideoFileList = [];
      }
      else
        {
          if(selectedVideos!=null)
            {
              uploadedVideoFileList.add(selectedVideos);
              for (var element in uploadedVideoFileList) {
                docImagePath = element.path;
                imageUploadResponse = await _apiRepository.uploadImageAndVideoApi(
                    docImagePath, "video");
                videos.add(imageUploadResponse?.data?.fileName);
              }
            }
        }
    }
    update();
  }

  void unselectVideo(int index) {
    if (isRouteForEditReview == true) {
      debugPrint("Index is $index");
      reviewRatingData.videos?.removeAt(index);
    } else {
      uploadedVideoFileList.removeAt(index);
      debugPrint("Method Invoked");
    }

    update();
  }

  @override
  void onInit() {
    if (Get.isRegistered<ReviewsAndRatingsController>()) {
      reviewsAndRatingsController = Get.find<ReviewsAndRatingsController>();
    }
    lightTheme(color: AppColors.appColor);
    getArguments();
    if (isRouteForEditReview == false) {
      hitGetProductsDetailsApi();
    }

    textEditingController = TextEditingController(
      text: isRouteForEditReview == true
          ? reviewRatingData.title
          : '',
    );
    reviewEditingController = TextEditingController(
      text: isRouteForEditReview == true
          ? reviewRatingData.description
          : '',
    );

    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      argument = Get.arguments[argForWriteReview];

      title = Get.arguments[argForWriteReview];

      isFromProductDetails = Get.arguments[argIsFromProductDetails] ?? false;

      productId = Get.arguments[argProductId] ?? '';

      if (argument == strEditReviewsAndRatings) {
        isRouteForEditReview = Get.arguments[argIsRouteForEditReview] ?? false;
        reviewId = Get.arguments[argReviewId];
        reviewRatingData = Get.arguments[argIsReviewRatingResponseModel];
      }
    }
  }

  hitGetProductsDetailsApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productDetailsRequestModel(id: productId);

    _apiRepository
        .getProductDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productDetailsResponseModel = value;
        productId = productDetailsResponseModel.data?.sId ?? "";
        if (productDetailsResponseModel.data != null) {
          productDetailsResponseModel.data!.productVariations ??= [];
          productDetailsResponseModel.data!.productVariations!.insert(
            0,
            ProductVariations(
                sId: productDetailsResponseModel.data!.sId ?? "",
                name: productDetailsResponseModel.data!.name ?? "",
                price: productDetailsResponseModel.data!.price ?? 0,
                discountPrice:
                    productDetailsResponseModel.data!.discountPrice ?? 0.0,
                quantity: productDetailsResponseModel.data!.quantity ?? 0,
                productId: productDetailsResponseModel.data!.sId ?? "",
                wholesaleQuntity:
                    productDetailsResponseModel.data!.wholesaleQuntity ?? 0),
          );
        }
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitProductReviewApi() async {
    for (var element in uploadedImageFileList) {
      docImagePath = element.path;
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
      images.add(imageUploadResponse?.data?.fileName);
      debugPrint('path is ${reviewRatingData.images?.length}');
    }
    for (var element in uploadedVideoFileList) {
      docImagePath = element.path;
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "video");
      videos.add(imageUploadResponse?.data?.fileName);
    }

    requestModel = DetailsRequestModel.productReviewRequestModel(
        productId: productId,
        title: textEditingController.text,
        description: reviewEditingController.text,
        rating: rating.toDouble(),
        arrayImage: images.isNotEmpty ? images : null,
        arrayVideo: videos.isNotEmpty ? videos : null);
    _apiRepository
        .userReviewApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        productReviewResponseModel = value;
        Get.back(result: {
          argProductId: productId,
          argReviewId: productReviewResponseModel.data?.sId,
        });
        showToast(message: "Review added successfully");
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitEditReviewApi() {
    requestModel = DetailsRequestModel.editReviewRequestModel(
        id: reviewId,
        title: textEditingController.text,
        description: reviewEditingController.text,
        rating: reviewRatingData.ratings.toDouble(),
        arrayImage: reviewRatingData.images!=null?reviewRatingData.images:images.isNotEmpty?images:null,
        arrayVideo: reviewRatingData.videos!=null?reviewRatingData.videos:videos.isNotEmpty?videos:null,
    );

    _apiRepository.editReviewApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        editReviewResponseModel = value;
        reviewsAndRatingsController?.getReviewRatingListApi();
        Get.back();
        showToast(message: editReviewResponseModel.message.toString());
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  deleteReviewApi(String sId) {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.deleteReviewRequestModel(id: sId);
    _apiRepository.deleteReviewApiCall(dataBody: requestModel).then((value) {
      if (value != null) {
        deleteReviewResponseModel = value;
        reviewsAndRatingsController?.getReviewRatingListApi();

        Get.back(result: true);
        showToast(message: deleteReviewResponseModel.data?.message.toString());
        // getReviewRatingListApi();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
