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

import 'package:quantity_savers/app/modules/chat_module/controller/chat_history_controller.dart';

import '../../../export.dart';

class ChatHistoryScreen extends StatelessWidget {
  final controller = Get.put(ChatHistoryController());
  final themeController = Get.put(ThemeController());

  ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<ChatHistoryController>(
          init: ChatHistoryController(),
          builder: (controller) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const AssetImageWidget(iconsAppLogo),
                    title: const TextView(text: "Henceforth"),
                    trailing: Container(height: height_15,width: height_15,
                        decoration: BoxDecoration(
                            color: AppColors.appGreenColor,
                            borderRadius: BorderRadius.circular(height_15)), child:  Center(child: TextView(text: "1",textStyle: textStyleDisplaySmall().copyWith(color: Colors.white,fontSize: font_12),))),
                    subtitle: const TextView(text: "Hi"),
                  );
                });
          }),
    );
  }
}
