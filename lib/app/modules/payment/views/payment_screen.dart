import "package:clipboard/clipboard.dart";
import "package:dotted_line/dotted_line.dart";
import "package:flutter/cupertino.dart";
import "package:quantity_savers/app/core/values/route_arguments.dart";

import "../../../core/utils/time_conversion.dart";
import "../../../export.dart";

class PaymentScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(PaymentController());

  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: (controller.isForMakePayment == true)
                ? strSelectPaymentMethod.toUpperCase()
                : strPayments.toUpperCase(),
          ),
          body: controller.cardsListResponseModel?.data?.totalCount == 0 &&
                  controller.isRouteFromProfilePayment == true
              ? _noPaymentMethodScreen()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: margin_8),
                              color: AppColors.dividerColor,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  TextView(
                                    text: strYourCard.toUpperCase(),
                                    textStyle: textStyleBodyMedium().copyWith(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: font_14),
                                  ).paddingOnly(left: margin_16),
                                  if (controller.isRouteFromProfilePayment ==
                                      false) ...[
                                    const Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        var result = await Get.toNamed(
                                            AppRoutes.addPaymentRoute,
                                            arguments: {
                                              argPriceDetailsResponceModel:
                                                  controller
                                                      .priceDetailsResponseModel,
                                              argCartDataResponceModel:
                                                  controller
                                                      .cartDataResponseModel,
                                              argAddressData: controller
                                                  .manageAddressDataSubData,
                                              argForAddNew: true
                                            });
                                        result
                                            ? controller.getCardListData()
                                            : null;
                                        controller.update();
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
                                                      color:
                                                          AppColors.gradient2nd,
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
                                  ]
                                ],
                              ),
                            ).paddingOnly(bottom: margin_16),
                            if (controller
                                    .cardsListResponseModel?.data?.totalCount ==
                                0) ...[
                              Center(
                                child: TextView(
                                        text: strNoCardFound.toUpperCase(),
                                        textStyle: textStyleBodyMedium()
                                            .copyWith(
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: font_14))
                                    .paddingOnly(bottom: 10),
                              ),
                            ],
                            ListView.builder(
                              itemCount: controller.cardsListResponseModel?.data
                                      ?.totalCount ??
                                  0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (controller.cardsListResponseModel?.data
                                        ?.data?[index].isDefault ??
                                    false) {
                                  controller.selectedIndex = index;
                                }
                                return _managePayment(index: index);
                              },
                            ),
                            if (controller.isRouteFromProfilePayment == false &&
                                controller.isForCampaign == false) ...[
                              Container(
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: AppColors.dividerColor,
                                ),
                                child: TextView(
                                  text: strCouponCode.toUpperCase(),
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: font_12,
                                      color: AppColors.darkGreyColor),
                                ).paddingSymmetric(
                                    vertical: margin_12,
                                    horizontal: margin_20),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(radius_12)),
                                    border: Border.all(
                                        color: AppColors.borderColor)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      child: TextFieldWidget(
                                        suffixIcon: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.gradient2nd),shape:MaterialStateProperty.all<RoundedRectangleBorder> (
                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))),
                                            onPressed: () {
                                              if (controller.textEditingController
                                                  .text.isEmpty) {
                                                Get.toNamed(
                                                    AppRoutes.couponScreenRoute);
                                              } else if (controller
                                                  .textEditingController
                                                  .text
                                                  .isNotEmpty && controller.applied==0) {
                                                controller.applyCouponApi();
                                              }
                                              else if(controller.count==2)
                                              {
                                                controller.count=0;
                                                controller.textEditingController.clear();
                                                controller.count = 0;
                                                controller.applied=0;
                                                controller.isApplyCoupon=false;
                                                controller.priceDetailsResponseModel?.data?.totalPrice=controller.startPrice;
                                                controller.priceDetailsResponseModel?.data?.discount=controller.startDiscount;
                                                controller.update();
                                                controller.update();
                                              }
                                            },
                                            child: TextView(
                                              text: controller.count == 0
                                                  ? "Apply"
                                                  : controller.count==1?"Apply":"Remove",
                                              textStyle: textStyleBodyMedium()
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: font_14),
                                            )).paddingOnly(left: 5, right: 5) ,
                                        hint: "Enter coupon code",
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        textController:
                                            controller.textEditingController,
                                        readOnly:controller.isApplyCoupon==false?false:true /*controller.count==0?false:true*/,
                                        focusNode: controller.textFocusNode,
                                        onChange: (text) {
                                          if (controller.textEditingController
                                              .text.isEmpty) {
                                            // controller.clearFields();
                                            controller.count = 0;
                                            controller.applied=0;
                                            controller.isApplyCoupon=false;
                                            controller.priceDetailsResponseModel?.data?.totalPrice=controller.startPrice;
                                            controller.priceDetailsResponseModel?.data?.discount=controller.startDiscount;
                                            controller.update();
                                          } else {
                                            controller.count = 1;
                                            controller.update();
                                          }
                                        },
                                      ),
                                      onTap: () {
                                        FlutterClipboard.paste().then((value) {
                                          debugPrint("Value is $value");
                                          controller.textEditingController
                                              .text = value;
                                        });
                                      },
                                    )),
                                  ],
                                ),
                              ).paddingAll(10),
                            ],
                            if (controller.isRouteFromProfilePayment ==
                                false) ...[
                              Container(
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: AppColors.dividerColor,
                                ),
                                child: TextView(
                                  text: strPriceDetails.toUpperCase(),
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: font_12,
                                      color: AppColors.darkGreyColor),
                                ).paddingSymmetric(
                                    vertical: margin_12, horizontal: margin_20),
                              ),
                              SizedBox(height: margin_12),
                              _detailsValue(
                                  key: controller.isForCampaign
                                      ? "${strPrice.capitalize} (${controller.joinedCampaignDetailResponseModel?.data?.totalQuantity ?? 0} items)"
                                      : "${strPrice.capitalize} (${controller.cartDataResponseModel?.data?.data?[0].quantity ?? 0} items)",
                                  value: controller.isForCampaign
                                      ? "\$${controller.joinedCampaignDetailResponseModel?.data?.totalPrice ?? 0}"
                                      : "\$${controller.priceDetailsResponseModel?.data?.price ?? 0}",
                                  valuetextstyle: textStyleBodyMedium()
                                      .copyWith(
                                          fontSize: font_14,
                                          fontWeight: FontWeight.w500),
                                  icon: false),
                              controller.isForCampaign
                                  ? const SizedBox()
                                  : _detailsValue(
                                      key: strDiscount,
                                      value: controller.isApplyCoupon == true
                                          ? "-\$${(controller.priceDetailsResponseModel?.data?.discount ?? 0 + controller.applyCouponResponseModel.data?.couponDiscount ?? 0).toStringAsFixed(2)}"
                                          : "-\$${(controller.priceDetailsResponseModel?.data?.discount ?? 0).toStringAsFixed(2)}",
                                      valuetextstyle: textStyleBodyMedium()
                                          .copyWith(
                                              fontSize: font_14,
                                              fontWeight: FontWeight.w500),
                                      icon: false),
                              controller.isApplyCoupon == true
                                  ? _detailsValue(
                                      key: "Coupon Discount",
                                      value:
                                          "-\$${(controller.applyCouponResponseModel.data?.couponDiscount ?? 0).toStringAsFixed(2)}",
                                      valuetextstyle: textStyleBodyMedium()
                                          .copyWith(
                                              fontSize: font_14,
                                              fontWeight: FontWeight.w500),
                                      icon: false)
                                  : SizedBox(),
                              _detailsValue(
                                  key: strDeliveryCharges,
                                  value: "FREE",
                                  valuetextstyle: textStyleBodyMedium()
                                      .copyWith(
                                          fontSize: font_14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.gradient2nd),
                                  icon: false),
                              const DottedLine(dashColor: AppColors.gradient2nd)
                                  .paddingOnly(top: margin_20)
                                  .paddingSymmetric(horizontal: margin_20),
                              _detailsValue(
                                  key: strTotalPrice,
                                  keyTextstyle: textStyleBodyMedium().copyWith(
                                      fontSize: font_16,
                                      fontWeight: FontWeight.w600),
                                  value: controller.isForCampaign
                                      ? controller.isApplyCoupon == true
                                          ? "\$${(controller.joinedCampaignDetailResponseModel?.data?.totalPrice - controller.applyCouponResponseModel.data?.couponDiscount ?? 0).toStringAsFixed(2)}"
                                          : "\$${(controller.joinedCampaignDetailResponseModel?.data?.totalPrice ?? 0).toStringAsFixed(2)}"
                                      : controller.isApplyCoupon == true
                                          ? "\$${(controller.priceDetailsResponseModel?.data?.totalPrice ?? 0 - controller.applyCouponResponseModel.data?.couponDiscount ?? 0).toStringAsFixed(2)}"
                                          : "\$${(controller.priceDetailsResponseModel?.data?.totalPrice ?? 0).toStringAsFixed(2)}",
                                  valuetextstyle: textStyleBodyMedium()
                                      .copyWith(
                                          fontSize: font_16,
                                          fontWeight: FontWeight.w600),
                                  icon: false),
                              const DottedLine(dashColor: AppColors.gradient2nd)
                                  .paddingSymmetric(
                                      vertical: margin_12,
                                      horizontal: margin_20),
                              _safetyNotes(),
                              controller.isForCampaign
                                  ? _noteView()
                                  : const SizedBox()
                            ]
                          ],
                        ).paddingSymmetric(vertical: margin_20),
                      ),
                    ),
                    BottomButtonWidget(
                        onPressed: () {
                          if (controller.isRouteFromProfilePayment == true) {
                            Get.toNamed(AppRoutes.addPaymentRoute,
                                arguments: {argForAddNew: true});
                          } else {
                            if (controller.selectedIndex < 0) {
                              showToast(message: 'Please Add your Card');
                            } else {
                              if (controller.isForMakePayment == true) {
                                if (controller.isForCampaign) {
                                  controller.checkOutCampaignAPiCall();
                                } else {
                                  controller.checkOutAPiCall();
                                }
                              }
                            }
                          }
                        },
                        btnTitle: (controller.isForMakePayment == true)
                            ? strCheckoutTitle
                            : strAddNewCard)
                  ],
                ),

          // body: _noPaymentMethodScreen(),
        );
      },
    );
  }

  _detailsValue({key, keyTextstyle, value, valuetextstyle, icon}) => Row(
        children: [
          TextView(
            maxLines: 3,
            text: key.toString(),
            textStyle: keyTextstyle ??
                textStyleBodyMedium().copyWith(
                  fontSize: font_14,
                  fontWeight: FontWeight.w300,
                ),
          ),
          const Spacer(),
          TextView(
            maxLines: 3,
            text: value.toString(),
            textStyle: valuetextstyle ??
                textStyleBodyMedium()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: font_16),
          ),
          icon
              ? const AssetSVGWidget(iconsCompaignLocked)
                  .paddingOnly(left: margin_4)
              : const SizedBox(width: 0, height: 0)
        ],
      ).paddingOnly(top: margin_12).paddingSymmetric(horizontal: margin_20);

  _safetyNotes() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AssetSVGWidget(Assets.iconsGreyExclamation)
              .paddingOnly(right: margin_4, top: margin_2),
          Expanded(
            child: TextView(
              maxLines: 3,
              text: strPaymentSafetyNotes,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w400,
                  fontSize: font_12),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: margin_20);

  _noteView() => Container(
        decoration: BoxDecoration(
            color: AppColors.catBackgroundColor,
            borderRadius: BorderRadius.circular(radius_12),
            border: Border.all(color: AppColors.borderColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "Note: ",
                    style: textStyleBodyMedium().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w700),
                    children: [
                  TextSpan(
                    text:
                        "You are joining the campaign, if the campaign didn't reach its minimum quantity until",
                    style: textStyleBodyMedium().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: millisecondsToCustomDateFormat(int.parse(
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.endDate ?? 0}")),
                    style: textStyleBodyMedium().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text:
                        " then your order will be cancelled and your amount will be refunded in your bank account.",
                    style: textStyleBodyMedium().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w300),
                  ),
                ])),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.termsAndConditions,
                    arguments: {argTitle: 'Terms & Conditions'});
              },
              child: TextView(
                text: "Campaign rules and regulation",
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_14,
                    color: AppColors.gradient2nd,
                    decorationColor: AppColors.gradient2nd,
                    decoration: TextDecoration.underline),
              ).paddingOnly(top: margin_20),
            )
          ],
        ).paddingSymmetric(vertical: margin_15, horizontal: margin_20),
      ).paddingSymmetric(vertical: margin_15, horizontal: margin_20);

  _managePayment({index}) => InkWell(
        onTap: () {
          var data = controller.cardsListResponseModel?.data?.data;
          if (data?[index].isDefault ?? false) {
            data?[index].isDefault = false;
            controller.selectedIndex = -1;
          } else {
            if (data != null && index < data.length) {
              for (int i = 0; i < data.length; i++) {
                data[i].isDefault = (i == index);
              }
              controller.update();
            }
          }
        },
        child: Container(
          padding: EdgeInsets.all(margin_16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius_12)),
              border: Border.all(
                  color: (controller.cardsListResponseModel?.data?.data?[index]
                              .isDefault ??
                          false)
                      ? AppColors.gradient2nd
                      : AppColors.borderColor)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (controller.isForMakePayment == true)
                  ? AssetSVGWidget((controller.cardsListResponseModel?.data
                                  ?.data?[index].isDefault ??
                              false)
                          ? iconsRadioFill
                          : iconsRadioUnselected)
                      .paddingOnly(top: margin_4, right: margin_8)
                  : const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: controller
                            .cardsListResponseModel?.data?.data?[index].brand ??
                        "",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_16),
                  ),
                  TextView(
                    text:
                        "XXXX - XXXX - XXXX - ${controller.cardsListResponseModel?.data?.data?[index].last4 ?? ""}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  ),
                ],
              ),
              const Spacer(),
              (controller.isForMakePayment == true)
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        Get.dialog(CustomDialogWidget(
                          title: strDeletePaymentDes,
                          confirmTitle: strYes,
                          cancelTitle: strNo,
                          cancelTitleColor: Colors.black,
                          confirmBtnBgColor: Colors.red,
                          cancelBtnBorder: Border.all(
                              color: AppColors.borderColor, width: 1),
                          cancelBtnBgColor: Colors.transparent,
                          onTapConfirm: () {
                            Get.back();
                            controller.deleteCardId = controller
                                    .cardsListResponseModel
                                    ?.data
                                    ?.data?[index]
                                    .sId ??
                                "";
                            controller.update();
                            controller.hitDeleteCardApi();
                          },
                        ));
                      },
                      child: AssetSVGWidget(
                        iconsDelete,
                        color: Colors.red,
                        imageWidth: width_16,
                      ),
                    ).paddingOnly(top: margin_4),
            ],
          ),
        )
            .paddingOnly(bottom: margin_16)
            .paddingSymmetric(horizontal: margin_20),
      );

  _noPaymentMethodScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AssetSVGWidget(iconsAddress).paddingOnly(bottom: margin_20),
            TextView(
              textAlign: TextAlign.center,
              text: strNoPaymentMethodFound,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ),
            TextView(
              text: strAddPaymentMethod,
              textStyle: textStyleBodyMedium().copyWith(
                  color: AppColors.categoriesgrey,
                  fontWeight: FontWeight.w500,
                  fontSize: font_14),
            ).paddingSymmetric(vertical: margin_16),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.addPaymentRoute,
                        arguments: {argForAddNew: true});
                  },
                  child: EditProfileBtnWidget(btnName: strAddCard)),
            )
          ],
        ),
      );

  Color getColor(Set<MaterialState> states) {
    return AppColors.borderColor;
  }
}
