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

import 'package:quantity_savers/app/modules/home/models/categories_details_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/filter_campaign_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/brandListResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_sub_sub_categoryResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_subcategory_responseModel.dart';
import '../../../export.dart';

FilterCampaignData? filterSelectctedData;

class FiltersController extends GetxController {
  String title = "";
  bool isLoading = false;
  //bool forVendorFiltration = Get.arguments['forVendors'] ?? false;
  final APIRepository apiRepository = APIRepository();
  BrandListResponseModel brandListResponseModel = BrandListResponseModel();
  ProductCategoriesResponseModel productCategoriesResponseModel =
      Get.find<HomeController>().productCategoriesResponseModel;
  VendorsResponseModel vendorsResponseModel =
      Get.find<HomeController>().vendorsResponseModel;
  ProductSubSubCategoryResponseModel productSubSubCategoryResponseModel =
      ProductSubSubCategoryResponseModel();
  CategoriesDetailResponseModel categoriesDetailResponseModel =
      CategoriesDetailResponseModel();
  ProductSubCategoryResponseModel productSubCategoryResponseModel =
      ProductSubCategoryResponseModel();
  var targetController;
  final campaignController = Get.find<ViewAllCampaignsController>();
  bool showCategory = true;
  bool showPrice = true;
  bool showRating = true;
  bool showVendors = true;
  bool clearedFilters = false;
  bool forCampaign = false;
  bool forVendor = false;
  var categoryName;
  var subCategoryId;
  var subCategoryName;
  bool showBrand = true;
  bool showDiscount = true;
  var categoryId;
  bool showDefaultSubcategory = false;
  bool showDefaultSubSubcategory = false;
  var tappedIndex = -1;

  int? initialPrice = 100;
  int? lowestPrice = 0;
  int? maxPrice = 1000;
  ViewAllCampaignsController? viewAllCampaignsController;

  List<CategoryDataModel> categoryList = [];
  List<Subcategories> subCatgoryList = [];
  List<SubSubcategories> childCategoryList = [];

  var ratings = [4, 3, 2, 1];
  var discount = [10, 20, 30, 40, 50, 60, 70, 80];
  var streams = ["Streaming Live", "No Streaming"];

  int selectedRatingIndex = -1;
  int selectedDiscountIndex = -1;
  int selectedStreaming = -1;
  int selectedCatIndex = -1;
  int selectedSubCategoryIndex = -1;
  int selectedChildCategoryIndex = -1;
  var selectedCategory = '';
  var subsubCategory;
  int? selectedVendorIndex = -1;
  int? selectedBrandIndex = -1;
  var sellerID;
  var brandId;
  int sellerIndex = -1;
  int brandIndex = -1;
  int subsubCategoryIndex = -1;
  bool filter = false;
  int? disIndex;

  List selectedCategories = [];

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArgs();
    // getArguments();
    //getDataFromArguments();
    debugPrint("getArgumentsDetail ${Get.arguments}");
    hitAllCategoriesData();

    hitGetBrandListApi();

    setFilterData();



    super.onInit();
  }

  setPrice(int? startPrice, int? endPrice) {
    filterSelectctedData?.lowestPrice = startPrice;
    filterSelectctedData?.highestPrice = endPrice;
    debugPrint("price ${filterSelectctedData?.lowestPrice}");
    debugPrint("price ${filterSelectctedData?.highestPrice}");
  }

  getArgs() {
    if (Get.arguments != null) {
      forCampaign = Get.arguments[argForCampaign] ?? false;
      forVendor = Get.arguments[argForVendors] ?? false;
    }
  }

  getDataFromArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['sellerId'] != null) {
        filterSelectctedData =
            FilterCampaignData(sellerId: Get.arguments['sellerId']);
      } else if (Get.arguments['brandId'] != null) {
        filterSelectctedData =
            FilterCampaignData(brandId: Get.arguments['brandId']);
      } else if (Get.arguments['categoryId'] != null &&
          Get.arguments['subCategoryId'] != null) {
        filterSelectctedData = FilterCampaignData(
            categoryId: Get.arguments['categoryId'],
            subcategoryId: Get.arguments['subCategoryId']);
      }
    }
  }

  void updatePrices(int start, int end) {
    lowestPrice = start;
    maxPrice = end;
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

  onSelectedRating(int index) async {
    if (index == selectedRatingIndex) {
      selectedRatingIndex = -1;
    } else {
      selectedRatingIndex = index;
    }
    update();
  }

  onSelectedDiscount(int index) async {
    selectedDiscountIndex = index;
    update();
  }

  onSelectedVendor(int tempIndex, var id) async {
    final index = vendorsResponseModel.data?.data
        ?.indexWhere((element) => element.sId == id);
    if (index != null && index != -1) {
      if (index == selectedVendorIndex) {
        selectedVendorIndex = -1;
        sellerID = '';
      } else {
        selectedVendorIndex = index;
        sellerID = id;
      }
      update();
    }
  }

  onSelectedBrand(int tempIndex, var id) async {
    final index = brandListResponseModel.data?.data
        ?.indexWhere((element) => element.sId == id);

    if (index != null && index != -1) {
      if (index == selectedBrandIndex) {
        selectedBrandIndex = -1;
        brandId = '';
      } else {
        selectedBrandIndex = index;
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

  hitGetBrandListApi() {
    isLoading = true;
    apiRepository.getBrandListApiCall().then((value) {
      if (value != null) {
        brandListResponseModel = value;
        isLoading = false;
        _highLighBrand();
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
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
        debugPrint("Theee subcategory named is $subCategoryName");
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

  getFilterData() {
    var data = FilterCampaignData(
      title: title,
      // forVendorFiltration: forVendorFiltration,
      lowestPrice: filterSelectctedData?.lowestPrice,
      highestPrice: filterSelectctedData?.highestPrice,
      categoryId: filterSelectctedData?.categoryId,
      subcategoryId: filterSelectctedData?.subcategoryId,
      subsubcategoryId: filterSelectctedData?.subsubcategoryId,
      selectedStreaming: selectedStreaming,
      categoryIndex: selectedCatIndex,
      subsubCategoryIndex: selectedChildCategoryIndex,
      customerRatingIndex: selectedRatingIndex,
      customerDiscountIndex: selectedDiscountIndex,
      streamingIndex: selectedStreaming,
      initialPrice: initialPrice,
      sellerIndex: selectedVendorIndex,
      brandIndex: selectedBrandIndex,
      isFilterApply: (clearedFilters == true) ? false : true,
      selectedRating: filterSelectctedData?.selectedRating,
      selectedDiscount: filterSelectctedData?.selectedDiscount,
      sellerId: filterSelectctedData?.sellerId,
      brandId: filterSelectctedData?.brandId,
    );
    filterSelectctedData = data;
    return filterSelectctedData;
  }

  clearFilterData() {
    filterSelectctedData = null;
    campaignController.loadfilterdData = false;
    selectedRatingIndex = -1;
    selectedStreaming = 0;
    forCampaign == true ? selectedCatIndex = -1 : ();
    lowestPrice = 0;
    maxPrice = 1000;
    clearedFilters = true;
    selectedDiscountIndex = -1;
    selectedChildCategoryIndex = -1;
    selectedSubCategoryIndex = -1;
    selectedCatIndex = -1;

    selectedVendorIndex = -1;
    selectedBrandIndex = -1;
    filterSelectctedData = null;
    update();
  }

  hitAllCategoriesData() {
    isLoading = true;
    apiRepository.getAllCategoriesDataApiCall().then((value) {
      if (value != null) {
        categoriesDetailResponseModel = value;
        categoryList = categoriesDetailResponseModel.data?.data ?? [];
        setFilterData();
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  void addDataToSubCategory() {
    selectedSubCategoryIndex = -1;
    selectedChildCategoryIndex = -1;

    subCatgoryList = categoryList[selectedCatIndex].subcategories ?? [];
    debugPrint("length of items ${filterSelectctedData?.categoryId}");
    update();
  }

  void addDataToChildCategory() {
    childCategoryList =
        subCatgoryList[selectedSubCategoryIndex].subSubcategories ?? [];
    update();
  }

  setFilterData() {
    _highLightCategories();
    _priceFilterDataSet();
    _selecteddiscount();
    _customerRating();
    _selectedVendorList();
    /*  if(Get.arguments!=null){
      if(Get.arguments['sellerId']!=null){
        filterSelectctedData = FilterCampaignData(sellerId: Get.arguments['sellerId']) ;
        _selectedVendorList();
      }else if(Get.arguments['brandId']!=null){
        filterSelectctedData = FilterCampaignData(brandId: Get.arguments['brandId']) ;
        _highLighBrand();
      }else if(Get.arguments['categoryId']!=null && Get.arguments['subCategoryId']!=null){
        filterSelectctedData = FilterCampaignData(categoryId: Get.arguments['categoryId'],subcategoryId:  Get.arguments['subCategoryId']) ;
      }
    }*/
  }

  _highLightCategories() {
    int categroyIndex = categoryList.indexWhere(
        (element) => element.sId == filterSelectctedData?.categoryId);
    selectedCatIndex = categroyIndex;
    CategoryDataModel model = categoryList.firstWhere(
        (element) => element.sId == filterSelectctedData?.categoryId,
        orElse: () => CategoryDataModel());
    if (model.sId != null) {
      title = model.name ?? "";
    } else {
      title = "";
    }

    if (selectedCatIndex != -1) {
      subCatgoryList = categoryList[selectedCatIndex].subcategories ?? [];
      int selectedSubCategory = subCatgoryList.indexWhere(
          (element) => element.sId == filterSelectctedData?.subcategoryId);

      selectedSubCategoryIndex = selectedSubCategory;
      debugPrint("selectedSubCategoryIndex ${selectedSubCategoryIndex}");

      update();

      if (selectedSubCategoryIndex != -1) {
        childCategoryList.clear();
        childCategoryList =
            subCatgoryList[selectedSubCategoryIndex].subSubcategories ?? [];

        int childCategoryId = childCategoryList.indexWhere(
            (element) => element.sId == filterSelectctedData?.subsubcategoryId);
        selectedChildCategoryIndex = childCategoryId;
        update();
      }
    }
  }

  _priceFilterDataSet() {
    lowestPrice = filterSelectctedData?.lowestPrice ?? lowestPrice;

    maxPrice = filterSelectctedData?.highestPrice ?? maxPrice;
  }

  _highLighBrand() {
    int? selectedBrand = brandListResponseModel.data?.data
        ?.indexWhere((element) => element.sId == filterSelectctedData?.brandId);
    selectedBrandIndex = selectedBrand;
    update();
  }

  _selecteddiscount() {
    debugPrint(
        "selectedDiscountList ${filterSelectctedData?.selectedDiscount}");
    int? selectedDiscoiunt = discount.indexWhere(
        (element) => element == filterSelectctedData?.selectedDiscount);
    selectedDiscountIndex = selectedDiscoiunt;
    update();
  }

  _customerRating() {
    int? selectedRatingList = ratings.indexWhere(
        (element) => element == filterSelectctedData?.selectedRating);
    selectedRatingIndex = selectedRatingList;
    update();
  }

  _selectedVendorList() {
    int? vendorIndex = vendorsResponseModel.data?.data?.indexWhere(
        (element) => element.sId == filterSelectctedData?.sellerId);
    selectedVendorIndex = vendorIndex;
    update();
  }
}
