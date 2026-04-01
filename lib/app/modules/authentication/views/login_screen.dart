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

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../export.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> loginFormGlobalKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.gradient1st, AppColors.gradient2nd],
            begin: Alignment.centerLeft),
      ),
      child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (context) {
            return WillPopScope(
              onWillPop: ()async
              {
                Get.offAllNamed(AppRoutes.signupRoute);
                return true;
              },
              child: Scaffold(
                  appBar: CustomAppBar(
                    isLeadingPresent: false,
                    titleFontWeight: FontWeight.w400,
                    titleFontSize: font_24,
                    titleFontFamily: 'Impact',
                    appBarTitleText: "$strApplicationName.".toUpperCase(),
                    actionWidget: [
                      TextButton(
                        onPressed: () {
                          controller.loginAsGuest();
                        },
                        child: const Text(
                          strSkip,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                      child: SizedBox(
                          width: Get.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _loginText(),
                                    _form(),
                                    _rememberOrForget(),
                                    _loginButton(),
                                    _dividerWidget(),
                                    _socialLogin().paddingOnly(bottom: margin_20),
                                    _signup()
                                  ],
                                ).paddingSymmetric(horizontal: margin_20),
                              ])))),
            );
          }),
    );
  }

  Widget _dividerWidget() => Row(
        children: [
          Expanded(child: _divider()),
          _orTextView(),
          Expanded(child: _divider()),
        ],
      ).paddingSymmetric(vertical: margin_20);

  Widget _orTextView() => TextView(
        text: strOr,
        textStyle: textStyleHeadlineLarge().copyWith(
            fontSize: font_18,
            color: AppColors.categoriesgrey,
            fontWeight: FontWeight.w500),
      ).marginSymmetric(horizontal: margin_15);

  Widget _divider() => Divider(
        color: Colors.grey.shade300,
      );

  _loginText() => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: strLogin,
              textStyle: textStyleHeadlineLarge().copyWith(
                  fontSize: font_24,
                  color: themeController.isDarkMode.value == true
                      ? Colors.black
                      : Colors.black,
                  fontWeight: FontWeight.w700),
            ).paddingOnly(bottom: margin_8),
            Text(
              strLoginContent,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.start,
            )
          ],
        ).paddingOnly(top: margin_30),
      ).paddingOnly(bottom: margin_30);

  _form() => Form(
        key: loginFormGlobalKey,
        child: Column(
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ).paddingOnly(top: margin_20, bottom: margin_8),
      );

  _emailTextField() => TextFieldWidget(
        hint: strEnterEmail,
        textController: controller.emailTextController,
        focusNode: controller.emailFocusNode,
        inputType: TextInputType.emailAddress,
        formatter: [
          FilteringTextInputFormatter.deny(
            RegExp(r'[!#$%^&*(),?":{}|<>;/\[\]]'),
          )
    ],
        prefixIcon: const SizedBox(
          child: AssetSVGWidget(
            iconsEmailIcon,
            color: AppColors.gradient2nd,
          ),
        ).marginAll(margin_13),
        inputAction: TextInputAction.next,
        validate: (value) => EmailValidator.validateEmail(value),
      ).paddingOnly(bottom: margin_15);

  _passwordTextField() => TextFieldWidget(
        hint: strPassword,
        textController: controller.passwordTextController,
        focusNode: controller.passwordFocusNode,
        inputType: TextInputType.visiblePassword,
        prefixIcon: const SizedBox(
          child: AssetSVGWidget(
            'assets/icons/lockIcon.svg',
            color: AppColors.gradient2nd,
          ),
        ).marginAll(12),
        obscureText: controller.viewPassword,
        formatter: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        //validate: (value) => PasswordFormValidator.validatePassword(value),
        onFieldSubmitted: (v) {
          FocusScope.of(Get.overlayContext!)
              .requestFocus(controller.confirmPasswordFocusNode);
        },
        suffixIcon: GetInkWell(
          onTap: () {
            controller.viewPassword = !controller.viewPassword;
            controller.update();
          },
          child: Icon(
            controller.viewPassword ? Icons.visibility : Icons.visibility_off,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: margin_4, horizontal: margin_4),
        ),
        inputAction: TextInputAction.done,
      );

  _rememberOrForget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_rememberPass(), _forgotPassword()],
      ).paddingOnly(top: margin_8);

  Widget _rememberPass() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetInkWell(
            onTap: () {
              controller.enableRemember = !controller.enableRemember;
              controller.update();
            },
            child: Icon(
              controller.enableRemember
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: AppColors.greyColor,
            ),
          ),
          Text(strRemember,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600,fontSize: font_14,fontWeight: FontWeight.w500)).paddingOnly(left: 2)
        ],
      );

  _forgotPassword() => GetInkWell(
      onTap: () => Get.toNamed(AppRoutes.forgotPasswordRoute),
      child: TextView(
        text: "$strForgotPassword?",
        textStyle: textStyleBodyLarge().copyWith(
            color: themeController.isDarkMode.value == true
                ? AppColors.gradient2nd
                : AppColors.gradient2nd,
            fontWeight: FontWeight.w600,
          fontSize: font_14
            ),
      ));

  Widget _loginButton() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButtonWidget(
          buttonBgColor: Colors.transparent,
          onPressed: () {
            if (loginFormGlobalKey.currentState!.validate()) {
              controller.hitLoginApiCall();
              // Get.toNamed(AppRoutes.otpVerificationRoute);
            }
          },
          buttonText: strSignIn.toUpperCase(),
          textColor: Colors.white,
        ),
      ).paddingOnly(top: margin_26);

  Widget _socialLogin() => Column(
    children: [
      MaterialButtonWidget(
        horizontalPadding: margin_2,
        minHeight: height_14,
        buttonBgColor: AppColors.googlebtnColor,
        buttonRadius: margin_6,
        iconWidget: AssetSVGWidget(
          iconsIconGoogle,
          imageHeight: height_12,
        ).paddingOnly(left: margin_5),
        onPressed: () async {
          controller.google();
        },
        buttonText: strGoogle,
        buttonTextStyle: textStyleBodyMedium().copyWith(
            fontSize: font_16,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        // textColor: Colors.white,
      ),
      if (Platform.isIOS) ...[
        SizedBox(width: 10, height: 10),
        // MaterialButtonWidget(
        //   horizontalPadding: margin_2,
        //   minHeight: height_44,
        //   buttonBgColor: Colors.black,
        //   buttonRadius: margin_4,
        //   iconWidget: AssetSVGWidget(
        //     iconsApple,
        //     imageHeight: height_22,
        //     imageWidth: height_22,
        //   ).paddingOnly(bottom: margin_3,right: 5),
        //   onPressed: () {
        //       controller.apple();
        //   },
        //   buttonText: strApple,
        //   buttonTextStyle: textStyleBodyMedium().copyWith(
        //       fontSize: font_19,
        //       fontWeight: FontWeight.w500,
        //       color: Colors.white),
        //   // textColor: Colors.white,
        // ),
        SignInWithAppleButton(
            onPressed: () async {
              controller.apple();
            }
        )
      ]
    ],
  ).paddingOnly(bottom: margin_26);

  Widget _signup() => Text.rich(
        TextSpan(
            text: strDntHaveAccount,
            style: textStyleTitleSmall().copyWith(
              color: themeController.isDarkMode.value == true
                  ? Colors.grey
                  : AppColors.greyColor,
            ),
            children: [
              TextSpan(
                  text: strSignUp,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.offAllNamed(AppRoutes.signupRoute),
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradient2nd,
                      )),
            ]),
      ).paddingOnly(top: margin_80, bottom: margin_15);
}
