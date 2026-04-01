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

class SetPasswordScreen extends StatelessWidget {
  final controller = Get.put(SetPasswordController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPasswordController>(
        init: SetPasswordController(),
        builder: (controller) {
          return Scaffold(
              appBar: CustomAppBar(
                  titleFontWeight: FontWeight.w400,
                  titleFontSize: font_24,
                  titleFontFamily: 'Impact',
                  hideBackIcon: true,
                  appBarTitleText: "$strApplicationName.".toUpperCase()),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _titleText(),
                        _form(),
                      ],
                    ),
                  ),
                  _updateButton(),
                ],
              ).paddingSymmetric(horizontal: margin_20));
        });
  }

  _titleText() => Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strSetNewPassword,
              style: textStyleHeadlineLarge().copyWith(
                  fontSize: font_20,
                  color: themeController.isDarkMode.value == true
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600),
            ).paddingOnly(bottom: margin_8),
            Text(
              'Set the new password for your account so you can login and access all the features.',
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.start,
            )
          ],
        ).paddingOnly(top: margin_30),
      );

  _form() => Form(
        key: formGlobalKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [_passwordTextField(), _confirmPasswordTextField()],
        ).paddingOnly(top: margin_20),
      );

  _passwordTextField() => TextFieldWidget(
        hint: strNewPassword,
        textController: controller.passwordTextController,
        focusNode: controller.passwordFocusNode,
        inputType: TextInputType.visiblePassword,
        prefixIcon: const SizedBox(
          child: AssetSVGWidget(
            'assets/icons/lockIcon.svg',
            color: AppColors.gradient2nd,
          ),
        ).marginAll(12),
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
                ? Icons.visibility
                : Icons.visibility_off,
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
            'assets/icons/lockIcon.svg',
            color: AppColors.gradient2nd,
          ),
        ).marginAll(12),
        obscureText: controller.viewConfirmPassword.value,
        formatter: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        validate: (value) {
          if (value == null || value.isEmpty) {
            return 'Confirm Password cannot be empty';
          }
          if (value != controller.passwordTextController.text) {
            return 'Password must be same';
          }
          return null;
        },
        suffixIcon: GetInkWell(
          onTap: () {
            controller.viewConfirmPassword.value =
                !controller.viewConfirmPassword.value;
            controller.update();
          },
          child: Icon(
            controller.viewConfirmPassword.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: margin_4, horizontal: margin_4),
        ),
        inputAction: TextInputAction.done,
      ).paddingOnly(bottom: margin_15);

  Widget _updateButton() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.gradient1st, AppColors.gradient2nd],
              begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: MaterialButtonWidget(
          onPressed: () {
            if (formGlobalKey.currentState!.validate() &&
                controller.passwordTextController.text.trim() ==
                    controller.confirmPasswordTextController.text.trim()) {
              controller.hitNewPasswordApiCall();
            }
          },
          buttonText: strSubmit.toUpperCase(),
          buttonBgColor: Colors.transparent,
          buttonTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ).paddingOnly(bottom: margin_15);
}
