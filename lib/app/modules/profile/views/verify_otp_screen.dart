import '../../../export.dart';

class VerifyOtpScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> otpVerifyFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.all(margin_16),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(margin_20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(radius_12))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Get.delete<VerifyOtpController>();
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: AppColors.bottombarColor,
                          ),
                          // child: const AssetSVGWidget(
                          //   iconsClose,
                          //   color: AppColors.bottombarColor,
                          // ),
                        ),
                      ),
                      TextView(
                        text: controller.isForEmail
                            ? strVerifyYourEmailAddress
                            : strVerifyYourPhoneNumber,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font_18),
                      ),
                      _descriptionTxt(controller),
                      _otpTextFields(controller),
                      _resend(controller),
                      Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              AppColors.gradient1st,
                              AppColors.gradient2nd
                            ], begin: Alignment.centerLeft),
                            borderRadius: BorderRadius.circular(radius_12)
                          ),
                          child: MaterialButtonWidget(
                            onPressed: () {
                              controller.isForEmail ? controller.hitVerifyOtpApiCall() : controller.hitPhoneVerifyOtpApiCall();
                            },
                            buttonText: strSubmit.toUpperCase(),
                            buttonBgColor: Colors.transparent,
                            buttonTextStyle: textStyleBodyMedium().copyWith(
                              fontSize: font_14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _descriptionTxt(VerifyOtpController controller) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: controller.isForEmail
            ? "Enter the 4 code we’ve sent to you by an email to "
            : "Enter the 4 code we’ve sent to you by a SMS to ",
        style: textStyleBodyLarge().copyWith(color: Colors.grey.shade700),
        children: [
          TextSpan(
            text: controller.isForEmail
                ? "${controller.loginDataModel.email ?? ""}"
                : "${controller.loginDataModel.countryCode ?? ""} ${controller.loginDataModel.phoneNo ?? ""} ",
            style: textStyleBodyLarge().copyWith(color: Colors.black),
          ),
        ]
      ),

    ).paddingOnly(top: margin_18);
  }

  _otpTextFields(VerifyOtpController controller) => Form(
        key: otpVerifyFormGlobalKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Pinput(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          // listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(
                color: themeController.isDarkMode.value == true
                    ? Colors.white
                    : Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_12),
              border: Border.all(color: Colors.grey, width: width_1),
              color: themeController.isDarkMode.value == true
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          showCursor: true,
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
                  : Colors.white,
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
                border: Border.all(color: Colors.grey, width: width_1)),
          ),
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        ).paddingOnly(bottom: margin_20, top: margin_20),
      );

  _timerText(VerifyOtpController controller) => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
            text: strResendCodeIn,
            style: textStyleBodyLarge().copyWith(color: Colors.grey.shade700),
            children: [
              TextSpan(
                  text: controller.secondsStr.value,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.offAllNamed(AppRoutes.loginRoute),
                  style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gradient2nd,
                    // color: themeController.isDarkMode.value == true
                    //     ? Colors.grey
                    //     : Colors.black,
                    fontSize: font_12,
                  )),
            ]),
      );

  Widget _resend(VerifyOtpController controller) => Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.start.value == 0
                ? GetInkWell(
                    onTap: () {
                      (controller.isForEmail)
                          ? (controller.hitResendEmailOtpApiCall())
                          : (controller.hitResendPhoneOtpApiCall());
                    },
                    child: TextView(
                        text: strResendCode,
                        textStyle: textStyleBodyLarge().copyWith(
                            fontSize: font_13,
                            color: AppColors.gradient2nd,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline)),
                  )
                : const SizedBox(),
            controller.start.value == 0
                ? const SizedBox()
                : _timerText(controller),
          ],
        ).paddingOnly(bottom: margin_20),
      );
}
