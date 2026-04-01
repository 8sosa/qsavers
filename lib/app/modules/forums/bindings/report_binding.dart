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

import 'package:quantity_savers/app/modules/Details/controllers/delete_campaign_controller.dart';
import 'package:quantity_savers/app/modules/forums/controllers/report_controller.dart';

import '../../../export.dart';

class ReportMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportMemberController>(
          () => ReportMemberController(),
    );
  }
}
