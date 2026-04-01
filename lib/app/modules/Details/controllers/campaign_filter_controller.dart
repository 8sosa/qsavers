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
import 'package:quantity_savers/app/modules/home/models/response_model/brandListResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_sub_sub_categoryResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_subcategory_responseModel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../export.dart';
import '../../Details/models/details_request_model.dart';

class CampaignFilterController extends GetxController {
  String title = "";
  bool isLoading = false;
  bool forVendorFiltration = Get.arguments['forVendors'] ?? false;
  final APIRepository apiRepository = APIRepository();
  BrandListResponseModel brandListResponseModel = BrandListResponseModel();
  ProductCategoriesResponseModel productCategoriesResponseModel =
      Get.find<HomeController>().productCategoriesResponseModel;
  VendorsResponseModel vendorsResponseModel =
      Get.find<HomeController>().vendorsResponseModel;
  ProductSubSubCategoryResponseModel productSubSubCategoryResponseModel =
  ProductSubSubCategoryResponseModel();
  ProductSubCategoryResponseModel productSubCategoryResponseModel =
  ProductSubCategoryResponseModel();
  var targetController;
  final campaignController = Get.find<ViewAllCampaignsController>();
  bool showCategory = true;
  bool showPrice = true;
  bool showRating = true;
  bool showVendors = true;
  bool clearedFilters = false;
  bool forCampaign = true;
  var categoryName;
  var subCategoryId;
  var subCategoryName;
  bool showBrand = true;
  bool showDiscount = true;
  var categoryId;
  bool showDefaultSubcategory=false;
  bool showDefaultSubSubcategory=false;
  var tappedIndex =-1;

  int initialPrice = 1000;
  int lowestPrice = 0;
  int maxPrice = 1000;
  ViewAllCampaignsController? viewAllCampaignsController;

  var categories = [
    "Electronics",
    "TVs & Appliances",
    "Men",
    "Women",
    "Baby & Kids",
    "Home & Furniture",
    "Sports, Books & More"
  ];
  var ratings = [4, 3, 2, 1];
  var discount = [10, 20, 30, 40, 50, 60, 70, 80];
  var streams = ["Streaming Live", "No Streaming"];

  int selectedRating = -1;
  int selectedDiscount = -1;
  int selectedStreaming = -1;
  int selectedCatIndex = -1;
  int selectedSubSubCatIndex = -1;
  var selectedCategory = '';
  var subsubCategory ;
  int selectedVendor = -1;
  int selectedBrand = -1;
  var sellerID;
  var brandId;
  int sellerIndex = -1;
  int brandIndex = -1;
  int subsubCategoryIndex = -1;
  bool filter = false;
  int? disIndex;

  List selectedCategories = [];

  isShowCategory() async {
    showCategory = !showCategory;
    update();
  }

  isShowPrice() async {
    showPrice = !showPrice;
    update();
  }

  isShowRating() async {
    showRating = !showRating;
    update();
  }

  isShowDiscount() async {
    showDiscount = !showDiscount;
    update();
  }

  isShowVendors() async {
    showVendors = !showVendors;
    update();
  }

  isShowBrand() async {
    showBrand = !showBrand;
    update();
  }

  void setDefaultCategoryIndex() {
    print('category>>$categoryName');
    if (categoryName == productCategoriesResponseModel.data?.data?[2].name) {
      selectedCatIndex = 2;
      selectedCategory=productCategoriesResponseModel.data?.data?[2].sId ?? "";

    } else if (categoryName ==
        productCategoriesResponseModel.data?.data?[1].name) {
      selectedCatIndex = 1;
      selectedCategory=productCategoriesResponseModel.data?.data?[1].sId ?? "";

    } else if (categoryName ==
        productCategoriesResponseModel.data?.data?[0].name) {
      selectedCatIndex = 0;
      selectedCategory=productCategoriesResponseModel.data?.data?[0].sId ?? "";

    } else {
      selectedCatIndex = -1;
    }
    update();
  }

  onSelectCategory(int index) async {
    if (selectedCatIndex == index) {
      selectedCatIndex = -1;
      selectedCategory = '';
    } else {
      selectedCatIndex = index;
      selectedCategory =
          productCategoriesResponseModel.data?.data?[index].sId ?? '';


      print(selectedCatIndex);
      print("Category Id is $selectedCategory");
    }
    update();
  }

  onSelectSubSubCategory(int index) async {

    if (selectedSubSubCatIndex == index) {
      selectedSubSubCatIndex = -1;
      subsubCategory = '';
    } else {
      selectedSubSubCatIndex = index;
      subsubCategory =
          productSubSubCategoryResponseModel.data?.data?[index].sId ?? '';
      debugPrint("SubSubCategory is $subsubCategory");
    }
    update();
  }

  onSelectedRating(int index) async {
    if (index == selectedRating) {
      selectedRating = -1;
    } else {
      selectedRating = index;
    }
    update();
  }

  onSelectedDiscount(int index) async {
    if (index == selectedDiscount) {
      selectedDiscount = -1;
    } else {
      disIndex = index;
      selectedDiscount = index;
    }
    update();
  }

  onSelectedVendor(int tempIndex, var id) async {
    final index = vendorsResponseModel.data?.data
        ?.indexWhere((element) => element.sId == id);
    if (index != null && index != -1) {
      if (index == selectedVendor) {
        selectedVendor = -1;
        sellerID = '';
      } else {
        selectedVendor = index;
        sellerID = id;
      }
      update();
    }
  }

  onSelectedBrand(int tempIndex, var id) async {
    final index = brandListResponseModel.data?.data
        ?.indexWhere((element) => element.sId == id);

    if (index != null && index != -1) {
      if (index == selectedBrand) {
        selectedBrand = -1;
        brandId = '';
      } else {
        selectedBrand = index;
        brandId = id;
      }
      update();
    }
  }

  onSelectedStream(int index) async {
    if (index == selectedStreaming) {
      selectedStreaming = -1;
    } else {
      selectedStreaming = index;
    }
    update();
  }

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    setDefaultCategoryIndex();
    if (forCampaign == false) {
      checkIfLoadedAlready();
    } else {
      checkIfLoadedAlready();
    }

    hitGetBrandListApi();
    if(subCategoryId!="")
    {
      hitSubSubCategoriesApi(subCategoryId,-1);
      subCategoryId=null;
    }






    super.onInit();
  }

  hitSubSubCategoriesApi(String? subCatId,int index) {
    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.subsubCategoryRequestModel(subCategoryId: subCatId);
    debugPrint("RequestModel is $requestModel");
    apiRepository
        .getSubSubCategoryApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productSubSubCategoryResponseModel = value;
        tappedIndex=index;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitGetBrandListApi() {
    isLoading = true;
    apiRepository.getBrandListApiCall().then((value) {
      if (value != null) {
        brandListResponseModel = value;
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  checkIfLoadedAlready() {
    if (targetController.isLoadedOnce == true) {
      selectedRating = targetController.ratingIndex;
      selectedStreaming = targetController.streamingIndex;
      selectedCatIndex = targetController.categoryIndex;
      lowestPrice = targetController.minPrice;
      maxPrice = targetController.maxPrice;
      initialPrice = targetController.initialPrice;
      selectedVendor = targetController.sellerIndex;
      selectedBrand = targetController.brandIndex;
      selectedDiscount = targetController.discountIndex;
      selectedSubSubCatIndex = targetController.subsubCategoryIndex;
    }
  }

  getArguments() {
    if (Get.arguments != null) {
      title = Get.arguments[argTitle];
      if (Get.arguments[argFilterMaxPrice] != null) {
        maxPrice = Get.arguments[argFilterMaxPrice];
        initialPrice = maxPrice;
        print('max p $maxPrice');
        update();
      }

      forCampaign = Get.arguments[argForCampaign];
      if (forCampaign == false) {
        categoryName = Get.arguments[argCategoryName] ?? "";
        subCategoryName = Get.arguments[argSubCategoryName] ?? "";
        subCategoryId = Get.arguments[argSubCategoryId] ?? "";
        categoryId = Get.arguments[argCategoryId] ?? "";
        debugPrint("Theee category Id is $categoryId");
        debugPrint("Theee subCategory Id is $subCategoryId");
        targetController =
            Get.put<VendorsProductsController>(VendorsProductsController());
      } else if (forCampaign == true) {
        targetController =
            Get.put<ViewAllCampaignsController>(ViewAllCampaignsController());
      }

      update();
    }
  }

  FilterCampaignData getFilterData() {
    debugPrint("The category Id is ${selectedCategory}");
    return FilterCampaignData(
        title: title,
        // forVendorFiltration: forVendorFiltration,
        lowestPrice: lowestPrice,
        highestPrice: maxPrice,
        categoryId: selectedCategory,
        subcategoryId:subCategoryId,
        subsubcategoryId: subsubCategory,
        selectedStreaming: selectedStreaming,
        categoryIndex: selectedCatIndex,
        subsubCategoryIndex: selectedSubSubCatIndex,
        customerRatingIndex: selectedRating,
        customerDiscountIndex: selectedDiscount,
        streamingIndex: selectedStreaming,
        initialPrice: initialPrice,
        sellerIndex: selectedVendor,
        brandIndex: selectedBrand,
        isLive:selectedStreaming==0?true:false,
        isFilterApply: (clearedFilters == true) ? false : true,
        selectedRating: (selectedRating == -1) ? 0 : 4 - selectedRating,
        selectedDiscount: disIndex == 0
            ? 10
            : disIndex == 1
            ? 20
            : disIndex == 2
            ? 30
            : disIndex == 3
            ? 40
            : disIndex == 4
            ? 50
            : disIndex == 5
            ? 60
            : disIndex == 6
            ? 70
            : disIndex == 7
            ? 80
            : 0,
        sellerId: (selectedVendor == -1) ? null : sellerID,
        brandId: (selectedBrand == -1) ? null : brandId);
  }

  clearFilterData() {
    campaignController.loadfilterdData = false;
    selectedRating = -1;
    selectedStreaming = -1;
    forCampaign == true ? selectedCatIndex = -1 : ();
    lowestPrice = 0;
    maxPrice = initialPrice;
    clearedFilters = true;
    selectedDiscount = -1;
    selectedSubSubCatIndex = -1;

    selectedVendor = -1;
    selectedBrand = -1;
    update();
  }

  hitCategoryData(var categoryId) {
    Map<String, dynamic> requestModel =
    DetailsRequestModel.subCategoryRequestModel(categoryId: categoryId);
    debugPrint("RequestModel is $requestModel");
    apiRepository.getSubCategoryApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        productSubCategoryResponseModel = value;
        showDefaultSubcategory=true;

        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitSubCategoryData(var subCategoryId)
  {
    Map<String, dynamic> requestModel =
    DetailsRequestModel.subsubCategoryRequestModel(subCategoryId: subCategoryId);
    debugPrint("RequestModel is $requestModel");
    apiRepository
        .getSubSubCategoryApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        productSubSubCategoryResponseModel=value;
        showDefaultSubSubcategory=true;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

}
