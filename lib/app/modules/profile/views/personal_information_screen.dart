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

import "package:quantity_savers/app/modules/profile/widgets/email_dialog.dart";

import "../../../export.dart";

class PersonalInformationScreen extends StatelessWidget {
  final controller = Get.put(PersonalInformationController());
  final themeController = Get.put(ThemeController());

  PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInformationController>(
      init: PersonalInformationController(),
      builder: (controller) {
        return Scaffold(
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
                Get.back(result: controller.dataUpdate);
              },
              icon: const AssetSVGWidget(iconsAppBarback),
            ),
            centerTitle: true,
            title: Text(
              strPersonalInformation.toUpperCase(),
              style: TextStyle(fontSize: font_16, fontWeight: FontWeight.w600),
            ),
          ),
          body: Stack(
            // alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: Get.height / 2,
                width: Get.width,
                child: (controller.loginDataModel != null)
                  ? NetworkImageWidget(
                imageUrl: controller.loginDataModel.profilePic ?? "",
                imageHeight: Get.height / 2,
                imageWidth: Get.width,
                imageFitType: BoxFit.cover,
                placeHolder: iconsProfilePlaceholderL,
              )
                  : AssetImageWidget(iconsProfilePlaceholderL,imageFitType: BoxFit.cover),),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: margin_20,
                          right: margin_20,
                          top: margin_32,
                          bottom: margin_20),
                      // height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(radius_8),
                              topLeft: Radius.circular(radius_8)),
                          color: Colors.white),
                      child: _personalInfoHandlerContainer(),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _personalInfoHandlerContainer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(controller.loginDataModel.name ?? "",
              style: TextStyle(
                fontSize: font_20,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding: EdgeInsets.only(top: margin_20, bottom: 20),
            child: PersonalInformationViewBarWidget(
              personalInfoTypeIcon: iconsMailbox,
              personalInfoName: (controller.loginDataModel.email ?? "").length > 25
                  ? (controller.loginDataModel.email ?? "").substring(0, 25) + "..."
                  : controller.loginDataModel.email ?? "",
              isVerifiedIcon: (controller.loginDataModel.emailVerified ?? false)
                  ? iconsBluetick
                  : iconsWarningExclamation,
              onTextTap: ()
              {
                Get.dialog(EmailDialog(email: controller.loginDataModel.email ?? ""));

              },
              ontap: (controller.loginDataModel.emailVerified ?? false)
                  ? null
                  : () async {
                      var isEmailupdated = await Get.dialog(VerifyOtpScreen(),
                          arguments: {
                            argIsForEmail: true,
                            argProfileData: controller.loginDataModel
                          });
                      isEmailupdated
                          ? controller.getDataFromLocalStorage()
                          : null;
                    },
            ),
          ),
            Padding(
              padding: EdgeInsets.only(bottom: margin_40),
              child: PersonalInformationViewBarWidget(
                personalInfoTypeIcon: iconsPhonedialer,
                personalInfoName:
               controller.loginDataModel.phoneNo==0? "N/A": "${controller.loginDataModel.countryCode ?? ""} ${controller.loginDataModel.phoneNo ?? ""}",
                isVerifiedIcon:(controller.loginDataModel.phoneVerified ?? false)
                    ? iconsBluetick
                    :iconsWarningExclamation,
                ontap: (controller.loginDataModel.phoneVerified ?? false)
                    ? null
                    :controller.loginDataModel.phoneNo==0?null: () async {
                  var isEmailupdated = await Get.dialog(VerifyOtpScreen(),
                      arguments: {
                        argIsForEmail: false,
                        argProfileData: controller.loginDataModel
                      });
                  isEmailupdated
                      ? controller.getDataFromLocalStorage()
                      : null;
                },
              ),
            ),
          InkWell(
              onTap: () async {
                var profileUpdated = await Get.toNamed(
                    AppRoutes.editProfileScreenRoute,
                    arguments: {argProfileData: controller.loginDataModel});
                profileUpdated
                    ? (() {
                  controller.getDataFromLocalStorage();
                  controller.dataUpdate = true;
                  controller.update();
                })()
                    : null;

              },
              child:
                  const PersonalInformationBtnWidget(btnName: strEditProfile)),
           if(controller.isSetPassWord==true)...[
            Padding(
              padding: EdgeInsets.only(top: margin_16),
              child: InkWell(
                  onTap: () async{
                    debugPrint("clicked");
                     Get.toNamed(AppRoutes.changePasswordRoute);
                  },
                  child: const PersonalInformationBtnWidget(
                      btnName: strChangePassword)),
            ),
           ],
          if(controller.isSetPassWord==false)...[
            Padding(
              padding: EdgeInsets.only(top: margin_16),
              child: InkWell(
                  onTap: () async{
                    debugPrint("clicked");
                    var result = await Get.toNamed(AppRoutes.changePasswordRoute);
                    if (result != null && result[argUpdate] == true) {
                      controller.isSetPassWord=true;
                      controller.update();
                    }

                  },
                  child: const PersonalInformationBtnWidget(
                      btnName:strSettPassword)),
            ),
          ]

        ],
      );
}
