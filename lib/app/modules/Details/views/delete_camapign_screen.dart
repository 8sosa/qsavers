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

import '../../../export.dart';

class DeleteCampaignScreen extends StatelessWidget {
  final controller = Get.put(DeleteCampaignController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> deleteCampaignFormGlobalKey =
      GlobalKey<FormState>();

  DeleteCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteCampaignController>(
        init: DeleteCampaignController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strDeleteCampaign.toUpperCase(),
              isBottomWidget: false,
            ),
            body: Column(
              children: [
                Expanded(
                    child: Form(
                  key: deleteCampaignFormGlobalKey,
                  child: ListView(
                    children: [
                      _requiredTitle(title: strReasonForDelete),
                      _selectReasonDropDown(),
                      SizedBox(height: margin_20),
                      _requiredTitle(title: strComments),
                      TextFieldWidget(
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validate: (value) => FieldChecker.fieldChecker(
                            value: value, message: strFieldRequired),
                        textController: controller.commentEditingController,
                        focusNode: controller.commentFocusNode,
                        maxLines: 8,
                        minLine: 5,
                        hint: strItemsNotRequiredAnymore,
                      ).paddingOnly(top: margin_20)
                    ],
                  ).paddingSymmetric(
                      vertical: margin_20, horizontal: margin_20),
                )),
                BottomButtonWidget(
                  onPressed: () {
                    if (deleteCampaignFormGlobalKey.currentState!.validate()) {
                      controller.hitDeleteCampaignRequestApi();
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

  Widget tittleView() => Center(
          child: Column(
        children: [
          const AssetSVGWidget(iconsConfirmedplaced),
          TextView(
            text: strDeliveryStatus,
            textStyle: textStyleBodyMedium()
                .copyWith(fontSize: font_14, fontWeight: FontWeight.w500),
          ).paddingOnly(top: margin_12),
          TextView(
            text: strSuccessFullyJoined,
            textStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w400,
                fontSize: font_14,
                color: AppColors.categoriesgrey),
          ),
        ],
      ));

  _selectReasonDropDown() => DropDownTextFieldWidget(
        borderColor: AppColors.borderColor,
      validate: (value) => FieldChecker.fieldChecker(
          value: value, message: strFieldRequired),
        onFieldSubmitted: (value) {
          controller.onChangeDropDownValue(value);
        },
        hint: strSelectReason,
        hintStyle: textStyleLabelLarge().copyWith(
            color: AppColors.categoriesgrey,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.items,
        selectedValue: controller.selectedValue,
      ).paddingOnly(top: margin_10);

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
