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

import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/corresponding_products_response_model.dart';

import '../../../export.dart';
import '../../Details/models/data_models/product_details_data_model.dart';
import '../../Details/models/details_request_model.dart';
import '../../Details/models/response_model/product_details_response_model.dart';

class VendorsProductsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  VendorsProductsResponseModel vendorsProductsResponseModel =
      VendorsProductsResponseModel();
  ProductDetailsResponseModel productDetailsResponseModel =
      ProductDetailsResponseModel();
  ScrollController scrollController = ScrollController();
  bool skipAuthForGetVendorsProducts = true;
  String? categoryId;
  String? subcategoryId;
  String? subSubCategoryId;
  String productId = "";
  String? sortBy;
  bool folded = true;
  bool isLoading = true;
  bool isPagination = false;
  bool dataNotFound = false;
  String title = "";
  String image = "";
  var currentPage = 0;
  var limit = 20;
  int bottomSheetSelectedIndex = 0;
  var argForViewVendorsProducts = "";
  var sellerId;
  bool filter = false;
  bool sorted = true;

  String tileOfCurrentPage = '';
  FilterCampaignData? filterParameters;
  List<String> sortByElement = [
    "All",
    "What’s New",
    "Popular",
    "Price High to Low",
    "Price to Low to High"
  ];

  TextEditingController searchFieldText = TextEditingController();
  FocusNode searchFieldFocusNode = FocusNode();
  bool showSuffixIcon = false;
  late TextEditingController searchController = TextEditingController();
  late FocusNode focusNode = FocusNode();
  bool showSearch = false;
  bool isLoadedOnce = false;
  int categoryIndex = -1;
  int minPrice = -1;
  int maxPrice = -1;
  int ratingIndex = -1;
  int streamingIndex = -1;
  int initialPrice = 100;
  int sellerIndex = -1;
  int discountIndex = -1;
  int subsubCategoryIndex = -1;
  int brandIndex = -1;
  var page = 0;
  var brandId;
  var searchScreen = false;
  var isRouteForSubCategory = false;

  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeIn,
  );

  void handleAnimation() async {
    showSearch = !showSearch;
    debugPrint("$showSearch");
    update();
  }

  onSelectSortByItem(int index) async {
    bottomSheetSelectedIndex = index;
    if (index == 1) {
      sortBy = "WHATS_NEW";
    } else if (index == 2) {
      sortBy = "POPULAR";
    } else if (index == 3) {
      sortBy = "PRICE_HIGH_TO_LOW";
    } else if (index == 4) {
      sortBy = "PRICE_LOW_TO_HIGH";
    } else {
      sortBy = "";
    }
    hitGetVendorsProductsApi();
    update();
  }

  @override
  void onInit() {
    // hitGetVendorsProductsApi();
    filterParameters = filterSelectctedData;
    getArguments();
    tileOfCurrentPage = title;
    scrollController.addListener(() {
      _scrollListener();
    });
    lightTheme(color: AppColors.appColor);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (argForViewVendorsProducts == strDealsOfDay) {
        // hitGetVendorsProductsApi();
      } else if (argForViewVendorsProducts == strForVendors) {
        //hitGetVendorsProduct();
      }
    }
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[argSubCategory] == true) {
        isRouteForSubCategory = Get.arguments[argSubCategory] ?? false;
        categoryId = Get.arguments[argCategoryId] ?? "";
        subcategoryId = Get.arguments[argSubCategoryId] ?? "";
        subSubCategoryId = Get.arguments[argSubSubCategoryId] ?? "";
        title = Get.arguments[argTitle] ?? "";
        debugPrint("$categoryId $subcategoryId $subSubCategoryId");
        hitGetSubSubProductsApi();
      } else {
        categoryId = Get.arguments[argCategoryId] ?? "";
        subcategoryId = Get.arguments[argSubCategoryId] ?? "";
        title = Get.arguments[argTitle] ?? "";
        image = Get.arguments[argImage] ?? "";
        sellerId = Get.arguments[argSellerId] ?? "";
        brandId = Get.arguments[argBrandId] ?? "";
        argForViewVendorsProducts =
            Get.arguments[argForViewVendorsProduct] ?? "";
        searchScreen = Get.arguments[argSearchScreen] ?? false;
        if (argForViewVendorsProducts == strDealsOfDay) {
          hitGetVendorsProductsApi();
        } else if (argForViewVendorsProducts == strForVendors) {
          hitGetVendorsProduct();
        }
      }
      debugPrint("ArgTitle is $title");
      debugPrint("ArgCategoryId is $categoryId");
      update();
    }
  }

  hitGetSubSubProductsApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        HomepageRequestModel.subSubProductsDetailsRequestModel(
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      subSubcategoryId: subSubCategoryId,
    );
    _apiRepository
        .getSubSubProductsDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        vendorsProductsResponseModel = value;
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  void hitGetVendorsProductsApi() {
    if (_localStorage.getAuthToken() != null) {
      skipAuthForGetVendorsProducts = false;
      update();
    }
    isLoading = true;
    Map<String, dynamic> requestModel =
        HomepageRequestModel.correspondingProductsDetailsRequestModel(
            categoryId: categoryId,
            subcategoryId: subcategoryId,
            sortBy: sortBy,
            brandId: brandId,
        sellerId: sellerId);
    if(categoryId!=null && subcategoryId!=null)
      {
        filterParameters?.categoryId=categoryId;
        filterParameters?.subcategoryId=subcategoryId;
      }
    else if(brandId!=null)
      {
        filterParameters?.brandId=brandId;
      }
    else if(sellerId!=null)
      {
        filterParameters?.sellerId=sellerId;
      }
    _apiRepository
        .getVendorsProductsDetailsApiCall(
            queryBody: requestModel, canSkipAuth: skipAuthForGetVendorsProducts)
        .then((value) {
      if (value != null) {
        vendorsProductsResponseModel = value;
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  void hitGetVendorsProduct() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        HomepageRequestModel.vendorProductsDetailsRequestModel(
            sellerId: sellerId);
    _apiRepository.getVendorsProductsApiCall(queryBody: requestModel).then(
      (value) {
        if (value != null) {
          vendorsProductsResponseModel = value;
          isLoading = false;
          update();
        }
      },
      onError: (error, stackTrace) {
        showToast(
          message: error.toString(),
        );
      },
    );
  }

  bool handleWishlist(dynamic data, bool? inWishlist) {
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
      return false;
    } else {
      if (inWishlist == false) {
        hitAddToWishlistApi(data);
      } else {
        hitDeleteFromWishlistApi(data);
      }
      return true;
    }
  }

  hitAddToWishlistApi(dynamic data) {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.addToWishlistRequestModel(
      productId: data,
    );
    _apiRepository
        .addProductToWishlistApiCall(queryBody: requestModel)
        .then((value) => showToast(message: "Item added to wishlist"))
        .onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteFromWishlistApi(dynamic data) {
    _apiRepository
        .removeProductFromWishlistApiCall(productId: data)
        .then((value) {
      if (value != null) {
        showToast(message: "Item removed to wishlist");
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  void hitGetVendorsFilteredProductsApi() {
    filterParameters = filterSelectctedData;
    isLoading = true;
    Map<String, dynamic> requestModel =
        HomepageRequestModel.filteredProductsDetailsRequestModel(
            categoryId: filterParameters?.categoryId == ""
                ? categoryId
                : filterParameters?.categoryId,
            subcategoryId: filterParameters?.subcategoryId,
            subsubcategoryId: filterParameters?.subsubcategoryId,
            minPrice: filterParameters?.lowestPrice,
            maxPrice: filterParameters?.highestPrice,
            selectedRating: filterParameters?.selectedRating,
            // selectedStreaming: filterParameters?.selectedStreaming,
            sortBy: sortBy,
            brandId: filterParameters?.brandId,
            discount: filterParameters?.selectedDiscount,
            sellerID: filterParameters?.sellerId);
    debugPrint("RequestModel is $requestModel");
    _apiRepository.getProductFiltersApi(queryBody: requestModel).then(
      (value) {
        if (value != null) {
          vendorsProductsResponseModel = value;
          isLoading = false;
          filterValuesUpdate();
          update();
        }
      },
      onError: (error, stackTrace) {
        showToast(
          message: error.toString(),
        );
      },
    );
  }

  filterValuesUpdate() {
    isLoadedOnce = true;
    categoryIndex = filterParameters?.categoryIndex ?? -1;
    minPrice = filterParameters?.lowestPrice ?? -1;
    maxPrice = filterParameters?.highestPrice ?? -1;
    ratingIndex = filterParameters?.customerRatingIndex ?? -1;
    streamingIndex = filterParameters?.streamingIndex ?? -1;
    initialPrice = filterParameters?.initialPrice ?? 100;
    sellerIndex = filterParameters?.sellerIndex ?? -1;
    brandIndex = filterParameters?.brandIndex ?? -1;
    discountIndex = filterParameters?.customerDiscountIndex ?? -1;
    subsubCategoryIndex = filterParameters?.subsubCategoryIndex ?? -1;
    filter = filterParameters?.isFilterApply ?? true;
  }
}
