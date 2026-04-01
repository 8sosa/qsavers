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

import 'package:quantity_savers/app/modules/Details/controllers/view_all_campaign_list_controller.dart';

import '../../../export.dart';
import '../widgets/campaign_details_widget_screen.dart';

class ViewAllCampaignListScreen extends StatelessWidget {
  final controller = Get.put(ViewAllCampaignListController());
  final themeController = Get.put(ThemeController());

  ViewAllCampaignListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllCampaignListController>(
        init: ViewAllCampaignListController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strAllCampaigns.toUpperCase(),
            ),
            body: SingleChildScrollView(
                child: CampaignDetailsWidgetScreen(
              timerText: controller.timers,
              data: controller
                  .productDetailsController.productCampaignsResponseModel.data,
            )).paddingSymmetric(vertical: margin_20, horizontal: margin_20),
          );
        });
  }
}
