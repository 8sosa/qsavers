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
import '../widgets/new_btn_widget.dart';

class SignUpScreen extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> signUpFormGlobalKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.gradient1st, AppColors.gradient2nd],
            begin: Alignment.centerLeft),
      ),
      child: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (context) {
            return Scaffold(
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
                                  _signInText(),
                                  _form(),
                                  _termOfuse(),
                                  _signupButton(),
                                  _dividerWidget(),
                                  // _signUpTerm(),
                                  _socialLogin().paddingOnly(bottom: margin_12),
                                  _signIn()
                                ],
                              ).paddingSymmetric(horizontal: margin_20),
                            ]))));
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
            fontSize: font_16,
            color: AppColors.categoriesgrey,
            fontWeight: FontWeight.w500),
      ).marginSymmetric(horizontal: margin_15);

  Widget _divider() => Divider(
        color: Colors.grey.shade300,
      );

  _signInText() => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strSignup,
              style: textStyleHeadlineLarge().copyWith(
                  fontSize: font_26,
                  color: themeController.isDarkMode == true
                      ? Colors.black
                      : Colors.black,
                  fontWeight: FontWeight.w700),
            ).paddingOnly(bottom: margin_8),
            Text(
              strSignupContent,
              style: textStyleBodyLarge().copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: font_15),
              textAlign: TextAlign.start,
            )
          ],
        ).paddingSymmetric(vertical: margin_30),
      );

  _form() => Form(
        key: signUpFormGlobalKey,
        child: Column(
          children: [
            _nameTextField(),
            _emailTextField(),
            _phoneNumberField(),
            _passwordTextField(),
             _confirmPasswordTextField(),
          ],
        ).paddingOnly(top: margin_4, bottom: margin_10),
      );

  _nameTextField() => TextFieldWidget(
        hint: strEnterName,
        textController: controller.nameTextController,
        focusNode: controller.nameFocusNode,
        borderColor: AppColors.textfieldborder,
        maxLength: 50,
        prefixIcon: const AssetSVGWidget(
          iconsUser,
          imageHeight: 4,
          imageWidth: 4,
          color: AppColors.gradient2nd,
        ).marginAll(margin_13),
        inputType: TextInputType.text,
        formatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strFieldRequired),
      ).paddingOnly(bottom: margin_15);

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

  _phoneNumberField() => CountryPickerTextField(
        showCountryFlag: true,
        hintText: strPhoneNumber,
        onCountryChanged: null,
        selectedCountry: controller.selectedCountry,
        controller: controller.mobileNumberTextController,
      ).paddingOnly(bottom: margin_16);

  _passwordTextField() => TextFieldWidget(
        hint: strSetPassword,
        textController: controller.passwordTextController,
        focusNode: controller.passwordFocusNode,
        inputType: TextInputType.visiblePassword,
        prefixIcon: const SizedBox(
          child: AssetSVGWidget(
            iconsLockIcon,
            color: AppColors.gradient2nd,
          ),
        ).marginAll(margin_13),
        obscureText: controller.viewPassword.value,
        formatter: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        validate: (value) =>
            PasswordFormValidator.validatePassword(value, false),
        onFieldSubmitted: (v) {
          FocusScope.of(Get.overlayContext!)
              .requestFocus(controller.confirmPasswordFocusNode);
        },
        suffixIcon: GetInkWell(
          onTap: () {
            controller.viewPassword.value = !controller.viewPassword.value;
            controller.update();
          },
          child: Icon(
            controller.viewPassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: margin_4, horizontal: margin_4),
        ),
        inputAction: TextInputAction.done,
      ).paddingOnly(bottom: margin_15);


  _confirmPasswordTextField() => TextFieldWidget(
    hint: strConfirmPassword,
    textController: controller.confirmPasswordTextController,
    focusNode: controller.confirmPasswordFocusNode,
    inputType: TextInputType.visiblePassword,
    prefixIcon: const SizedBox(
      child: AssetSVGWidget(
        iconsLockIcon,
        color: AppColors.gradient2nd,
      ),
    ).marginAll(margin_13),
    obscureText: controller. confirmViewPassword.value,
    formatter: [
      FilteringTextInputFormatter.deny(RegExp(r'\s')),
    ],
    validate: (value) {
      if (value == null || value.isEmpty) {
        return 'Confirm Password cannot be empty';
      }
      if (value != controller.passwordTextController.text) {
        return 'Passwords do not match';
      }
      return null;
    },
    onFieldSubmitted: (v) {
      FocusScope.of(Get.overlayContext!)
          .requestFocus(controller.confirmPasswordFocusNode);
    },
    suffixIcon: GetInkWell(
      onTap: () {
        controller. confirmViewPassword.value = !controller. confirmViewPassword.value;
        controller.update();
      },
      child: Icon(
        controller. confirmViewPassword.value
            ? Icons.visibility_off
            : Icons.visibility,
        color: AppColors.greyColor,
      ).paddingSymmetric(vertical: margin_4, horizontal: margin_4),
    ),
    inputAction: TextInputAction.done,
  ).paddingOnly(bottom: margin_15);

  Widget _signupButton() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButtonWidget(
          buttonBgColor: Colors.transparent,
          onPressed: () {
            if (signUpFormGlobalKey.currentState!.validate()) {
              controller.isTermsAccepted = true;
              controller.update();
              controller.validateData();
            }
          },
          buttonText: strSignUp.toUpperCase(),
          buttonTextStyle: textStyleBodyMedium().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: font_14,
              color: Colors.white),
          textColor: Colors.white,
        ),
      ).paddingOnly(top: margin_15);

  Widget _signIn() => Text.rich(
        TextSpan(
            text: strAlreadyAccount,
            style: textStyleTitleSmall().copyWith(
              color: themeController.isDarkMode.value == true
                  ? Colors.grey.shade600
                  : Colors.grey.shade600,
            ),
            children: [
              TextSpan(
                  text: strSignIn,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.offAllNamed(AppRoutes.loginRoute),
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradient2nd)),
            ]),
      ).paddingOnly(bottom: margin_20);

  Widget _termOfuse() => Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
          text: strAgree,
          style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
          children: [
            TextSpan(
                text: strTermOfUse,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // controller.launchUrlE(true);
                    Get.toNamed(AppRoutes.termsAndConditions,
                        arguments: {argTitle: "Terms & Condition"});
                  },
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.gradient2nd,
                    color: AppColors.gradient2nd)),
            TextSpan(
              text: strand,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
            ),
            TextSpan(
                text: strPolicy,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.privacyPolicy,
                        arguments: {argTitle: "Privacy Policy"});
                    // controller.launchUrlE(false);
                  },
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.gradient2nd,
                    color: AppColors.gradient2nd)),
          ])).paddingOnly(bottom: margin_26);

  Widget _signUpTerm() => Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
          text: strSignAgree,
          style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
          children: [
            TextSpan(
                text: strTermOfUse,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // controller.launchUrlE(true);
                    Get.toNamed(AppRoutes.termsAndConditions,
                        arguments: {argTitle: "Terms & Condition"});
                  },
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.gradient2nd,
                    color: AppColors.gradient2nd)),
            TextSpan(
              text: strand,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
            ),
            TextSpan(
                text: strPolicy,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(AppRoutes.privacyPolicy,
                        arguments: {argTitle: "Privacy Policy"});
                    // controller.launchUrlE(false);
                  },
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.gradient2nd,
                    color: AppColors.gradient2nd)),
          ])).paddingOnly(bottom: margin_26);

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
}
