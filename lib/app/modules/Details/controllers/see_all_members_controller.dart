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

import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_members_response_model.dart';

import '../../../export.dart';
import '../models/details_request_model.dart';

class SeeAllMembersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();

  CampaignGroupMembersResponseModel campaignGroupMembersResponseModel =
      CampaignGroupMembersResponseModel();
  TabController? tabController;

  var currentIndex = 0;
  bool isLoading = false;
  String campaignId = '';

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    tabController = TabController(vsync: this, length: 2);
    getArguments();
    hitGetCampaignMembersApiCall();
    super.onInit();
  }

  onTabChanged(int index) async {
    currentIndex = index;
    hitGetCampaignMembersApiCall();
    update();
  }

  getArguments() {
    if (Get.arguments != null) {
      campaignId = Get.arguments[argCampaignId];
    }
    update();
  }

  hitGetCampaignMembersApiCall() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.campaignMembersRequestModel(
            id: campaignId, type: currentIndex == 0 ? "JOINED" : "EXITED");
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
