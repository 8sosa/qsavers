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

import '../../../export.dart';

class ViewAllVendorsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _repository = Get.find<APIRepository>();
  var title = strPopularVendors;
  var isLoading = true;
  var forVendors = true;
  bool isPagination = false;
  var page = 0;
  var currentPage = 0;
  var limit = 10;
  ScrollController scrollController = ScrollController();
  VendorsResponseModel vendorsResponseModel = VendorsResponseModel();
  DealsOfTheDayResponseModel shopWithUsResponseModel =
      DealsOfTheDayResponseModel();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    scrollController.addListener(() {
      _scrollListener();
    });
    super.onInit();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      title = Get.arguments[argForAllVendors];
      if (title == strPopularVendors) {
        getVendorsData();
        forVendors = true;
      } else if (title == strShopWithUs){
        getShopWithUsData();
        forVendors = false;
      }else{
        getBestOnEcommerceData();
        forVendors = false;
      }
      update();
    }
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (page > currentPage) {
        if (title == strPopularVendors) {
          getVendorsData();
          forVendors = true;
        } else if (title == strShopWithUs){
          getShopWithUsData();
          forVendors = false;
        }else{
          getBestOnEcommerceData();
          forVendors = false;
        }
      }
      debugPrint("reach the bottom");
    }
  }

  getVendorsData() async {
    currentPage = page;
    debugPrint("page : $page");
    isLoading = page == 0 ? true : false;
    isPagination = page > 0 ? true : false;
    update();
    var requestModel = HomepageRequestModel.productBannerRequestModel(
      pagination: page
    );
    _repository.getVendorsApiCall(queryBody: requestModel).then((value) async {
      if (value != null) {
        if (page == 0) {
          vendorsResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            vendorsResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }

        if ((value?.data?.data.length ?? 0) == 10) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((vendorsProductsResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }

        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  getShopWithUsData() async {
    currentPage = page;
    debugPrint("page : $page");
    isLoading = page == 0 ? true : false;
    isPagination = page > 0 ? true : false;
    update();
    var requestModel = HomepageRequestModel.productBannerRequestModel(
      pagination: page
    );
    _repository
        .getShopWithUsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          shopWithUsResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            shopWithUsResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }

        if ((value?.data?.data.length ?? 0) == 10) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((vendorsProductsResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  getBestOnEcommerceData() async {
    currentPage = page;
    debugPrint("page : $page");
    isLoading = page == 0 ? true : false;
    isPagination = page > 0 ? true : false;
    update();
    var requestModel = HomepageRequestModel.productBannerRequestModel(
      pagination: page
    );
    _repository
        .getBestOnEcommerceApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        if (page == 0) {
          shopWithUsResponseModel = value;
        } else {
          if ((value?.data?.data.length ?? 0) != 0) {
            shopWithUsResponseModel?.data?.data
                ?.addAll(value?.data?.data ?? []);
          }
        }

        if ((value?.data?.data.length ?? 0) == 10) {
          page += 1;
        }
        isLoading = false;
        isPagination = false;
        // if ((vendorsProductsResponseModel?.data?.totalCount ?? 0) == 0) {
        //   dataNotFound = true;
        // }

        update();
      }

    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }
}
