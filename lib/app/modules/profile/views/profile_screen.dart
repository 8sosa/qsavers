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

import '../../../core/widget/cusstom_dialog_widget.dart';
import '../../../export.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  final themeController = Get.put(ThemeController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: strProfile.toUpperCase(),
            isLeadingPresent: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _profileBanner(),
                 _profileMenu(
                    strCustomer, controller.profileModel.profileCustomerList),
                _profileMenu(
                    strCreator, controller.profileModel.profileCreatorList),
                _profileMenu(
                    strLegal, controller.profileModel.profileLegalList),
                _profileMenu(
                    strAccount, controller.profileModel.profileAccountList),
              ],
            ),
          ),
        );
      },
    );
  }

  _profileBanner() => Container(
        padding: EdgeInsets.only(
            top: margin_22,
            bottom: margin_32,
            left: margin_20,
            right: margin_20),
        child: Container(
          padding: EdgeInsets.all(margin_20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_12),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [AppColors.gradient1st, AppColors.gradient2nd])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              NetworkImageWidget(
                  imageUrl: controller.loginDataModel.profilePic ?? "",
                  imageHeight: height_60,
                  imageWidth: height_60,
                  radiusAll: radius_50,
                  imageFitType: BoxFit.cover,
                  placeHolder: iconsProfilePlaceholderS),
              SizedBox(
                width: width_16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextView(
                      text: controller.loginDataModel.name ?? "",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: font_18),
                    ),
                    TextView(
                      text: controller.loginDataModel.email ?? "",
                      textStyle: textStyleBodyMedium().copyWith(
                          color: AppColors.borderColor,
                          fontWeight: FontWeight.w500,
                          fontSize: font_14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  _profileMenu(String profileMenuTitle,
          List<Map<String, dynamic>> profileMenuList) =>
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: margin_20, top: margin_8, bottom: margin_8),
            // margin: const EdgeInsets.only(top: 10.0),
            color: AppColors.dividerColor,
            alignment: Alignment.centerLeft,
            child: TextView(
              text: profileMenuTitle,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: profileMenuList.length,
            itemBuilder: (context, index) {
              return  InkWell(
                onTap: () async {
                  if(controller.loginDataModel.email!=null)
                    {
                      if (profileMenuList[index]["name"] == "Logout") {
                        Get.dialog(CustomDialogWidget(
                          title: strLogoutDes,
                          confirmTitle: strYes,
                          cancelTitle: strNo,
                          confirmBtnBgColor: Colors.red,
                          cancelTitleColor: AppColors.gradientColorSecondary,
                          cancelBtnBorder:
                          Border.all(color: AppColors.borderColor, width: 1),
                          cancelBtnBgColor: Colors.transparent,
                          onTapConfirm: () async{
                            Get.back();
                            controller.hitLogoutApi();
                          },
                          isImage: false,
                          isCloseBtn: true,
                        ));
                      } else {
                        controller.dataUpdate = await Get.toNamed(
                            profileMenuList[index]["path"],
                            arguments: {
                              argIsRouteFromProfilePayment:
                              profileMenuList[index]["name"] == "Payments",
                              argProfileData: controller.loginDataModel,
                              argTitle: profileMenuList[index]["name"],
                              argIsForSelectAddress: false,
                              argForOngoing:
                              (profileMenuList[index]["name"] == "Campaigns" &&
                                  profileMenuList[index]["type"] == "Customer")
                            });
                      }
                      controller.dataUpdate
                          ? controller.getLocalProfileData()
                          : false;
                      controller.update();
                    }
                },
                child: ProfileMenuListItem(
                  profileMenuList: profileMenuList[index],
                  profileMenuTitle: profileMenuTitle,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: margin_20, right: margin_20),
                child: const Divider(
                  color: AppColors.textfieldborder,
                ),
              );
            },
          ),
        ],
      );
}
