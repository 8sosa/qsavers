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

class SubmitFormScreen extends StatelessWidget {
  final controller=Get.put(SubmitFormController());
  final GlobalKey<FormState> contactUsFormGlobalKey = GlobalKey<FormState>();

  SubmitFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitFormController>(
      init: SubmitFormController(),
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            isCustom:true,
            appBarTitleText: "Submit form",
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: customButton(buttonText: "Submit",onTap: (){
            Get.back();
          }),
          body:  _form(),
        );
      }
    );
  }

  _form() => Form(
    key: contactUsFormGlobalKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: SingleChildScrollView(
      child: Column(
        children: [
          _nameTextField(),
          _emailTextField(),
          _subjectTextField(),
          _messageTextField(),
        ],
      ).paddingOnly(top: margin_20, bottom: margin_10),
    ),
  ).paddingSymmetric(horizontal: margin_20,vertical: margin_15);

  _nameTextField() => TextFieldWidget(
    hint: "Enter name",
    textController: controller.nameTextController,
    focusNode: controller.nameFocusNode,
    inputType: TextInputType.name,
    readOnly: true,
    validate: (String? value) {
      return FieldChecker.fieldChecker(
          value: value?.trim() ?? "", message: "Name");
    },
    inputAction: TextInputAction.next,
  ).paddingOnly(bottom: margin_15);

  _emailTextField() => TextFieldWidget(
    hint: "Enter email",
    textController: controller.emailTextController,
    focusNode: controller.emailFocusNode,
    inputType: TextInputType.emailAddress,
    readOnly: true,
    validate: (value) => EmailValidator.validateEmail(value),
    inputAction: TextInputAction.next,
  ).paddingOnly(bottom: margin_15);

  _subjectTextField() => TextFieldWidget(
    hint: "Enter subject",
    textController: controller.emailTextController,
    focusNode: controller.emailFocusNode,
    inputType: TextInputType.emailAddress,
    readOnly: true,
    validate: (value) => EmailValidator.validateEmail(value),
    inputAction: TextInputAction.next,
  ).paddingOnly(bottom: margin_15);

  _messageTextField() => TextFieldWidget(
    hint: "Enter description here...",
    textController: controller.messageTextController,
    focusNode: controller.messageFocusNode,
    inputType: TextInputType.text,
    validate: (String? value) {
      return FieldChecker.fieldChecker(
          value: value?.trim() ?? "", message: "Message");
    },
    maxLines: 4,
    minLine: 4,
    inputAction: TextInputAction.done,
  ).paddingOnly(bottom: margin_5);



}