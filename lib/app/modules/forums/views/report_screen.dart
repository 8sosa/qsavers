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

class ReportMember extends StatelessWidget {
  final controller = Get.put(ReportMemberController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> reportMemberFormGlobalKey =
  GlobalKey<FormState>();

  ReportMember({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportMemberController>(
        init: ReportMemberController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strReportMember.toUpperCase(),
              isBottomWidget: false,
            ),
            body: Column(
              children: [
                Expanded(
                    child: Form(
                      key: reportMemberFormGlobalKey,
                      child: ListView(
                        children: [
                          SizedBox(height: margin_20),
                          _requiredTitle(title: strReasonReport),
                          TextFieldWidget(
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            validate: (value) => FieldChecker.fieldChecker(
                                value: value, message: strFieldRequired),
                            maxLines: 8,
                            minLine: 5,
                            textController: controller.commentEditingController,
                            focusNode: controller.commentFocusNode,
                            hint: strReasonForReportUser,
                          ).paddingOnly(top: margin_20)
                        ],
                      ).paddingSymmetric(
                          vertical: margin_20, horizontal: margin_20),
                    )),
                BottomButtonWidget(
                  onPressed: () {
                      if(reportMemberFormGlobalKey.currentState!.validate())
                        {
                             controller.hitReportMemberApi();
                        }
                  },
                  btnTitle: strSubmit,
                  isBorderColor: false,
                ),
              ],
            ),
          );
        });
  }

  _requiredTitle({title}) => Row(
    children: [
      TextView(
        text: title,
        textStyle: textStyleBodyMedium()
            .copyWith(fontSize: font_14, fontWeight: FontWeight.w400),
      ),
      TextView(
        text: "*",
        textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_14,
            fontWeight: FontWeight.w500,
            color: Colors.redAccent),
      ),
    ],
  );
}
