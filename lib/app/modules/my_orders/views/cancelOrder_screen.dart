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

import '../../../export.dart';

class CancelOrderPlacedScreen extends StatelessWidget {
  final controller = Get.put(CancelOrdersController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> cancelOrderFormGlobalKey = GlobalKey<FormState>();

  CancelOrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelOrdersController>(
        init: CancelOrdersController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strCancelOrder.toUpperCase(),
              isBottomWidget: false,
            ),
            body: Column(
              children: [
                Expanded(
                    child: Form(
                  key: cancelOrderFormGlobalKey,
                  child: ListView(
                    children: [
                      _requiredTitle(title: strReasonForCancel),
                      _selectReasonDropDown(),
                      SizedBox(height: margin_20),
                      _requiredTitle(title: strComments),
                      TextFieldWidget(
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validate: (value) => FieldChecker.fieldChecker(
                            value: value, message: strFieldRequired),
                        focusNode: controller.commentFocusNode,
                        maxLines: 8,
                        minLine: 5,
                        hint: strEnterYourMessage,
                        textController: controller.textEditingController,
                      ).paddingOnly(top: margin_20)
                    ],
                  ),
                ).paddingSymmetric(vertical: margin_20, horizontal: margin_20)),
                BottomButtonWidget(
                  onPressed: () {
                    if (cancelOrderFormGlobalKey.currentState!.validate()) {
                      controller.hitCancelOrderApi();
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
        onFieldSubmitted: (value) {
          controller.onChangeDropDownValue(value);
        },

    validate: (value) => FieldChecker.fieldChecker(
        value: value, message: strFieldRequired),
        hint: strSelectReason,
        hintStyle: textStyleLabelLarge().copyWith(
            color: AppColors.categoriesgrey,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.items,
        selectedValue: controller.selectedValue?.value,
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
