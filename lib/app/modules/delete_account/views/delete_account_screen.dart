import "package:google_sign_in/google_sign_in.dart";

import "../../../export.dart";

class DeleteAccountScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(DeleteAccountController());
  final GlobalKey<FormState> deleteAccountFormGlobalKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormGlobalKey = GlobalKey<FormState>();

  DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountController>(
      init: DeleteAccountController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(appBarTitleText: strDeleteAccount.toUpperCase()),
          body: Column(
            children: [
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageViewController,
                children: [
                  _whyDeleteScreen(),
                  _deleteResultScreen(),
                  _accountDeletedScreen()
                ],
              )),
              BottomButtonWidget(
                btnBgColor:
                    controller.currentPageView == 2 ? AppColors.titleRed : null,
                btnTitle: controller.currentPageView == 1
                    ? strContinue.toUpperCase()
                    : controller.currentPageView == 2
                        ? strCloseAccount.toUpperCase()
                        : strOk.toUpperCase(),
                onPressed: () async {
                  if (controller.currentPageView == 1) {
                    if ((controller.selectedDeleteReasonValue) <= 2) {
                      controller.navigateToNextPage();
                    } else {
                      if (deleteAccountFormGlobalKey.currentState!.validate()) {
                        controller.navigateToNextPage();
                      }
                    }
                  } else if (controller.currentPageView == 2) {
                    if(controller.type=="GOOGLE" || controller.type=="APPLE")
                      {
                        controller.hitDeleteAccountApi();
                      }
                   else if(controller.type==null)
                     {
                       if (passwordFormGlobalKey.currentState!.validate()) {
                         controller.hitDeleteAccountApi();
                       }
                     }

                  } else {
                    await GoogleSignIn().signOut();
                    Get.offAllNamed(AppRoutes.signupRoute);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  _whyDeleteScreen() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: strWhyDeleteAccount.capitalize,
            textStyle: textStyleBodyMedium().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: font_16),
          ).paddingAll(margin_16),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: margin_6),
                child: ListView.separated(
                  itemCount: controller.deleteReasons.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: controller.deleteReasons[index]["value"],
                      groupValue: controller.selectedDeleteReasonValue,
                      onChanged: (value) {
                        controller.selectedDeleteReasonValue = value!;
                        controller.update();
                      },
                      title: TextView(
                        text: controller.deleteReasons[index]["reason"],
                        textAlign: TextAlign.start,
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_14),
                      ),
                      isThreeLine: controller.selectedDeleteReasonValue == 3 &&
                              index == 3
                          ? true
                          : false,
                      subtitle: controller.selectedDeleteReasonValue == 3 &&
                              index == 3
                          ? Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: deleteAccountFormGlobalKey,
                              child: TextFieldWidget(
                                textController:
                                    controller.otherReasonTextController,
                                focusNode: controller.otherReasonFocusNode,
                                inputType: TextInputType.text,
                                formatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z ]')),
                                ],
                                inputAction: TextInputAction.next,
                                hint: strWriteReasonHere,
                                validate: (value) => FieldChecker.fieldChecker(
                                    value: value, message: strFieldRequired),
                                maxLines: 10,
                                minLine: 5,
                              ).paddingOnly(top: margin_16, right: margin_16),
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(margin_16),
                      child: const Divider(
                        color: AppColors.textfieldborder,
                      ),
                    );
                  },
                )),
          )
        ],
      );

  Color getColor(Set<MaterialState> states) {
    return AppColors.gradientColorPrimary;
  }

  _deleteResultScreen() => Container(
        padding: EdgeInsets.all(margin_16),
        child: ListView(
          children: [
            TextView(
              text: strDeleteAccountWillDoFollowing.capitalize,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_16),
            ),
            if(controller.type=="GOOGLE" || controller.type=="APPLE")...[
              SizedBox()

            ],
           if(controller.type==null)...[
             Form(
               key: passwordFormGlobalKey,
               child: TextFieldWidget(
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
                 validate: (value) =>
                     PasswordFormValidator.deletePassword(value, false),
                 suffixIcon: GetInkWell(
                   onTap: () {
                     controller.viewPassword = !controller.viewPassword;
                     controller.update();
                   },
                   child: Icon(
                     controller.viewPassword
                         ? Icons.visibility
                         : Icons.visibility_off,
                     color: AppColors.greyColor,
                   ).paddingSymmetric(vertical: margin_4, horizontal: margin_4),
                 ),
                 inputAction: TextInputAction.done,
               ).paddingSymmetric(vertical: margin_12),
             )
  ],

            Row(
              children: [
                const AssetSVGWidget(iconsCloseRed),
                TextView(
                  text: strLogYouOut,
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.pricesColor,
                      fontWeight: FontWeight.w400,
                      fontSize: font_14),
                ).paddingSymmetric(vertical: margin_16, horizontal: margin_12),
              ],
            ),
            const Divider(
              color: AppColors.textfieldborder,
            ),
            Row(
              children: [
                const AssetSVGWidget(iconsCloseRed),
                TextView(
                  text: strDeleteAllAccountInformation,
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.pricesColor,
                      fontWeight: FontWeight.w400,
                      fontSize: font_14),
                ).paddingSymmetric(vertical: margin_16, horizontal: margin_12),
              ],
            ),
            const Divider(
              color: AppColors.textfieldborder,
            ),
          ],
        ),
      );

  _accountDeletedScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsGreenTick).paddingOnly(bottom: margin_20),
            TextView(
              text: strAccountDeleted,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_22),
            ),
            TextView(
              text: strThanksForUsingProducts,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ).paddingSymmetric(vertical: margin_16),
          ],
        ),
      );
}
