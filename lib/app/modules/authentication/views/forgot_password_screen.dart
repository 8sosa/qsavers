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

class ForgotPasswordScreen extends StatelessWidget {
  final controller = Get.put(ForgotPasswordController());
  final GlobalKey<FormState> forgotPasswordFormGlobalKey =
      GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.gradient1st, AppColors.gradient2nd],
            begin: Alignment.centerLeft),
      ),
      child: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                  titleFontWeight: FontWeight.w400,
                  titleFontSize: font_24,
                  titleFontFamily: 'Impact',
                  appBarTitleText: "$strApplicationName.".toUpperCase()),
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AuthenticationScreenHeading(
                          title: strForgotPassword,
                        ).paddingOnly(top: margin_30, bottom: margin_12),
                        TextView(
                            text: strForgotPasswordContent,
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            textStyle: textStyleBodyLarge()
                                .copyWith(color: Colors.grey)),
                        _form(),
                      ],
                    ),
                  ),
                  _nextButton()
                ],
              ).paddingSymmetric(horizontal: margin_20),
            );
          }),
    );
  }

  _form() => Form(
        key: forgotPasswordFormGlobalKey,
        child: _emailTextField(),
      );

  _emailTextField() => TextFieldWidget(
        hint: strEnterEmail,
        textController: controller.emailTextController,
        focusNode: controller.emailFocusNode,
        inputType: TextInputType.emailAddress,
        prefixIcon: const SizedBox(
          child: AssetSVGWidget(
            'assets/icons/emailIcon.svg',
          ),
        ).marginAll(12),
        inputAction: TextInputAction.next,
        validate: (value) => EmailValidator.validateEmail(value),
      ).paddingOnly(
        top: margin_15,
      );

  Widget _nextButton() => Container(
        margin: EdgeInsets.only(bottom: margin_12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButtonWidget(
          buttonBgColor: Colors.transparent,
          onPressed: () {
            if (forgotPasswordFormGlobalKey.currentState!.validate()) {
              controller.hitForgotPasswordApiCall();
            }
          },
          buttonText: strBtnNext.toUpperCase(),
          textColor: Colors.white,
        ),
      ).paddingOnly(top: margin_10);
}
