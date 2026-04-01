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

import 'package:quantity_savers/app/modules/home/models/response_model/deal_of_day_response_model.dart';

import '../../../export.dart';

class ViewAllProductsController extends GetxController {
  final APIRepository _repository = Get.find<APIRepository>();
  DealsOfTheDayResponseModel dealsOfTheDayResponseModel =
      DealsOfTheDayResponseModel();
  DealOfDayTimerResponseModel dealOfDayTimerResponseModel = DealOfDayTimerResponseModel();
  ScrollController scrollController = ScrollController();

  String title = "";
  var page = 0;
  bool isLoading = true;
  bool isPagination = false;
  var currentPage = 0;
  var limit = 10;


  @override
  void onInit() {
    getArguments();
    scrollController.addListener(() {
      _scrollListener();
    });
    lightTheme(color: AppColors.appColor);
    super.onInit();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }


  getArguments() {
    if (Get.arguments != null) {
      title = Get.arguments[argForViewAllProduct];
      if (title == strDealsOfDay) {
        getDealsOfTheDayData();
        _getDealOfTheTimerData();
      } else if (title == strTopFashionBrands) {
        getFashionDealsData();
      } else if (title == strFeaturesCategories) {
        getFeaturedCategoriesData();
      }
      update();
    }
  }


  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (title == strDealsOfDay) {
        getDealsOfTheDayData();
      } else if (title == strTopFashionBrands) {
        getFashionDealsData();
      } else if (title == strFeaturesCategories) {
        getFeaturedCategoriesData();
      }
      debugPrint("reach the bottom");
    }
  }


  getDealsOfTheDayData() async {
    currentPage = page;
    debugPrint("page : $page");
    isLoading = page == 0 ? true : false;
    isPagination = page > 0 ? true : false;
    update();
    var requestModel = HomepageRequestModel.productBannerRequestModel(
        pagination: page, limit: 10);
    _repository
        .getDealsOfTheDayApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          dealsOfTheDayResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            dealsOfTheDayResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }
        if ((value?.data?.data.length ?? 0) == 0) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((dealsOfTheDayResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getDealOfTheTimerData() async {

    _repository
        .getDealsOfTheDayTimerApiCall()
        .then((value) async {
      if (value != null) {
        dealOfDayTimerResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  getFashionDealsData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel(
      pagination: page,
      limit: 10,
    );
    _repository
        .getFashionDealsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          dealsOfTheDayResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            dealsOfTheDayResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }
        if ((value?.data?.data.length ?? 0) == 0) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((dealsOfTheDayResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  getFeaturedCategoriesData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _repository
        .getFeaturedCategoriesApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          dealsOfTheDayResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            dealsOfTheDayResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }
        if ((value?.data?.data.length ?? 0) == 0) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((dealsOfTheDayResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
