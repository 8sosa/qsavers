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

import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_creator_response_model.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_customer_response_model.dart';

import '../../../export.dart';

class CampaignsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _repository = Get.find<APIRepository>();

  RxString? selectedValue = "".obs;
  TabController? tabController;
  var currentIndex = 0;
  var forCustomerCampaign = true;
  bool isLoading = false;
  var Joined=0;
  var customerCompleted=0;
  var customerExited=0;
  var customerCancelled=0;
  var customerFailed=0;

  var ongoing=0;
  var createrCompleted=0;
  var createrFailed=0;
  var createrCancelled=0;
  CampaignCreatorResponseModel campaignCreatorResponseModel =
      CampaignCreatorResponseModel();
  CampaignCustomerResponseModel campaignCustomerResponseModel =
      CampaignCustomerResponseModel();
  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    tabController = TabController(vsync: this, length: forCustomerCampaign==true?5:4);

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      forCustomerCampaign = Get.arguments[argForOngoing] ?? true;
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('JOINED');
      } else {
        getCreatorCampaignList('ONGOING');
      }
      debugPrint("argForOngoing ${Get.arguments[argForOngoing] ?? true}");
      debugPrint('forCustomerCampaign $forCustomerCampaign');
      update();
    }
  }

  onTabChanged(int index) async {
    currentIndex = index;

    if (currentIndex == 0) {
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('JOINED');
      } else {
        getCreatorCampaignList('ONGOING');
        debugPrint('tabbar index is $index');
        debugPrint("OnGoing......");
      }
    } else if (currentIndex == 1) {
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('COMPLETED');
      } else {
        getCreatorCampaignList('COMPLETED');
        debugPrint('tabbar index is $index');
        debugPrint("Completed......");
      }
    } else if (currentIndex == 2) {
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('EXITED');
      } else {
        getCreatorCampaignList('FAILED');
        debugPrint('tabbar index is $index');
       debugPrint('Failed..');
      }
    }
    else if (currentIndex == 3) {
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('CANCELLED');
      } else {
        getCreatorCampaignList('CANCELLED');
        debugPrint('tabbar index is $index');
        debugPrint("Cancelled......");
      }
    }
    else if (currentIndex == 4) {
      if (forCustomerCampaign == true) {
        getCustomerCampaignList('FAILED');
      }
    }
    update();
  }

  getCreatorCampaignList(String status) {
    isLoading = true;
    debugPrint('status is $status');

    Map<String, dynamic>? requestModel =
        DetailsRequestModel.campaignCreatorRequestModel(type: status);
    _repository
        .getCreatorCampaignApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        isLoading = true;
        campaignCreatorResponseModel = value;
        if(status=='ONGOING')
          {
            ongoing=campaignCreatorResponseModel.data?.length ?? 0;
          }
        else if(status == 'COMPLETED')
          {
            createrCompleted=campaignCreatorResponseModel.data?.length ?? 0;
          }
        else if(status == 'FAILED')
        {
          createrFailed=campaignCreatorResponseModel.data?.length ?? 0;
        }
        else
        {
          createrCancelled=campaignCreatorResponseModel.data?.length ?? 0;
        }
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getCustomerCampaignList(String status) {
    isLoading = true;
    debugPrint('status iss $status');
    Map<String, dynamic>? requestModel =
        DetailsRequestModel.campaignCreatorRequestModel(type: status);
    _repository
        .getCustomerCampaignApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        isLoading = true;
        campaignCustomerResponseModel = value;
        if(status=='JOINED')
          {
            Joined=campaignCustomerResponseModel.data?.length ?? 0;
          }
        else if(status=='COMPLETED')
          {
            customerCompleted=campaignCustomerResponseModel.data?.length ?? 0;
          }
        else if(status=='EXITED')
        {
          customerExited=campaignCustomerResponseModel.data?.length ?? 0;
        }
         else if(status=="CANCELLED")
           {
             customerCancelled=campaignCustomerResponseModel.data?.length ?? 0;
           }
         else
           {
             customerFailed=campaignCustomerResponseModel.data?.length ?? 0;
           }

        update();
      } else {
        debugPrint('value is null');
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
