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

class OtpVerificationScreen extends StatelessWidget {
  final controller = Get.put(OtpVerificationController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> otpVerifyFormGlobalKey = GlobalKey<FormState>();

  OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
        init: OtpVerificationController(),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.gradient1st, AppColors.gradient2nd],
                  begin: Alignment.centerLeft),
            ),
            child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: " ${strApplicationName.toUpperCase()}.",
                titleFontSize: font_24,
                titleFontWeight: FontWeight.w400,
                titleFontFamily: "Impact",
                hideBackIcon: controller.logIn==true?false:true,
                onTap: ()
                {
                     controller.hitLogoutApi();
                },
                actionWidget: controller.isFromForgot
                    ? null
                    : [
                        TextButton(
                          onPressed: () {
                            (controller.vendor == "Email" &&
                                    controller.isFromForgot == false)
                                ? null
                                : controller.vendor == "Phone"
                                    ? Get.offAllNamed(
                                AppRoutes.mainScreenRoute)
                                    : Get.offAllNamed(
                                        AppRoutes.mainScreenRoute);
                            controller.update();
                          },
                          child: (controller.vendor == "Email" &&
                                  controller.isFromForgot == false)
                              ? const SizedBox()
                              : const Text(
                                  strSkip,
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        TextView(
                          text: (controller.vendor == "Email")
                              ? strVerifyMail
                              : strVerifyPhone,
                          maxLines: 3,
                          textStyle: textStyleHeadlineLarge().copyWith(
                              color: themeController.isDarkMode.value == true
                                  ? Colors.black
                                  : Colors.black,
                              fontSize: font_22,
                              fontWeight: FontWeight.w700),
                        ).paddingOnly(bottom: margin_12, top: margin_30),
                        _descriptionTxt(),
                        _otpTextFields(),
                        _resend(),
                      ],
                    ),
                  ),
                  _verifyButton(),
                ],
              ).paddingSymmetric(horizontal: margin_20),
            ),
          );
        });
  }

  _descriptionTxt() {
    return Text.rich(
      TextSpan(
          text:
              "Please check your ${controller.vendor} for a message with your code. We sent your 4 digit code to ",
          style: textStyleBodyLarge().copyWith(color: Colors.grey.shade700),
          children: [
            TextSpan(
                text:"${controller.emailTxt} ",
                // recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_12,
                    color: Colors.black)),
            // TextSpan(
            //     text: strChange,
            //     recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
            //     style: textStyleTitleSmall().copyWith(
            //         fontWeight: FontWeight.w600,
            //         fontSize: font_12,
            //         decoration: TextDecoration.underline,
            //         color: AppColors.gradient2nd)),
          ]),
    );
  }

  _otpTextFields() => Form(
        key: otpVerifyFormGlobalKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Pinput(
          errorBuilder: (String? errorText, String pin) {
            return Row(
              children: [
                Text(
                  errorText.toString(),
                  textAlign: TextAlign.start,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: font_11),
                ),
                Expanded(child: Container())
              ],
            ).paddingOnly(top: margin_10);
          },
          controller: controller.otpTextController,
          focusNode: controller.otpFocusNode,
          length: 4,
          cursor: Padding(
            padding: EdgeInsets.symmetric(vertical: margin_15),
            child: VerticalDivider(
              color: AppColors.appColor,
              thickness: margin_1point2,
            ),
          ),
          pinContentAlignment: Alignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          // listenForMultipleSmsOnAndroid: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          defaultPinTheme: PinTheme(
            width: height_56,
            height: height_56,
            textStyle: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_12),
              border: Border.all(
                  color: themeController.isDarkMode.value == true
                      ? AppColors.appBorderDarkColor
                      : AppColors.textfieldborder,
                  width: width_1),
              color: themeController.isDarkMode.value == true
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          showCursor: true,
          validator: (s) {
            debugPrint("${s!.length}");
            return ((controller.isFromEmailVerification ?? false) ||
                    ((s!.length > 3) && controller.isValidate.value))
                ? null
                : strIncorrectCode;
          },
          onChanged: (value) {
            controller.isValidate.value = true;
          },
          isCursorAnimationEnabled: true,
          disabledPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : Colors.black),
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value == true
                  ? Colors.black
                  : Colors.red,
            ),
          ),
          focusedPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : Colors.black),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_12),
                border: Border.all(
                    color: themeController.isDarkMode.value == true
                        ? AppColors.appBorderDarkColor
                        : AppColors.gradient2nd,
                    width: width_1)),
          ),
          errorPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : Colors.black),
            decoration: BoxDecoration(
                color: AppColors.backgroundRed,
                border: Border.all(color: AppColors.titleRed),
                borderRadius: BorderRadius.circular(radius_12)),
          ),
          errorTextStyle: textStyleBodyMedium().copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: font_11),
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        ).paddingOnly(bottom: margin_20, top: margin_20),
      );

  Widget _verifyButton() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButtonWidget(
          onPressed: () {
            if (otpVerifyFormGlobalKey.currentState!.validate()) {
              controller.handleApiForCorrespondingRoute();
            }
          },
          textColor: Colors.white,
          buttonText: strSubmit,
          buttonBgColor: Colors.transparent,
        ),
      ).paddingSymmetric(vertical: margin_30);

  _timerText() => Text.rich(
        TextSpan(
            text: strResendCodeIn,
            style: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.grey.shade700
                    : Colors.grey.shade700),
            children: [
              TextSpan(
                  text: controller.secondsStr.value,
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap = () => Get.offAllNamed(AppRoutes.loginRoute),
                  style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w600,
                    color: themeController.isDarkMode.value == true
                        ? Colors.grey
                        : AppColors.gradient2nd,
                    fontSize: font_12,
                  )),
            ]),
      );

  Widget _resend() => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            controller.start.value == 0
                ? GetInkWell(
                    onTap: () {
                      controller.handleResendApiForCorrespondingRoute();
                    },
                    child: TextView(
                        text: strResendCode,
                        textStyle: textStyleBodyLarge().copyWith(
                            fontSize: font_13,
                            color: themeController.isDarkMode.value == true
                                ? AppColors.gradient2nd
                                : AppColors.gradient2nd,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline)),
                  )
                : const SizedBox(),
            controller.start.value == 0 ? const SizedBox() : _timerText(),
          ],
        ).paddingOnly(top: margin_5),
      );
}
