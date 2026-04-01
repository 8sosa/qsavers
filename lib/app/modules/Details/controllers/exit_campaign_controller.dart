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
import 'package:quantity_savers/app/modules/Details/models/response_model/exit_campaign_response_model.dart';

import '../../../export.dart';

class ExitCampaignController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  TextEditingController commentEditingController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();
  ExitCampaignResponseModel exitCampaignResponseModel =
      ExitCampaignResponseModel();
  bool isLoading = false;
  String campaignId = "";

  final List<String> items = [
    'I want to change address for the order',
    'Price for the product has decreased',
    'I want to convert my order to Prepaid',
    'I have changed my mind',
    'I have Purchased the product elsewhere',
    'Expected delivery time is very long'
  ];

  RxString? selectedValue = "".obs;

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      campaignId = Get.arguments[argCampaignId];
      debugPrint('campaignId is $campaignId');
    }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  hitExitCampaignApi() {
    customLoader.show(Get.context);
    Map<String, dynamic> requestModel =
        DetailsRequestModel.exitCampaignRequestModel(id: campaignId);
    _apiRepository.exitCampaignApiCall(dataBody: requestModel).then((value) async {
      customLoader.hide();
      if (value != null) {
        exitCampaignResponseModel = value;
        isLoading = false;
        debugPrint("Exit Request raised");
        showToast(message: "Campaign exited successfully");
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 3});
        update();
      }
    }).onError((error, stackTrace)
        {
          customLoader.hide();
          showToast(message: error.toString());
        });
  }

  onChangeDropDownValue(String? str) async {
    selectedValue?.value = str ?? "";
    update();
  }
}
