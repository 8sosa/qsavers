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

import 'package:quantity_savers/app/modules/Details/models/response_model/product_campaigns_response_model.dart';
import '../../../core/utils/countdown_timer.dart';
import '../../../export.dart';

class ViewAllCampaignListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ProductDetailsController productDetailsController =
      Get.find<ProductDetailsController>();
  late CountdownTimer _countdownTimer;
  Map<int, String> timers = {};

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    _countdownTimer = CountdownTimer();
    productDetailsController.productCampaignsResponseModel.data
        ?.toList()
        .forEach((item) {
      _startTimer(item.startDate, item.endDate);
    });
    super.onInit();
  }

  @override
  void dispose() {
    _countdownTimer.stop();
    super.dispose();
  }

  void _startTimer(int startDateMillis, int endDateMillis) {
    _countdownTimer.start(endDateMillis, (timerText) {
      timers[endDateMillis] = timerText;
      update();
    });
  }
}
