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
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/core/values/socket_events.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/campaign_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_members_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/forums_request_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/get_schedule_live_broad_cast_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/schedule_live_broadcast_response_model.dart';
import 'package:quantity_savers/app/modules/live_streaming/agora_token_request_model.dart';
import '../../../export.dart';

class CampaignDetailsController extends GetxController
    with GetTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  TabController? tabController;
  String campaignId = "";
  bool isLoading = false;
  String loggedInUserId = "";
  bool creatorCampaign = false;
  bool completedCampaign = false;
  bool failedCampaign = false;
  bool customerFailed = false;
  bool cancelledCampaign = false;
  bool joinedCampaign = false;
  bool isRouteForHome = false;
  bool isRouteForViewAllCampaign = false;
  bool customerCampaign = false;
  bool isRouteForCustomerCompleted = false;
  bool isRouteForCustomerExited = false;
  bool isRouteForCustomerCancelled = false;
  bool isRouteForOrderPlacedScreen = false;
  bool isForSearchScreen = false;
  bool isForWishList = false;
  List<int> timeComponents = convertMs(1000);
  CampaignDetailsResponseModel campaignDetailsResponseModel =
      CampaignDetailsResponseModel();
  CheckOutResponceModel? checkOutResponseModel = CheckOutResponceModel();
  CampaignGroupMembersResponseModel campaignGroupMembersResponseModel =
      CampaignGroupMembersResponseModel();
  int membersTabIndex = 0;
  late CountdownTimer _countdownTimer;
  dynamic userLoggedInId ="";
  RxMap<int, String> timers = <int, String>{}.obs;
  AgoraTokenRequestModel agoraTokenRequestModel =AgoraTokenRequestModel();
  GetScheduleLiveBroadCastResponseModel getScheduleLiveBroadCastResponseModel = GetScheduleLiveBroadCastResponseModel();
  ScheduleLiveBroadCastResponseModel scheduleLiveBroadCastResponseModel = ScheduleLiveBroadCastResponseModel();

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    _countdownTimer = CountdownTimer();
    tabController = TabController(vsync: this, length: 2);
    getArguments();
    getLoggedInUserId();
    hitGetCampaignDetailsApiCall();
    hitGetCampaignMembersApiCall();
    hitGetLiveBroadCastData();
    super.onInit();
  }

  void getLoggedInUserId() async {
    var userInfo = await _localStorage.getSavedLoginData();
    userLoggedInId = userInfo.sId;
    update();
  }

  getArguments() {
    if (Get.arguments != null) {
      if(Get.arguments[argLiveStream]==true)
        {
          campaignId=Get.arguments[argCampaignId] ?? "";
        }
      else
        {
          creatorCampaign = Get.arguments[argForOngoing] ?? false;
          campaignId = Get.arguments[argCampaignId] ?? "";
          completedCampaign = Get.arguments[argForCompleted] ?? false;
          customerCampaign = Get.arguments[argForCustomer] ?? false;
          failedCampaign = Get.arguments[argForFailed] ?? false;
          cancelledCampaign = Get.arguments[argForCancelled] ?? false;
          joinedCampaign = Get.arguments[argForJoined] ?? false;
          customerFailed =Get.arguments[argForCustomerFailed] ?? false;
          isRouteForHome = Get.arguments[argForHome] ?? false;
          isRouteForViewAllCampaign = Get.arguments[argForViewAllCampaign] ?? false;
          isRouteForCustomerCompleted =
              Get.arguments[argForCustomerCompleted] ?? false;
          isRouteForCustomerExited = Get.arguments[argForCustomerExited] ?? false;
          isRouteForCustomerCancelled =
              Get.arguments[argForCustomerCancelled] ?? false;
          isRouteForOrderPlacedScreen =
              Get.arguments[argIsRouteForOrderPlacedScreen] ?? false;
          isForSearchScreen=Get.arguments[argSearchScreen] ?? false;
          isForWishList= Get.arguments[argForWishList] ?? false;
          debugPrint("Creator campaign ${creatorCampaign}");
        }

    }
    update();
  }


  double getDiscountPercentage() {
    final wholesalePrice = campaignDetailsResponseModel.data?.productDetails?.wholesalePrice?? 0.0;
    final price = campaignDetailsResponseModel.data?.productDetails?.price ?? 0.0;

    if (price == 0) return 0.0;

    return ((price-wholesalePrice) / price) * 100;
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

  hitGetCampaignDetailsApiCall({bool showLoader=true}) {
    if(showLoader)
      {
        isLoading = true;
      }

    Map<String, dynamic> requestModel =
        DetailsRequestModel.campaignDetailsRequestModel(id: campaignId);
    _apiRepository
        .getCampaignDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        campaignDetailsResponseModel = value;
        _startTimer(campaignDetailsResponseModel.data?.startDate,
            campaignDetailsResponseModel.data?.endDate);
        if (campaignDetailsResponseModel.data != null) {
          campaignDetailsResponseModel
              .data?.productDetails?.productVariations ??= [];

          campaignDetailsResponseModel.data?.productDetails?.productVariations
              ?.insert(
            0,
            ProductVariations(
                sId: campaignDetailsResponseModel.data?.productDetails?.sId ??
                    "",
                name: campaignDetailsResponseModel.data?.productDetails?.name ??
                    "",
                price:
                    campaignDetailsResponseModel.data?.productDetails?.price ??
                        0,
                discountPrice: campaignDetailsResponseModel
                        .data?.productDetails?.discountPrice ??
                    0.0,
                quantity: campaignDetailsResponseModel
                        .data?.productDetails?.quantity ??
                    0,
                productId:
                    campaignDetailsResponseModel.data?.productDetails?.sId ??
                        "",
                wholesaleQuntity: campaignDetailsResponseModel
                        .data?.productDetails?.wholesaleQuntity ??
                    0),
          );
        }
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  hitGetCampaignMembersApiCall() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.campaignMembersRequestModel(
            id: campaignId, type: membersTabIndex == 0 ? "JOINED" : "EXITED");
    _apiRepository
        .getCampaignMembersApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        campaignGroupMembersResponseModel = value;
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  void _startTimer(int startDateMillis, int endDateMillis) {
    _countdownTimer.start(endDateMillis, (timerText) {
      timers[endDateMillis] = timerText;
    });
  }

  hitScheduleBroadCast(String id,String date,String time) {
    isLoading = true;
    Map<String, dynamic> requestModel =
    ForumsRequestModel.scheduleLiveBroadCastRequestModel(date:date ,time:time);

    _apiRepository
        .scheduleLiveBroadCastApiCall(dataBody: requestModel,id: id)
        .then((value) async {
      if (value != null) {
        isLoading=false;
        scheduleLiveBroadCastResponseModel=value;
        showToast(message:"Scheduled Successfully");

        update();
      }
    }).onError((error, stackTrace) {
      isLoading=false;
      showToast(message: error.toString());
    });

  }

  hitStartLiveSocket(String id, String type) {
    Map<String, dynamic> requestModel =
    ForumsRequestModel.startLiveRequestModel(id: id);
    socketIOManager?.emitEvent(
        dataBody: requestModel, eventName: startLiveEvent);
    getAgoraToken(id, type);
  }

  getAgoraToken(String id, String type)
  {
    isLoading = true;
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.agoraTokenRequestModel(campaignId:id ,type:type );
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
