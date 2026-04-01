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

import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/src/models/location.dart' as Location;
import 'package:quantity_savers/app/core/utils/countdown_timer.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/add_to_cart_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/can_review_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/delivery_check_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/faq_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_campaigns_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_faq_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_review_like_and_dislike_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/related_product_response_model.dart';
import 'package:quantity_savers/app/modules/Details/widgets/not_purchased_widget.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/user_product_review_response_model.dart';


import '../../../export.dart';

import '../models/data_models/product_details_data_model.dart';

class ProductDetailsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  late CountdownTimer _countdownTimer;
  FAQResponseModel faqResponseModel = FAQResponseModel();
  ProductReviewLikeAndDislikeResponseModel productReviewLikeAndDislikeResponseModel = ProductReviewLikeAndDislikeResponseModel();
  TextEditingController textEditingController =TextEditingController();
  FocusNode focusNode = FocusNode();
  Map<int, String> timers = {};
  bool isLoading = false;
  String productId = "";
  String campaignId = "";
  bool isSpecsExpanded = false;
  var inStockCardSelectedIndex = 0;
  var check=false;
  ProductDetailsResponseModel productDetailsResponseModel =
      ProductDetailsResponseModel();
  ProductFaqResponseModel productFaqResponseModel = ProductFaqResponseModel();
  CanReviewResponseModel canReviewResponseModel = CanReviewResponseModel();
  ProductCampaignsResponseModel productCampaignsResponseModel =
      ProductCampaignsResponseModel();
  RelatedProductResponseModel relatedProductResponseModel =
      RelatedProductResponseModel();
  UserProductReviewResponseModel userProductReviewResponseModel =
      UserProductReviewResponseModel();
  DeliveryCheckResponseModel deliveryCheckResponseModel =
      DeliveryCheckResponseModel();
  final List<String> items = [
    'I have an account on iMatch',
    'I have an account on HurryHeart',
    'I have an account on Connect-Verse',
  ];
  final List<String> itemsCount = List.generate(5, (index) => "${index + 1}");

  int? value = 3;
  RxString? selectedValue = "".obs;
  RxString? selectedQuantityValue = "1".obs;
  RxInt? price;

  var currentIndex = 0;
  var qualified = false;
  RxBool showSuffixIcon = false.obs;
  bool changesInWishlist = false;
  var faqLength = 0;
  var totalReviews = 0;
  var result;
  var searchScreen=false;
  var wishListScreen=false;
  bool viewWishList = false;

  onWishlistTapped(bool val) {}

  TextEditingController searchfieldText = TextEditingController();

  FocusNode searchFieldFocusNode = FocusNode();
  AddToCartResponseModel addToCartResponseModel =AddToCartResponseModel();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    _countdownTimer = CountdownTimer();
    hitGetProductsDetailsApi();
    hitProductFaqDetailsApi();
    hitRelatedProductsApi();
    if ((_localStorage.getAuthToken() ?? "") != "") {
      hitGetProductCampaignsApi();
    }
    super.onInit();
  }

  onChangeInStockCardSelectedIndex({index}) {
    inStockCardSelectedIndex = index;
  }

  getArguments() {
    if (Get.arguments != null) {
      productId = Get.arguments[argProductId];
      searchScreen=Get.arguments[argSearchScreen] ?? false;
      wishListScreen=Get.arguments[argWishList] ?? false;
      update();
    }
  }

  updateSuffixIconVisibility() async {
    if (searchfieldText.length > 0) {
      showSuffixIcon.value = true;
    } else {
      showSuffixIcon.value = false;
    }
    update();
  }

  clearSearchField() async {
    searchfieldText.clear();
    updateSuffixIconVisibility();
    update();
  }

  onPageChanged(int index) async {
    currentIndex = index;
    update();
  }

  onChangeDropDownValue(String? str) async {
    selectedValue?.value = str ?? "";
    qualified = true;
    update();
  }

  onChangeDropDownValueQuantity(String? str) async {
    selectedQuantityValue?.value = str ?? "";
    update();
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
        update();
      }
    }).catchError((error, stackTrace) {
      debugPrint("message: '$stackTrace'");
    });
  }


  hitLikeProductFaq(var id,var type)
  {
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
        DetailsRequestModel.productFaqLikeRequestModel(faqId: id,type: type);
        _apiRepository.productFaqLikeApi(dataBody: requestModel).then((value){
          if(value!=null)
          {
            faqResponseModel = value;
            isLoading=false;
            hitProductFaqDetailsApi(showLoader: false);
            update();
          }
        }).onError((error, stackTrace) => showToast(message: error.toString()));

      }

  }


  hitProductFaqDetailsApi({bool showLoader=true}) {
   if(showLoader)
     {
       isLoading = true;
     }
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productFaqRequestModel(productId: productId);
    _apiRepository.getProductFaqApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        debugPrint("ApiHit");
        productFaqResponseModel = value;
        faqLength = productFaqResponseModel.totalCount ?? 0;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
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

  handleAddToCart() {
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
           hitAddToCartApi();
    }
  }

  handleStartCampaign()
  {
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
    }
    else
      {
        Get.toNamed(AppRoutes.startCampaignScreenRoute);
      }
  }

  hitAddToCartApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.addToCartRequestModel(
            productId: productId,
            quantity: int.parse(selectedQuantityValue!.value));

    _apiRepository
        .addProductToCartApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
         addToCartResponseModel=value;
         updateToCartApi();
         update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  updateToCartApi() {
    Map<String, dynamic> requestModel =
    DetailsRequestModel.updateToCartRequestModel(
        id: addToCartResponseModel.data?.sId,
        quantity: int.parse(selectedQuantityValue!.value));
    _apiRepository
        .updateProductToCartApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        Get.toNamed(AppRoutes.checkoutItemScreenRoute,
            arguments: {argForCheckout: argForNormalOrder});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitRelatedProductsApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.relatedProductRequestModel(productId: productId);
    _apiRepository
        .relatedProductsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        relatedProductResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitGetProductCampaignsApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productCampaignsRequestModel(productId: productId);
    _apiRepository
        .getProductCampaignsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productCampaignsResponseModel = value;
        productCampaignsResponseModel.data?.toList().forEach((item) {
          _startTimer(item.startDate, item.endDate);
        });
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  handleWishlist(dynamic data, bool? inWishlist) {

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
      if (inWishlist == false) {
        // productDetailsResponseModel.data?.wishlist =
        //     !(productDetailsResponseModel.data?.wishlist ?? false);
        hitAddToWishlistApi(data);
      } else {
        hitDeleteFromWishlistApi(data);
      }
    }

    changesInWishlist = true;
    update();
  }

  hitAddToWishlistApi(dynamic data) {

    Map<String, dynamic> requestModel =
        DetailsRequestModel.addToWishlistRequestModel(
      productId: data,
    );
    _apiRepository
        .addProductToWishlistApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        hitGetProductsDetailsApi(showLoader: false);
        hitRelatedProductsApi();
        update();
        showToast(message: "Item added to wishlist");
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteFromWishlistApi(dynamic data) {
    _apiRepository
        .removeProductFromWishlistApiCall(productId: data)
        .then((value) {
      if (value != null) {
        hitGetProductsDetailsApi(showLoader: false);
        print('removed from wishlist');
        hitRelatedProductsApi();
        update();
        showToast(message: "Item removed from wishlist");
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  @override
  void dispose() {
    _countdownTimer.stop();
    searchFieldFocusNode.dispose();
    super.dispose();
  }

  void _startTimer(int startDateMillis, int endDateMillis) {
    _countdownTimer.start(endDateMillis, (timerText) {
      timers[endDateMillis] = timerText;
      update();
    });
  }

  hitGetProductReviewApi(var productId) {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.userProductReviewRequestModel(productId: productId);
    _apiRepository
        .userProductReviewApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        userProductReviewResponseModel = value;
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  String? formatDiscount(var number) {
    if (number != null) {
      if ((number) % 1 == 0) return number.toString();
    }

    if (number?.toStringAsFixed(1) == number.toString()) {
      return number.toString();
    } else {
      var str = number?.toStringAsFixed(2);
      return (str?[str.length - 1] == '0')
          ? str?.substring(0, str.length - 1)
          : str;
    }
  }

  double getDiscountPercentage() {
    final price = productDetailsResponseModel.data?.price ?? 0.0;
    final wholesalePrice = productDetailsResponseModel.data?.wholesalePrice ?? 0.0;

    if (price == 0) return 0.0;

    return ((price - wholesalePrice) / price) * 100;
  }

  Future<void> getLocationFromAddress(String address) async {
    try {
      List<Location.Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        for (var location in locations) {

          double latitude = location.latitude;
          double longitude = location.longitude;
          print('Latitude: $latitude, Longitude: $longitude');
          hitDeliveryCheckApi(latitude, longitude);
        }
      } else {

        print('No location found');
      }
    } catch (e) {

      print('Error getting location: $e');
    }
  }


  hitDeliveryCheckApi(var lat , var lng) {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.deliveryCheckRequestModel(
      productId: productId,
          lat: lat,
          lng: lng,
    );

    _apiRepository
        .getDeliveryCheckApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        deliveryCheckResponseModel=value;
        if(deliveryCheckResponseModel.data?.isDeliveryAvailable==true)
          {
            check=true;
            showToast(message: "Delivery is available at this area");
          }
        // showToast(message: deliveryCheckResponseModel.data.isDeliveryAvailable)
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitProductReviewLikeAndDislikeApi(String id,String type)
  {
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
    }

    else
      {
        Map<String, dynamic> requestModel =
        DetailsRequestModel.productReviewLikeAndDislikeRequestModel(
            id: id,
            type:type
        );

        _apiRepository.productReviewLikeApi(dataBody: requestModel).then((value){
          if(value!=null)
          {
            productReviewLikeAndDislikeResponseModel=value;
            hitGetProductsDetailsApi(showLoader: false);
            update();
          }

        }).onError((error, stackTrace) => showToast(message: error.toString()));
      }


  }


}
