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

import "package:quantity_savers/app/core/values/app_values.dart";

import "../../../export.dart";

class EditProfileScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
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
              strEditProfile.toUpperCase(),
              style: TextStyle(fontSize: font_16, fontWeight: FontWeight.w600),
            ),
          ),
          body: Stack(
            children: <Widget>[
              SizedBox(
                height: Get.height / 2,
                child: Align(
                  alignment: Alignment.center,
                  child: controller.editImage
                      ? Image.file(
                          File(controller.image.path),
                          fit: BoxFit.fill,
                    height: Get.height,
                    width: Get.width,
                        )
                 /* Image(
                      image: FileImage(
                        File(controller.image!.path),
                      ),height: Get.height,width: Get.width,)*/
                      : ((controller.loginDataModel != null)
                          ? NetworkImageWidget(
                              imageUrl:
                                  controller.loginDataModel.profilePic ?? "",
                              imageHeight: Get.height,
                              imageWidth: Get.width,
                              imageFitType: BoxFit.cover,
                              placeHolder: iconsProfilePlaceholderL,
                            )
                          : const AssetImageWidget(iconsProfilePlaceholderL,
                              imageFitType: BoxFit.fill)),
                ),
              ),
              Positioned(
                  top: margin_10,
                  right: margin_10,
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(ImagePickerDialog(
                          title: strSource,
                          galleryFunction: () {
                            controller.imageFromGallery();
                          },
                          cameraFunction: () {
                            controller.imageFromCamera();
                          }));
                    },
                    icon: const AssetSVGWidget(Assets.iconsEditPencil),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: margin_20,
                        right: margin_20,
                        top: margin_32,
                        bottom: margin_20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(radius_8),
                            topLeft: Radius.circular(radius_8)),
                        color: Colors.white),
                    child: _editProfileContainer(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _editProfileContainer() => Form(
        key: controller.editProfileFormGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFieldWidget(
              textController: controller.nameTextController,
              focusNode: controller.nameFocusNode,
              labelColor: AppColors.categoriesgrey,
              labelSize: font_14,
              label: strEnterName,
              hint: strEnterName,
            ).paddingOnly(bottom: margin_16),
            TextFieldWidget(
              readOnly: true,
              textController: controller.emailTextController,
              focusNode: controller.emailFocusNode,
              labelColor: AppColors.categoriesgrey,
              labelSize: font_14,
              label: strEmail,
              hint: strEnterName,
              suffixIcon: InkWell(
                onTap: (controller.loginDataModel.emailVerified ?? false)
                    ? null
                    : () async {
                        controller.dataUpdate =
                            await Get.dialog(VerifyOtpScreen(), arguments: {
                          argIsForEmail: true,
                          argProfileData: controller.loginDataModel
                        });
                        controller.dataUpdate
                            ? controller.getDataFromLocalStorage()
                            : null;
                      },
                child: (controller.loginDataModel.emailVerified ?? false)
                    ? const SizedBox()
                    : const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: AssetSVGWidget(iconsWarningExclamation,
                            imageWidth: 10, imageHeight: 10),
                      ),
              ),
              // bottomPadding: margin_16,
            ).paddingOnly(bottom: margin_16),

                CountryPickerTextField(
                  showCountryFlag: true,
                  label: strPhoneNumber,
                  labelColor: AppColors.categoriesgrey,
                  hintText: strPhoneNumber,
                  onCountryChanged: (Country country)
                  {
                    controller.selectedCountry=country;
                  },
                  suffix: InkWell(
                    onTap: (controller.loginDataModel.phoneVerified ?? false)
                        ? null
                        :() async {
                      controller.dataUpdate =
                      await Get.dialog(VerifyOtpScreen(), arguments: {
                        argIsForEmail: false,
                        argProfileData: controller.loginDataModel
                      });
                      controller.dataUpdate
                          ? controller.getDataFromLocalStorage()
                          : null;
                    },
                    child: (controller.loginDataModel.phoneVerified ?? false)
                        ? const SizedBox()
                        : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: AssetSVGWidget(iconsWarningExclamation,
                          imageWidth: 10, imageHeight: 10),
                    ),
                  ),
                  selectedCountry: controller.selectedCountry,
                  controller:controller.mobileNumberTextController,
                  focusNode: controller.mobileNumberFocusNode,
                ).paddingOnly(bottom: margin_16),
            InkWell(
                onTap: () {
                  if(controller.editProfileFormGlobalKey.currentState!.validate())
                    {
                      (controller.image == null)
                          ? controller.hitUpdateProfileWithoutImageApiCall()
                          : controller.hitUpdateProfileApiCall();
                    }

                },
                child: EditProfileBtnWidget(btnName: strSaveChanges)),
          ],
        ),
      );
}
