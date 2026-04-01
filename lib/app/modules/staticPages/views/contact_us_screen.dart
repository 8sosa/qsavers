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

class ContactUsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ContactUsController());

  ContactUsScreen({super.key});

  final GlobalKey<FormState> contactUsFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
        init: ContactUsController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(appBarTitleText: strContactUs.toUpperCase()),
              body: _contactUsForm());
        });
  }

  _contactUsForm() => Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(margin_20),
              child: Form(
                key: contactUsFormGlobalKey,
                child: ListView(
                  children: [
                    _nameTextField(),
                    _emailTextField(),
                    _phoneNumberField(),
                    _messageTextField()
                  ],
                ),
              ),
            ),
          ),
          BottomButtonWidget(
              onPressed: () {
                if (contactUsFormGlobalKey.currentState!.validate()) {
                  controller.hitContactUsApiCall();
                }
              },
              btnTitle: strSubmit.toUpperCase())
        ],
      );

  _nameTextField() => TextFieldWidget(
        hint: strName,
        textController: controller.nameTextController,
        focusNode: controller.nameFocusNode,
        borderColor: AppColors.textfieldborder,
        maxLength: 50,
        inputType: TextInputType.text,
        formatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
      ).paddingOnly(bottom: margin_16);

  _emailTextField() => TextFieldWidget(
        hint: strEmail,
        textController: controller.emailTextController,
        focusNode: controller.emailFocusNode,
        readOnly: true,
        inputType: TextInputType.emailAddress,
        formatter: [
          FilteringTextInputFormatter.deny(
              RegExp(r'[!#$%^&*(),?":{}|<>;/\[\]\-_]'))
        ],
        inputAction: TextInputAction.next,
        validate: (value) => EmailValidator.validateEmail(value),
      ).paddingOnly(bottom: margin_16);

  _phoneNumberField() => CountryPickerTextField(
        focusNode: controller.mobileNumberFocusNode,
        showCountryFlag: true,
        hintText: strPhoneNumber,
        onCountryChanged: null,
        selectedCountry: controller.selectedCountry,
        controller: controller.mobileNumberTextController,
      ).paddingOnly(bottom: margin_16);

  _messageTextField() => TextFieldWidget(
        hint: strMessage.toLowerCase(),
        maxLines: 10,
        minLine: 5,
        textController: controller.messageTextController,
        focusNode: controller.messageFocusNode,
        borderColor: AppColors.textfieldborder,
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
      ).paddingOnly(bottom: margin_16);
}
