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

import 'package:quantity_savers/app/core/utils/countdown_timer.dart';
import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/home/controllers/main_controller.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/bottom_banner_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/campaign_data_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/deal_of_day_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/middle_banner_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/top_banner_response_model.dart';
import '../../../core/utils/time_conversion.dart';
import '../../../export.dart';

class HomeController extends GetxController {
  Rx<MessageResponseModel> messageResponseModel = MessageResponseModel().obs;
  bool isLoading = true;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<LoginDataModel> loginDataModel = LoginDataModel().obs;
  LoginResponseModel loginResponseModel = LoginResponseModel();
  ProductBannerResponseModel productBannerResponseModel =
      ProductBannerResponseModel();
  ProductCategoriesResponseModel productCategoriesResponseModel =
      ProductCategoriesResponseModel();
  DealsOfTheDayResponseModel dealsOfTheDayResponseModel =
      DealsOfTheDayResponseModel();
  DealsOfTheDayResponseModel topDealsResponseModel =
      DealsOfTheDayResponseModel();
  DealsOfTheDayResponseModel fashionDealsResponseModel =
      DealsOfTheDayResponseModel();
  DealsOfTheDayResponseModel featuredCategoriesResponseModel =
      DealsOfTheDayResponseModel();
  DealsOfTheDayResponseModel shopWithUsResponseModel =
      DealsOfTheDayResponseModel();
  TopBannerResponseModel topBannerResponseModel = TopBannerResponseModel();
  MiddleBannerResponseModel middleBannerResponseModel = MiddleBannerResponseModel();
  BottomBannerResponseModel bottomBannerResponseModel = BottomBannerResponseModel();
  VendorsResponseModel vendorsResponseModel = VendorsResponseModel();
  DealsOfTheDayResponseModel bestOnEcommerceResponseModel =
      DealsOfTheDayResponseModel();
  CampaignDataResponseModel campaignDataResponseModel =
      CampaignDataResponseModel();
  DealOfDayTimerResponseModel dealOfDayTimerResponseModel = DealOfDayTimerResponseModel();
  LocalStorage _localStorage =LocalStorage();
  var currentIndex = 0;
  int count = 0;
  List<int> timeComponents = convertMs(1000);
  RxList<Map<int, String>> timers = <Map<int, String>>[].obs;
  RxMap<int, String> timerMap = <int, String>{}.obs;
  late CountdownTimer _countdownTimer;
  dynamic userLoggedInId = "";
  ViewAllCampaignsController? viewAllCampaignsController;
  ForumsController?forumsController;
  LocalStorage? localStorage;

  List<LineChartBarData> lineChartBarData = [
    LineChartBarData(
      color: AppColors.appColor,
      gradient: const LinearGradient(
          colors: [AppColors.appColor, AppColors.appColor, AppColors.appColor]),
      isCurved: true,
      spots: const [
        FlSpot(1, 2.5),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(12, 4),
      ],
    )
  ];

  onPageChanged(int index) async {
    currentIndex = index;
    update();
  }
  void getLoggedInUserId() async {
    LoginDataModel userInfo = await _localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    update();
  }
  @override
  void onInit() {
    if (Get.isRegistered<ForumsController>()) {
      forumsController = Get.find<ForumsController>();
    } else {
      Get.put(ForumsController());
    }
    forumsController?.onInit();
    getLoggedInUserId();
    _countdownTimer = CountdownTimer();
    loadData();
    super.onInit();
  }

  @override
  void onReady() {
   dynamicLinkingController.listenDeepLinkData();
    super.onReady();
  }

  void loadData() {
    _getBannersData();
    _getMiddleBannerData();
    _getBottomBannerData();
    _getProductCategoriesData();
    _getDealOfTheTimerData();
    _getDealsOfTheDayData();
    _getCampaignsData();
    _getTopDealsData();
    _getFashionDealsData();
    _getFeaturedCategoriesData();
    _getShopWithUsData();
    _getVendorsData();
    _getBestOnEcommerceData();
    localStorage?.getAuthToken()==null?null:hitProfileApiCall();

  }

  hitProfileApiCall() {
    Map<String, dynamic> requestModel =
    AuthRequestModel.getProfileRequestModel();
    _apiRepository.getProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        unreadCount.value=loginResponseModel.data?.unreadMessageCount ?? 0;
        await saveDataToLocalStorage(loginResponseModel.data);
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  saveDataToLocalStorage(LoginDataModel? loginDataModel) async {
    await _localStorage?.saveRegisterData(loginDataModel);
  }

  Future<void> _getBannersData() async {
    var requestModel = HomepageRequestModel.topBannerRequestModel();
    await _apiRepository
        .getBannerProductsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        topBannerResponseModel = value;
        debugPrint("Total count is ${topBannerResponseModel.data?.totalCount}");
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  Future<void> _getMiddleBannerData() async {
    var requestModel = HomepageRequestModel.middleBannerRequestModel();
    await _apiRepository
        .getMiddleBannerProductsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        middleBannerResponseModel = value;
        debugPrint("Total count is ${middleBannerResponseModel.data?.totalCount}");
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  Future<void> _getBottomBannerData() async {
    var requestModel = HomepageRequestModel.bottomBannerRequestModel();
    await _apiRepository
        .getBottomBannerProductsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        bottomBannerResponseModel = value;
        debugPrint("Total count is ${bottomBannerResponseModel.data?.totalCount}");
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  Future<void> _getProductCategoriesData() async {
    var requestModel = HomepageRequestModel.productCategoriesRequestModel();
    _apiRepository
        .getProductCategoriesApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {

        productCategoriesResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  Future<void> _getDealsOfTheDayData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getDealsOfTheDayApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        dealsOfTheDayResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getDealOfTheTimerData() async {

    _apiRepository
        .getDealsOfTheDayTimerApiCall()
        .then((value) async {
      if (value != null) {
        dealOfDayTimerResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getCampaignsData() async {
    _apiRepository.getAllCampaignsData(queryBody: {}).then((value) async {
      if (value != null) {
        campaignDataResponseModel = value;
        campaignDataResponseModel.data?.data?.toList().forEach((item) {
          debugPrint('count value is $count');
          _startTimer(item.startDate, item.endDate, count);
          count++;
        });
        update();
      } else {}
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getTopDealsData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getTopDealsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        topDealsResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getFashionDealsData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getFashionDealsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        fashionDealsResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getFeaturedCategoriesData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getFeaturedCategoriesApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        featuredCategoriesResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getShopWithUsData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getShopWithUsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        shopWithUsResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getVendorsData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getVendorsApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        vendorsResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> _getBestOnEcommerceData() async {
    var requestModel = HomepageRequestModel.productBannerRequestModel();
    _apiRepository
        .getBestOnEcommerceApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        bestOnEcommerceResponseModel = value;
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (Get.isRegistered<ViewAllCampaignsController>()) {
      viewAllCampaignsController = Get.find<ViewAllCampaignsController>();
    }
    viewAllCampaignsController?.getAllCampaignsData();
    loadData();
  }

// getProfileData() async {
//   _LocalStorage.getSavedLoginData().then((value) {
//     if (value != null) {
//       loginDataModel = value;
//     }
//   }).onError((error, stackTrace) {
//     customLoader.hide();
//     showToast(message: error.toString());
//   });
// }

  @override
  void dispose() {
    _countdownTimer.stop();
    super.dispose();
  }

  // void _startTimer(int startDateMillis, int endDateMillis,int uniqueID) {
  //   debugPrint('unique id is $uniqueID');
  //   _countdownTimer.start(endDateMillis, (timerText) {
  //     timerMap[endDateMillis]=timerText;
  //     timers[uniqueID] = timerMap;
  //     debugPrint('Timer MAp is ${timerMap[endDateMillis]}');
  //     debugPrint('Timer for campaign $uniqueID is ${timers[uniqueID]}');
  //     update();
  //   });
  // }
  void _startTimer(int startDateMillis, int endDateMillis, int uniqueID) {
    _countdownTimer.start(endDateMillis, (timerText) {
      var timerMap = {endDateMillis: timerText.toString()};
      if (timers.length > uniqueID) {
        timers[uniqueID] = timerMap;
      } else {
        timers.add(timerMap);
      }
      update();
    });
  }

  handleNotifications(int index) {
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
    else {
      Get.toNamed(AppRoutes.campaignDetailsScreenRoute, arguments: {
        argCampaignId:
            campaignDataResponseModel.data?.data?[index].sId,
        argForOngoing: false,
        argForHome: true
      });
    }
  }

}
