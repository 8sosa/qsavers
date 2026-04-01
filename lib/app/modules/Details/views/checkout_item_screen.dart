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

import 'package:dotted_line/dotted_line.dart';
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/cartdata_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/joined_campaign_data_model.dart';
import 'package:quantity_savers/generated/assets.dart';

import '../../../core/utils/input_qty/lib/src/decoration_props.dart';
import '../../../core/utils/input_qty/lib/src/input_qty.dart';
import '../../../export.dart';

class CheckoutItemScreen extends StatelessWidget {
  final controller = Get.put(CheckoutItemController());
  final themeController = Get.put(ThemeController());
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  CheckoutItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutItemController>(
        init: CheckoutItemController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: strCheckoutTitle.toUpperCase(),
            ),
            body: (controller.isRouteFromCampaignOrder == true)
                ?controller.isLoading==true?const Center(child: CircularProgressIndicator(color: AppColors.gradient2nd,)): _checkOut1()
                :controller.isLoading==true?const Center(child: CircularProgressIndicator(color: AppColors.gradient2nd,)): _checkOut2(),
          );
        });
  }

  _checkOut1() => Column(
        children: [
          _deadlineView(),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemDetailViewForCampaign(controller
                    .joinedCampaignDetailResponseModel
                    ?.data
                    ?.mainProductDetails),
                _dividerView(),
                if ((controller.joinedCampaignDetailResponseModel?.data
                            ?.products?.length ??
                        0) !=
                    0) ...[
                  // Container(
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     itemCount: controller.joinedCampaignDetailResponseModel
                  //             ?.data?.products?.length ??
                  //         0,
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return InkWell(
                  //         onTap: () {},
                  //         child: _itemQuantityCard(index),
                  //       );
                  //     },
                  //   ).paddingOnly(
                  //       top: margin_20, left: margin_20, right: margin_20),
                  // )
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.joinedCampaignDetailResponseModel?.data?.products?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        int itemCount = controller.joinedCampaignDetailResponseModel?.data?.products?.length ?? 0;
                        if (itemCount > 2 && index >= itemCount - 2) {
                          return InkWell(
                            onTap: () {},
                            child: _itemQuantityCard(index),
                          );
                        } else if (itemCount <= 2) {
                          return InkWell(
                            onTap: () {},
                            child: _itemQuantityCard(index),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ).paddingOnly(top: margin_20, left: margin_20, right: margin_20),
                  )


                ],
                Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: AppColors.dividerColor,
                  ),
                  child: TextView(
                    text: strCampaignDetails.toUpperCase(),
                    textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: font_12,
                        color: AppColors.darkGreyColor),
                  ).paddingSymmetric(
                      vertical: margin_12, horizontal: margin_20),
                ),
                SizedBox(height: margin_12),
                _detailsValue(
                    key: "Group Name ",
                    value:
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.groupId?.groupName ?? ""}",
                    icon: ((controller.joinedCampaignDetailResponseModel?.data
                                ?.campaignId?.groupId?.groupType ??
                            "") ==
                        "PRIVATE")),
                _detailsValue(
                    key: "Campaign Name  ",
                    value:
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.campaignName ?? ""}",
                    icon: false),
                _detailsValue(
                    key: "Remaining Quantity to Complete Campaign ",
                    value:
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.quantity ?? 0}",
                    icon: false),
                _detailsValue(
                    key: "Users Joined Campaign ",
                    value:
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.userJoined ?? 0}",
                    icon: false),
                _detailsValue(
                    key: "Campaign Start Date ",
                    value: millisecondsToCustomDateFormat(int.parse(
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.startDate ?? 0}")),
                    icon: false),
                _detailsValue(
                    key: "Campaign End Date ",
                    value: millisecondsToCustomDateFormat(int.parse(
                        "${controller.joinedCampaignDetailResponseModel?.data?.campaignId?.endDate ?? 0}")),
                    icon: false),
                SizedBox(height: margin_12),
                _dividerView(),
                _detailsValue(
                    key:
                        "Price (${controller.joinedCampaignDetailResponseModel?.data?.totalQuantity ?? 0} items)",
                    value:
                        "\$${controller.joinedCampaignDetailResponseModel?.data?.totalPrice ?? 0}",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                    icon: false),
                _detailsValue(
                    key: "Delivery Charges ",
                    value: "FREE",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gradient2nd),
                    icon: false),
                DottedLine(dashColor: AppColors.gradient2nd)
                    .paddingSymmetric(horizontal: margin_20)
                    .paddingOnly(top: margin_20),
                _detailsValue(
                    key: "Total Price ",
                    keyTextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                    value:
                        "\$${controller.joinedCampaignDetailResponseModel?.data?.totalPrice ?? 0}",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                    icon: false),
                const DottedLine(dashColor: AppColors.gradient2nd)
                    .paddingSymmetric(
                        horizontal: margin_20, vertical: margin_12),
                _safetyNotes(),
                _noteView(),
              ],
            )),
          ),
          Container(
            child: MaterialButtonWidget(
              minHeight: height_48,
              onPressed: () {
                // if ((formKey1.currentState?.validate() ?? false) || (formKey2.currentState?.validate() ?? false))
                if(controller.joinedCampaignDetailResponseModel?.data?.totalPrice!=0)
                {
                    Get.toNamed(AppRoutes.manageAddressRoute, arguments: {
                      argIsRouteFromCampaignOrder: true,
                      argIsForSelectAddress: true,
                    });
                  }
               else
                 {
                   showToast(message: "Purchase a minimum of one product to start the campaign");
                 }
              },
              buttonText: strBtnProceedToAddress.toUpperCase(),
              buttonBgColor: AppColors.gradient2nd,
              buttonTextStyle: textStyleBodyMedium().copyWith(
                  fontSize: font_16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ).paddingOnly(
                top: margin_15,
                bottom: margin_42,
                left: margin_20,
                right: margin_20),
          )
        ],
      );

  _deadlineView() => Container(
        color: AppColors.Porcelain,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextView(
              text: "Hurry! Join campaign to avail the lowest price.",
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: font_14,
                  color: AppColors.gradient1st),
            ),
            Row(
              children: [
                AssetSVGWidget(iconsClockgreebline)
                    .paddingOnly(right: margin_8),
                TextView(
                  text:
                      "${controller.timeComponents[0]}d : ${controller.timeComponents[1]}h : ${controller.timeComponents[2]}m : ${controller.timeComponents[3]}s",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontSize: font_14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradient2nd),
                )
              ],
            ).paddingOnly(top: margin_4)
          ],
        ).paddingSymmetric(vertical: margin_20, horizontal: margin_20),
      );

  _itemDetailView(ProductId? productId) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: height_60,
            width: height_60,
            child: NetworkImageWidget(
              imageUrl: productId?.images?[0] ?? "",
              imageHeight: height_60,
              imageWidth: height_60,
              imageFitType: BoxFit.fill,
            ),
          ).paddingOnly(right: margin_12),
          // AssetImageWidget(controller.customItemQuantityModel?..image ?? ""),
          // AssetImageWidget(controller.customModel?.image ?? ""),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  maxLines: 3,
                  text: productId?.name ?? "",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: font_14),
                ),
                Row(
                  children: [
                    TextView(
                      maxLines: 3,
                      text: strPrice,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.categoriesgrey),
                    ),
                    TextView(
                      maxLines: 3,
                      text: "\$${productId?.discountPrice}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: font_16,
                          color: Colors.black),
                    ),
                    TextView(
                      maxLines: 3,
                      text: "\$${productId?.price ?? ""}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_14,
                          color: AppColors.categoriesgrey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.DustyGray,
                         ),
                    ).paddingSymmetric(horizontal: margin_4),
                    TextView(
                      maxLines: 3,
                      text: "${productId?.discountPercantage}% off",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_14,
                          color: AppColors.gradient2nd),
                    ),
                  ],
                ).paddingOnly(top: margin_4),
                SizedBox(width: Get.width / 2, child: _selectQuantityDropDown())
                    .paddingOnly(top: margin_12)
              ],
            ),
          )
        ],
      ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);

  _itemDetailViewForCampaign(MainProductDetails? mainProductDetails) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: height_60,
            width: height_60,
            child: NetworkImageWidget(
              imageUrl: mainProductDetails?.images?[0] ?? "",
              imageHeight: height_60,
              imageWidth: height_60,
              imageFitType: BoxFit.fill,
            ),
          ).paddingOnly(right: margin_12),
          // AssetImageWidget(controller.customItemQuantityModel?..image ?? ""),
          // AssetImageWidget(controller.customModel?.image ?? ""),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextView(
                  maxLines: 3,
                  text: mainProductDetails?.name ?? "",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: font_14),
                ),
                Row(
                  children: [
                    TextView(
                      maxLines: 3,
                      text: strPrice,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_12,
                          color: AppColors.categoriesgrey),
                    ),
                    TextView(
                      maxLines: 3,
                      text: "\$${mainProductDetails?.wholesalePrice}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: font_16,
                          color: Colors.black),
                    ),
                    TextView(
                      maxLines: 3,
                      text: "\$${mainProductDetails?.price ?? 0.0}",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_14,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.DustyGray,
                          color: AppColors.categoriesgrey,
                         ),
                    ).paddingSymmetric(horizontal: margin_4),
                    TextView(
                      maxLines: 3,
                      text: "${(controller.getDiscountPercentage()).toStringAsFixed(2)}% Off",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_14,
                          color: AppColors.gradient2nd),
                    ),
                  ],
                ).paddingOnly(top: margin_4),
              ],
            ),
          )
        ],
      ).paddingSymmetric(vertical: margin_20, horizontal: margin_20);

  _dividerView() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: Colors.grey.shade300,
        ),
      );

  _itemQuantityCard(int index) {
    GlobalKey<FormState> currentFormKey = index % 2 == 0 ? formKey1 : formKey2;

    var item =
        controller.joinedCampaignDetailResponseModel?.data?.products?[index];
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextView(
              text: "${item?.productId?.name ?? ""}",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_12),
            ),
            TextView(
              text:
                  "Available Quantity: ${(item?.productId?.wholesaleQuntity ?? 0)}",
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: font_12,
                  color: AppColors.gradient2nd),
            ).paddingOnly(top: margin_4),
          ],
        ),
        const Spacer(),
        Form(
          key: currentFormKey,
          child: SizedBox(
              width: Get.width / 3.5,
              height: height_40,
              child: InputQty.int(
                  // validator: (value) {
                  //   if (value == null) {
                  //     controller.debouncer(() {
                  //       item?.quantity = value;
                  //       controller.update();
                  //     });
                  //     return "Quantity is required";
                  //   }
                  //   return null;
                  // },
                  decoration: QtyDecorationProps(
                      minusBtn: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ).paddingOnly(left: margin_12),
                      plusBtn: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                      ).paddingOnly(right: margin_12),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.textfieldborder)),
                      contentPadding: EdgeInsets.symmetric(vertical: margin_10)),
                  initVal: controller.joinedCampaignDetailResponseModel?.data
                      ?.products?[index].quantity,/*controller.value ?? 1,*/
                  maxVal: item?.productId?.wholesaleQuntity,
                  minVal: 0,
                    validator: (value) {
                  if (value == null) {
                   return "Quantity is required";
                  }
            return null;
                },
                  onQtyChanged: (val) {
                    item?.quantity = val;
                    controller.updateCampaignApiCall();
                    controller.update();
                  })),
        ),
      ],
    ).paddingOnly(bottom: margin_15);
  }

  _detailsValue({key, keyTextstyle, value, valuetextstyle, icon}) => Row(
        children: [
          Expanded(
            child: TextView(
              maxLines: 3,
              text: key.toString(),
              textStyle: keyTextstyle ??
                  textStyleBodyMedium().copyWith(
                    fontSize: font_14,
                    fontWeight: FontWeight.w300,
                  ),
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
      ).paddingSymmetric(horizontal: margin_20).paddingOnly(top: margin_12);

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
                        "You are joining the campaign, if the campaign didn't reach its minimum quantity until ",
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

  _checkOut2() => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemDetailView(
                    controller.cartDataResponseModel?.data?.data?[0].productId),
                _dividerView(),
                // _expectedDeliveryDateView(controller
                //     .cartDataResponseModel?.data?.data?[0].productServices),
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
                    key:
                        "${strPrice.capitalize} (${controller.cartDataResponseModel?.data?.data?[0].quantity ?? 0} items)",
                    value:
                        "\$${controller.priceDetailsResponseModel?.data?.price ?? 0}",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_14, fontWeight: FontWeight.w500),
                    icon: false),
                _detailsValue(
                    key: strDiscount,
                    value:
                        "-\$${controller.priceDetailsResponseModel?.data?.discount.toStringAsFixed(2) ?? "0.00"}",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gradient2nd),
                    icon: false),
                _detailsValue(
                    key: strDeliveryCharges,
                    value: strFree,
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gradient2nd),
                    icon: false),
                const DottedLine(dashColor: AppColors.gradient2nd)
                    .paddingSymmetric(horizontal: margin_20)
                    .paddingOnly(top: margin_20),
                _detailsValue(
                    key: strTotalPrice,
                    keyTextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                    value:
                        "\$${controller.priceDetailsResponseModel?.data?.totalPrice ?? 0}",
                    valuetextstyle: textStyleBodyMedium().copyWith(
                        fontSize: font_16, fontWeight: FontWeight.w600),
                    icon: false),
                const DottedLine(dashColor: AppColors.gradient2nd)
                    .paddingSymmetric(
                        horizontal: margin_20, vertical: margin_12),
                _safetyNotes(),
              ],
            )),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppColors.borderColor, width: 1)),
            ),
            child: MaterialButtonWidget(
              minHeight: height_48,
              onPressed: () {
                if(controller.joinedCampaignDetailResponseModel?.data?.totalPrice!=0)
                // if((formKey1.currentState?.validate() ?? false) || (formKey2.currentState?.validate() ?? false))
                {
                  Get.toNamed(AppRoutes.manageAddressRoute, arguments: {
                    argIsForSelectAddress: true,
                    argCartDataResponceModel: controller.cartDataResponseModel,
                    argPriceDetailsResponceModel:
                    controller.priceDetailsResponseModel,
                  });
                }
                else if(controller.isRouteFromCampaignOrder==false)
                  {
                    Get.toNamed(AppRoutes.manageAddressRoute, arguments: {
                      argIsForSelectAddress: true,
                      argCartDataResponceModel: controller.cartDataResponseModel,
                      argPriceDetailsResponceModel:
                      controller.priceDetailsResponseModel,
                    });
                  }
                else if(controller.isRouteFromCampaignOrder==false)
                  {
                    Get.toNamed(AppRoutes.manageAddressRoute, arguments: {
                      argIsForSelectAddress: true,
                      argCartDataResponceModel: controller.cartDataResponseModel,
                      argPriceDetailsResponceModel:
                      controller.priceDetailsResponseModel,
                    });
                  }
                else
                  {
                    showToast(message: "Purchase a minimum of one product to start the campaign");
                  }

              },
              buttonText: strBtnProceedToAddress.toUpperCase(),
              buttonBgColor: AppColors.gradient2nd,
              buttonTextStyle: textStyleBodyMedium().copyWith(
                  fontSize: font_16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ).paddingOnly(
                top: margin_15,
                bottom: margin_42,
                left: margin_20,
                right: margin_20),
          )
        ],
      );

  _selectQuantityDropDown() => DropDownTextFieldWidget(
        borderColor: AppColors.borderColor,
        onFieldSubmitted: (value) {
          controller.onChangeDropDownValueQuantity(value);
        },
        hint: "1",
    Quantity: true,
        hintStyle: textStyleLabelLarge().copyWith(
            color: Colors.black,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.itemsCount,
        selectedItemTextStyle: textStyleLabelLarge().copyWith(
            color: AppColors.pricesColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        selectedValue: controller.selectedQuantityValue?.value,
      );

  // _expectedDeliveryDateView(List<ProductServices>? productServices) => Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             TextView(
  //               maxLines: 3,
  //               text: "Delivery by Wed Jan 6",
  //               textStyle: textStyleBodyMedium()
  //                   .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
  //             ),
  //             Container(
  //               color: Colors.black,
  //               height: height_15,
  //               width: 2,
  //             ).paddingSymmetric(horizontal: margin_8),
  //             TextView(
  //               maxLines: 1,
  //               text: strFree,
  //               textStyle: textStyleBodyMedium().copyWith(
  //                   color: AppColors.gradient2nd,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: font_14),
  //             ),
  //             TextView(
  //               maxLines: 3,
  //               text: " \$40",
  //               textStyle: textStyleBodyMedium().copyWith(
  //                   decoration: TextDecoration.lineThrough,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: font_14),
  //             ),
  //           ],
  //         ),
  //         TextView(
  //           maxLines: 3,
  //           text: productServices?[0].content ?? "",
  //           textStyle: textStyleBodyMedium().copyWith(
  //               color: AppColors.DustyGray,
  //               fontWeight: FontWeight.w400,
  //               fontSize: font_14),
  //         ),
  //       ],
  //     ).paddingAll(margin_20);
}
