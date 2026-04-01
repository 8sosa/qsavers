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

import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/forums/models/forums_request_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/campaign_data_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/campaign_filter_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/get_schedule_live_broad_cast_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/schedule_live_broadcast_response_model.dart';
import 'package:quantity_savers/app/modules/live_streaming/agora_token_request_model.dart';

import '../../../export.dart';
import '../models/filter_campaign_model.dart';



class ViewAllCampaignsController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage localStorage = Get.find<LocalStorage>();

  String title = strCampaigns;
  var isFromTabbar = true;
  bool isLoading = false;
  CampaignDataResponseModel campaignDataResponseModel =
      CampaignDataResponseModel();
  CampaignFilterResponseModel campaignFilterResponseModel =CampaignFilterResponseModel();
  ScheduleLiveBroadCastResponseModel scheduleLiveBroadCastResponseModel =ScheduleLiveBroadCastResponseModel();
  AgoraTokenRequestModel agoraTokenRequestModel = AgoraTokenRequestModel();
  GetScheduleLiveBroadCastResponseModel getScheduleLiveBroadCastResponseModel = GetScheduleLiveBroadCastResponseModel();

  FilterCampaignData? filterParameters;
  bool isLoadedOnce = true;
  int categoryIndex = -1;
  int minPrice = 0;
  int maxPrice = 1000;
  int ratingIndex = -1;
  int streamingIndex = -1;
  int initialPrice = 1000;
  int sellerIndex = -1;
  var loadfilterdData=false;
  bool filter =false;
  bool sorted = true;
  dynamic userLoggedInId = "";
  int subsubCategoryIndex=-1;
  int brandIndex=-1;
  int discountIndex=-1;

  var sortByElement = [
    "All",
    "What’s New",
    "Popular",
    "Price High to Low",
    "Price to Low to High"
  ];
  RxInt bottomSheetSelectedIndex = 0.obs;

  onSelectSortByItem(int index) async {
    bottomSheetSelectedIndex.value = index;
    if (index == 0) {
      getAllCampaignsData();
    } else if (index == 1) {
      getAllCampaignsData();
    } else if (index == 2) {
      getAllCampaignsData('POPULAR');
    } else if (index == 3) {
      getAllCampaignsData('PRICE_HIGH_TO_LOW');
    } else if (index == 4) {
      getAllCampaignsData('PRICE_LOW_TO_HIGH');
    }
    update();
  }
  void getLoggedInUserId() async {
    LoginDataModel userInfo = await localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    update();
  }
  Future<void> refreshList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getAllCampaignsData();
  }
  @override
  void onInit() {
    filterParameters = filterSelectctedData;
    getLoggedInUserId();
    loadfilterdData=false;
    var tokeen = localStorage.getAuthToken();
    debugPrint("tokn is $tokeen");
    (tokeen==null) ? null :   hitGetLiveBroadCastData();
    if (Get.arguments != null) {
      if (Get.arguments[argTitle] != null) {
        title = Get.arguments[argTitle];
        isFromTabbar = false;
      }
    }
    lightTheme(color: AppColors.appColor);
    getAllCampaignsData();
    super.onInit();
  }

  getAllCampaignsData([String? sort]) {

    isLoading = true;
    Map<String, dynamic>? requestModel =
        DetailsRequestModel.viewAllRequestModel(sortBy: sort);
    _apiRepository
        .getAllCampaignsData(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        print('yes');
        isLoading = false;
        campaignDataResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  bool handleBackButton()
  {
    if (localStorage.getAuthToken() == null) {

      return true;
    }
    else {
      return false;
    }
  }

  bool handleWishlist(dynamic data, bool? inWishlist) {
    if (localStorage.getAuthToken() == null) {
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
        //productDetailsResponseModel.data?.wishlist = !(productDetailsResponseModel.data?.wishlist ?? false);
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
      campaign_id: data,
    );
    _apiRepository
        .addProductToWishlistApiCall(queryBody: requestModel).then((value) {
          if(value!=null)
            {
              showToast(message: "Campaign added to wishlist");
            }
    })
        .onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitDeleteFromWishlistApi(dynamic data) {
    _apiRepository
        .removeProductFromWishlistApiCall(productId: data).then((value) {
      if(value!=null)
      {
        showToast(message: "Campaign removed to wishlist");
      }
    })
        .onError((error, stackTrace) => showToast(message: error.toString()));
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
    filter =  filterParameters?.isFilterApply ?? true;
  }

  void hitGetCampaignFilteredApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
    HomepageRequestModel.filteredProductsDetailsRequestModel(
      categoryId: filterParameters?.categoryId,
        minPrice: filterParameters?.lowestPrice,
        maxPrice: filterParameters?.highestPrice,
        selectedRating: filterParameters?.selectedRating,
        isLive:filterParameters?.isLive ,
        sortBy: "",
        brandId: filterParameters?.brandId,
        discount: filterParameters?.selectedDiscount,
        sellerID: filterParameters?.sellerId);
    _apiRepository.getCampaignFiltersApi(queryBody: requestModel).then(
          (value) {
            debugPrint("RequestModel is $requestModel");
        if (value != null) {
          campaignFilterResponseModel = value;
          isLoading = false;
          loadfilterdData=true;
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

  hitScheduleBroadCast(String id,String date,String time) {
    isLoading = true;
    Map<String, dynamic> requestModel =
    ForumsRequestModel.scheduleLiveBroadCastRequestModel(date:date ,time:time);

    _apiRepository
        .scheduleLiveBroadCastApiCall(dataBody: requestModel,id: id)
        .then((value) async {
      if (value != null) {
        scheduleLiveBroadCastResponseModel=value;
        showToast(message: scheduleLiveBroadCastResponseModel.message.toString());

        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });

  }

  hitGetLiveBroadCastData() {

    isLoading = true;
    _apiRepository.getscheduleLiveApiCall().then((value) {
      if (value != null) {
        getScheduleLiveBroadCastResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitStartLiveSocket(String Id, String type) {
    Map<String, dynamic> requestModel =
    ForumsRequestModel.startLiveRequestModel(id: Id);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: startLiveEvent);
    getAgoraToken(Id, type);
  }

  getAgoraToken(String Id, String type)
  {
    isLoading = true;
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.agoraTokenRequestModel(campaignId:Id ,type:type );
    _apiRepository.getAgoraTokenApiCall(queryBody: requestModel).then((value) {
      if(value!=null)
        {
          agoraTokenRequestModel=value;
          isLoading = false;
          Get.toNamed(AppRoutes.liveStreamingRoute,
              arguments: {
                argCampaignId:agoraTokenRequestModel.data?.campaignDetail?.sId,
                argCreatedById:agoraTokenRequestModel.data?.campaignDetail?.createdBy?.sId,
                argToken:agoraTokenRequestModel.data?.token,
                argChannelName:agoraTokenRequestModel.data?.channelName,
                argCampaignName:agoraTokenRequestModel.data?.campaignDetail?.campaignName,
                argCreatorName:agoraTokenRequestModel.data?.campaignDetail?.createdBy?.name,
                argProfilePic:agoraTokenRequestModel.data?.campaignDetail?.createdBy?.profilePic,
                argProductImage:agoraTokenRequestModel.data?.campaignDetail?.productId?.images?[0]
              });
          update();
        }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

}
