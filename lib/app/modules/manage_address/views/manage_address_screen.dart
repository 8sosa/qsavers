import "../../../export.dart";

class ManageAddressScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ManageAddressController());

  ManageAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageAddressController>(
      init: ManageAddressController(),
      builder: (controller) {
        return Shimmer(
          child: Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: controller.isForSelectAddress
                    ? strSelectShippingAddress
                    : strManageAddress.toUpperCase(),
              ),
              body: ShimmerLoading(
                isLoading: controller.isLoading,
                isImage: true,
                child: controller
                            .manageAddressResponseModel?.data?.totalCount ==
                        0
                    ? _noAddressScreen()
                    : Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: margin_8),
                                  color: AppColors.dividerColor,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      TextView(
                                        text: strYourAddress,
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: font_14),
                                      ).paddingOnly(left: margin_16),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          var result = await Get.toNamed(
                                              AppRoutes.addNewAddressRoute);
                                          result
                                              ? controller
                                                  .getAddressDataApiCall()
                                              : null;
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Row(
                                            children: [
                                              const AssetSVGWidget(
                                                  iconsAddFilladdGreen),
                                              TextView(
                                                text: strAddNew,
                                                textStyle: textStyleBodyMedium()
                                                    .copyWith(
                                                        color: AppColors
                                                            .gradient2nd,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: font_14),
                                              ).paddingOnly(
                                                  left: margin_8,
                                                  right: margin_20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ).paddingOnly(top: margin_16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                          .manageAddressResponseModel
                                          ?.data
                                          ?.totalCount ??
                                      0,
                                  itemBuilder: (context, index) {
                                    if (controller.manageAddressResponseModel
                                            ?.data?.data?[index].isDefault ??
                                        false) {
                                      controller.selectedAddress = index;
                                      debugPrint(
                                          "${controller.selectedAddress}");
                                    }
                                    return _manageAddressScreen(index);
                                  },
                                ).paddingAll(margin_20),
                              ],
                            ),
                          )),
                          BottomButtonWidget(
                            onPressed: () {
                              controller.isForSelectAddress
                                  ? Get.toNamed(AppRoutes.paymentRoute,
                                      arguments: {
                                          argForPayment: true,
                                          argAddressData: controller
                                                  .manageAddressResponseModel
                                                  ?.data
                                                  ?.data?[
                                              controller.selectedAddress ?? 0],
                                          argForCompaign:
                                              controller.isForCampaign,
                                        })
                                  : Get.toNamed(AppRoutes.addNewAddressRoute);
                            },
                            btnTitle: controller.isForSelectAddress
                                ? strProceedToPayment
                                : strAddNewAddress,
                          )
                        ],
                      ),
              )
              // body: _noAddressScreen(),
              ),
        );
      },
    );
  }

  _manageAddressScreen(int index) => Container(
        padding: EdgeInsets.all(margin_16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius_12)),
            border: Border.all(
                color: (controller.manageAddressResponseModel?.data
                            ?.data?[index].isDefault ??
                        false)
                    ? AppColors.gradient2nd
                    : AppColors.borderColor)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextView(
                  text: controller.manageAddressResponseModel?.data
                          ?.data?[index].name ??
                      "",
                  textStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: font_16),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: margin_6, vertical: margin_2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius_3)),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                            AppColors.gradientColorPrimary,
                            AppColors.gradientColorSecondary
                          ])),
                  child: TextView(
                    text: controller.manageAddressResponseModel?.data
                            ?.data?[index].addressType ??
                        "",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: font_10),
                  ),
                ).paddingOnly(left: margin_8),
                const Spacer(),
                controller.isForSelectAddress
                    ? const SizedBox()
                    : controller.manageAddressResponseModel?.data?.data?[index]
                                .isDefault ??
                            false
                        ? TextView(
                            text: strDefault,
                            textStyle: textStyleBodyMedium().copyWith(
                                color: AppColors.bottombarColor,
                                fontWeight: FontWeight.w500,
                                fontSize: font_12),
                          ).paddingOnly(right: margin_4)
                        : const SizedBox(),
                controller.isForSelectAddress
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Get.dialog(CustomDialogWidget(
                            title: strDeleteAddressDes,
                            confirmTitle: strYes,
                            cancelTitle: strNo,
                            confirmBtnBgColor: Colors.red,
                            cancelTitleColor: AppColors.gradientColorSecondary,
                            cancelBtnBorder: Border.all(
                                color: AppColors.borderColor, width: 1),
                            cancelBtnBgColor: Colors.transparent,
                            onTapConfirm: () {
                              Get.back(result: true);
                              controller.hitDeleteAddresApi(controller
                                  .manageAddressResponseModel
                                  ?.data
                                  ?.data?[index]
                                  .sId);
                            },
                            isImage: false,
                            isCloseBtn: true,
                          ));
                        },
                        child: AssetSVGWidget(
                          iconsDeleted,
                          imageWidth: width_14,imageHeight: width_14,
                        ),
                      ),
              ],
            ).paddingOnly(bottom: margin_20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AssetSVGWidget(iconsManageAddress)
                    .paddingOnly(right: margin_8),
                Expanded(
                  child: TextView(
                    text: controller.manageAddressResponseModel?.data
                            ?.data?[index].fullAddress ??
                        "",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AssetSVGWidget(iconsPhonedialer)
                    .paddingOnly(right: margin_8),
                Expanded(
                  child: TextView(
                    text:
                        "${controller.manageAddressResponseModel?.data?.data?[index].countryCode ?? ""} ${controller.manageAddressResponseModel?.data?.data?[index].phoneNo ?? ""}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: margin_20),
            controller.isForSelectAddress
                ? _selectButton(index)
                : Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: _addressesManageBtn(
                              iconsLoader, strSetAsDefault, index)),
                      SizedBox(
                        width: width_8,
                      ),
                      Expanded(
                          flex: 1,
                          child:
                              _addressesManageBtn(iconsPencil, strEdits, index))
                    ],
                  ),
          ],
        ),
      ).paddingOnly(bottom: margin_20);

  _addressesManageBtn(iconPrefix, btnName, int index) {
    bool isDefault =
        controller.manageAddressResponseModel?.data?.data?[index].isDefault ??
            false;
    return GestureDetector(
      onTap: () {
        if (btnName == 'Edit') {
          debugPrint("index is $index");
          Get.toNamed(AppRoutes.addNewAddressRoute, arguments: {
            argId:
                controller.manageAddressResponseModel?.data?.data?[index].sId,
            argIsRouteForEditManageAddress: true,
            argIsRouteForEditManageAddressData:
                controller.manageAddressResponseModel?.data?.data?[index]
          });
        } else {
          controller.hitDefaultAddressApi(
              controller.manageAddressResponseModel?.data?.data?[index].sId);
          controller.update();
        }
      },
      child: Container(
        padding: EdgeInsets.all(margin_10),
        decoration: BoxDecoration(
            border: btnName == strEdits
                ? Border.all(color: AppColors.borderColor)
                : null,
            borderRadius: BorderRadius.circular(radius_4),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: btnName == strEdits
                    ? [Colors.transparent, Colors.transparent]
                    : [
                        isDefault
                            ? AppColors.gradient2nd
                            : AppColors.gradient1st,
                        AppColors.gradient2nd
                      ])),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetSVGWidget(
                iconPrefix,
                color: btnName == strEdits
                    ? AppColors.categoriesgrey
                    : Colors.white,
              ).paddingOnly(right: margin_2),
              Text(btnName,
                  style: TextStyle(
                    fontSize: font_12,
                    color: btnName == strEdits
                        ? AppColors.categoriesgrey
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _noAddressScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsAddress).paddingOnly(bottom: margin_20),
            TextView(
              text: strNoAddressFound,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ),
            TextView(
              text: strAddDelivery,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ).paddingSymmetric(vertical: margin_16),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.addNewAddressRoute);
                  },
                  child: EditProfileBtnWidget(btnName: strAddAddress)),
            )
          ],
        ),
      );

  _selectButton(int index) => InkWell(
        onTap: () {
          var data = controller.manageAddressResponseModel?.data?.data;
          if (data != null && index < data.length) {
            for (int i = 0; i < data.length; i++) {
              data[i].isDefault = (i == index);
            }
            controller.update();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: (controller.manageAddressResponseModel?.data?.data?[index]
                        .isDefault ??
                    false)
                ? AppColors.gradient2nd
                : Colors.transparent,
            borderRadius: BorderRadius.circular(margin_4),
            border: Border.all(
              color: AppColors.gradient2nd,
              width: width_1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (controller.manageAddressResponseModel?.data?.data?[index]
                          .isDefault ??
                      false)
                  ? const AssetSVGWidget(iconsFillwhiteFillRight)
                      .paddingOnly(right: margin_8)
                  : const SizedBox(),
              TextView(
                text: (controller.manageAddressResponseModel?.data?.data?[index]
                            .isDefault ??
                        false)
                    ? strSELECTED
                    : strSelect.toUpperCase(),
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    color: (controller.manageAddressResponseModel?.data
                                ?.data?[index].isDefault ??
                            false)
                        ? Colors.white
                        : AppColors.gradient2nd,
                    fontSize: 14),
              ),
            ],
          ).paddingSymmetric(vertical: margin_8),
        ),
      );
}
