/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_media_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_review_like_and_dislike_response_model.dart';

import '../../../export.dart';
import '../models/response_model/can_review_response_model.dart';
import '../widgets/not_purchased_widget.dart';

class ViewAllReviewsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  CanReviewResponseModel canReviewResponseModel = CanReviewResponseModel();
  ProductDetailsResponseModel productDetailsResponseModel =
      ProductDetailsResponseModel();
  ProductReviewLikeAndDislikeResponseModel
      productReviewLikeAndDislikeResponseModel =
      ProductReviewLikeAndDislikeResponseModel();
  ProductMediaResponseModel productMediaResponseModel =
      ProductMediaResponseModel();

  var productId = "";
  bool isLoading = false;
  var totalReviews = 0;
  final Map<String, double> allVideosWithRatings = {};
  final List<String> allImages = [];

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    hitMediaReviewApi();
    super.onInit();
  }

  void getArguments() {
    if (Get.arguments != null) {
      productId = Get.arguments[argProductId];
      hitGetProductsDetailsApi();
    }
  }

  getVideos() {
    productMediaResponseModel.data?.data?.forEach((review) {
      final videos = review.videos ?? [];
      final rating = (review.ratings ?? 0.0).toDouble();
      for (var video in videos) {
        allVideosWithRatings[video] = rating;
      }
    });
    debugPrint("00000${allVideosWithRatings.length}");
  }

  getImages() {
    productDetailsResponseModel.data?.ratings?.forEach((rating) {
      allImages.addAll(rating?.images ?? []);
      debugPrint("ImageLength is${allImages.length}");
    });
  }

  hitGetProductsDetailsApi({bool showLoader=true}) {
    if(showLoader)
    {
      isLoading = true;
    }
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productDetailsRequestModel(id: productId);

    _apiRepository
        .getProductDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productDetailsResponseModel = value;
        productId = productDetailsResponseModel.data?.sId ?? "";
        if (productDetailsResponseModel.data != null) {
          productDetailsResponseModel.data!.productVariations ??=
              []; // Ensure productVariations list is initialized
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
        totalReviews = productDetailsResponseModel.data?.totalReviews ?? 0;
        isLoading = false;
        // hitGetProductReviewApi(productDetailsResponseModel.data?.sId);
        getImages();
        update();
      }
    }).catchError((error, stackTrace) {
      isLoading = false;
      update();
      debugPrint("message: '$stackTrace'");
    });
  }

  handleRateProduct() {
    if (_localStorage.getAuthToken() == null) {
      Get.dialog(CustomDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
          confirmBtnBgColor: AppColors.gradientColorSecondary,
          title: strNotAuthorized,
          confirmTitle: strLogin,
          cancelTitle: strSignup,
          isCustomizedTapCancel: true,
          onTapCancel: () {
            Get.offAllNamed(AppRoutes.signupRoute);
          },
          onTapConfirm: () {
            Get.offAllNamed(AppRoutes.loginRoute);
          }));
    } else {
      hitCanReviewApi();
    }
  }

  hitCanReviewApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productFaqRequestModel(productId: productId);
    _apiRepository.canReviewApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        canReviewResponseModel = value;
        if (canReviewResponseModel.data?.canReview == true) {
          Get.toNamed(AppRoutes.editReviewsAndRatingsRoute, arguments: {
            argIsFromProductDetails: true,
            argForWriteReview: strEditProductDetails,
            argProductId: productId
          });
          // result[argReviewId];
        } else {
          Get.to(const NotPurchasedWidget());
        }

        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitMediaReviewApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productDetailsMediaRequestModel(id: productId);
    _apiRepository
        .getProductMediaApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        debugPrint("YES INVOKED");
        productMediaResponseModel = value;
        isLoading = false;
        getVideos();
        update();
      }
    }).catchError((error, stackTrace) {
      isLoading = false;
      update();
      debugPrint("message: '$stackTrace'");
    });
  }

  hitProductReviewLikeAndDislikeApi(String id, String type) {
    if(_localStorage.getAuthToken() == null) {
      Get.dialog(CustomDialogWidget(
          cancelTitleColor: AppColors.gradientColorSecondary,
          cancelBtnBorder: Border.all(color: AppColors.gradientColorSecondary),
          confirmBtnBgColor: AppColors.gradientColorSecondary,
          title: strNotAuthorized,
          confirmTitle: strLogin,
          cancelTitle: strSignup,
          isCustomizedTapCancel: true,
          onTapCancel: () {
            Get.offAllNamed(AppRoutes.signupRoute);
          },
          onTapConfirm: () {
            Get.offAllNamed(AppRoutes.loginRoute);
          }));
    }
    else
      {
        Map<String, dynamic> requestModel =
        DetailsRequestModel.productReviewLikeAndDislikeRequestModel(
            id: id, type: type);

        _apiRepository.productReviewLikeApi(dataBody: requestModel).then((value) {
          if (value != null) {
            productReviewLikeAndDislikeResponseModel = value;
            hitGetProductsDetailsApi(showLoader: false);
            update();
          }
        }).onError((error, stackTrace) => showToast(message: error.toString()));
      }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
