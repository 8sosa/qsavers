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

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  var themeController = Get.put(ThemeController());

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [AppColors.gradient1st, AppColors.gradient2nd])),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const AssetSVGWidget(iconsAppBarback),
        ),
        centerTitle: true,
        title: Text(
          strChangePassword.toUpperCase(),
          style: TextStyle(fontSize: font_16, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(margin_20),
            child: InkWell(
              onTap: (){
                if(controller.isSetPassWord.value==true)
                  {
                    if(changePasswordFormKey.currentState!.validate())
                      if(controller.newPasswordTextController.text==controller.confirmPasswordTextController.text)
                      {
                        controller.hitChangePasswordApiCall();
                      }
                      else
                      {
                        showToast(message: "New Password and confirm Password are not same");
                      }
                  }
                if(controller.isSetPassWord.value==false)
                  {
                    if(changePasswordFormKey.currentState!.validate())
                      {
                        if(controller.newPasswordTextController.text==controller.confirmPasswordTextController.text)
                        {
                          controller.hitSetPasswordApiCall();
                        }
                        else
                        {
                          showToast(message: "Password and confirm Password are not same");
                        }
                      }
                  }


              },
              child: Obx(()=>
                EditProfileBtnWidget(
                  btnName: controller.isSetPassWord.value==true?"UPDATE PASSWORD":"SET PASSWORD",
                )),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: _form(),
      ),
    );
  }

  _form() => Form(
        key: changePasswordFormKey,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(controller.isSetPassWord.value==true)...[
                Text(
                  strCurrentPassword,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(bottom: margin_8),
                _oldPasswordTextField(),
                Text(
                  strNewPassword,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(bottom: margin_8, top: margin_16),
                _newPasswordTextField(),
                Text(
                  strConfirmPassword,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(bottom: margin_8, top: margin_16),
                _confirmPasswordTextField(),
              ],
              if(controller.isSetPassWord.value==false)...[
                Text(
                  strSetPassword,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(bottom: margin_8,),
                _newPasswordTextField(),
                Text(
                  strConfirmPassword,
                  style: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: font_14),
                ).paddingOnly(bottom: margin_8, top: margin_16),
                _confirmPasswordTextField(),
              ]

            ],
          ).paddingOnly(top: margin_30, bottom: margin_10),
        ),
      ).paddingSymmetric(horizontal: margin_20);

  _newPasswordTextField() => TextFieldWidget(
        hint:controller.isSetPassWord.value==true? strEnterNewPassword:"Enter password",
        textController: controller.newPasswordTextController,
        focusNode: controller.newPasswordFocusNode,
        inputType: TextInputType.visiblePassword,
        obscureText: controller.viewPassword.value,
        validate: (value) => PasswordFormValidator.validatePassword(value, false),
        suffixIcon: GetInkWell(
          onTap: () =>
              controller.viewPassword.value = !controller.viewPassword.value,
          child: Icon(
            controller.viewPassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
        ),
        inputAction: TextInputAction.next,
      );

  _confirmPasswordTextField() => TextFieldWidget(
    hint: "Enter confirm Password",
    textController: controller.confirmPasswordTextController,
    focusNode: controller.confirmFocus,
    inputType: TextInputType.visiblePassword,
    inputAction:TextInputAction.done,
    obscureText: controller.confirmPassword.value,
    validate: (value) {
      if (value == null || value.isEmpty) {
        return 'Confirm Password cannot be empty';
      }
      if (value != controller.confirmPasswordTextController.text) {
        return 'Passwords do not match';
      }
      return null;
    },
    suffixIcon: GetInkWell(
      onTap: () =>
      controller.confirmPassword.value = !controller.confirmPassword.value,
      child: Icon(
        controller.confirmPassword.value
            ? Icons.visibility_off
            : Icons.visibility,
        color: AppColors.greyColor,
      ).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
    ),
  );

  _oldPasswordTextField() => TextFieldWidget(
        hint: strEnterCurrentPassWord,
        textController: controller.oldPasswordTextController,
        focusNode: controller.confirmPasswordFocusNode,
        inputType: TextInputType.visiblePassword,
        validate: (value) => PasswordFormValidator.validatePassword(value, true),
        obscureText: controller.oldViewPassword.value,
        suffixIcon: GetInkWell(
          onTap: () {
            controller.oldViewPassword.value =
                !controller.oldViewPassword.value;
          },
          child: Icon(
            controller.oldViewPassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.greyColor,
          ).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
        ),
        inputAction: TextInputAction.done,
      ).paddingOnly(bottom: margin_5);
}
