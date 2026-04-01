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

import 'package:flutter/cupertino.dart';
import '../../../core/utils/input_qty/lib/src/decoration_props.dart';
import '../../../core/utils/input_qty/lib/src/input_qty.dart';
import '../../../export.dart';

class StartCampaignSecondScreen extends StatelessWidget {
  final controller = Get.put(StartCampaignSecondController());
  final themeController = Get.put(ThemeController());
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  StartCampaignSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartCampaignSecondController>(
        init: StartCampaignSecondController(),
        builder: (context) {
          return Scaffold(
              appBar: CustomAppBar(
                appBarTitleText: controller.isRouteFromCampaignDetails == true
                    ? strJoinCampaign.toUpperCase()
                    : strStartCampaign.toUpperCase(),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            controller.join == true
                                ? _warningMessage()
                                : SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            controller.join == true
                                ? SizedBox(
                                    height: 10,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            _titleWithStep(),
                            controller.isRouteFromCampaignDetails == true
                                ? CampaignItemCardWidget(
                                    price:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.wholesalePrice}",
                                    title:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.name}",
                                    description:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.description}",
                                    image:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.images?[0]}",
                                    quantity:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.campaignQuantity ?? 0}",
                                    pricee:
                                        "${controller.campaignDetailsResponseModel.data?.productDetails?.price ?? 0}",
                                    discount:
                                        "${(controller.getDiscountedPercentage()).toStringAsFixed(2)}%",
                                  )
                                : CampaignItemCardWidget(
                                    price:
                                        "${controller.productDetails?.data?.wholesalePrice}",
                                    title:
                                        "${controller.productDetails?.data?.name}",
                                    description:
                                        "${controller.productDetails?.data?.description}",
                                    image:
                                        "${controller.productDetails?.data?.images?[0]}",
                                    quantity:
                                        "${controller.productDetails?.data?.campaignQuantity ?? 0}",
                                    pricee:
                                        "${controller.productDetails?.data?.price ?? 0}",
                                    discount:
                                        "${(controller.getDiscountPercentage()).toStringAsFixed(2)}%",
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.catBackgroundColor,
                                  borderRadius: BorderRadius.circular(radius_10)),
                              child: TextView(
                                maxLines: 3,
                                text:
                                    "You need to buy at least 1 product to start the campaign. ",
                                textStyle: textStyleBodyMedium().copyWith(
                                  fontSize: font_14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ).paddingOnly(left: margin_8,right: margin_8,top: margin_8,bottom: margin_8),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  controller.isRouteFromCampaignDetails == true
                                      ? controller
                                              .campaignDetailsResponseModel
                                              .data
                                              ?.productDetails
                                              ?.productVariations
                                              ?.length ??
                                          0
                                      : controller.productDetails?.data
                                              ?.productVariations?.length ??
                                          0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {},
                                  child:
                                      controller.isRouteFromCampaignDetails ==
                                              true
                                          ? _itemQuantityCard(
                                              controller
                                                  .campaignDetailsResponseModel
                                                  .data
                                                  ?.productDetails
                                                  ?.productVariations?[index],
                                              index)
                                          : _itemQuantityCard(
                                              controller.productDetails?.data
                                                  ?.productVariations?[index],
                                              index),
                                );
                              },
                            ),
                          ],
                        ).paddingSymmetric(
                            vertical: margin_20, horizontal: margin_20),
                      ],
                    )),
                  ),
                  Container(
                    child: (controller.isRouteFromCampaignDetails == true)
                        ? MaterialButtonWidget(
                            onPressed: () {
                              {
                                if ((formKey1.currentState?.validate() ??
                                        false) ||
                                    (formKey2.currentState?.validate() ??
                                        false)) {
                                  controller.hitJoinCampaignApiCall();
                                } else {
                                  showToast(
                                      message: "Purchase a minimum of one product to start the campaign");
                                }
                              }
                            },
                            buttonText: strJoinCampaign.toUpperCase(),
                            minHeight: height_44,
                            buttonBgColor: AppColors.gradient2nd,
                            buttonTextStyle: textStyleBodyMedium().copyWith(
                                fontSize: font_14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ).paddingOnly(
                            top: margin_20,
                            bottom: margin_42,
                            left: margin_20,
                            right: margin_20)
                        : _stepsWithButton().paddingOnly(bottom: margin_12),
                  ),
                ],
              ));
        });
  }

  _titleWithStep() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AssetSVGWidget(iconsStep2).paddingOnly(top: margin_4),
          Expanded(
            child: TextView(
              maxLines: 3,
              text: strSelectQuantity,
              textStyle: textStyleBodyMedium().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w500,
              ),
            ).paddingOnly(left: margin_8),
          )
        ],
      );

  _warningMessage() => Container(
        decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            borderRadius: BorderRadius.circular(radius_10)),
        child: TextView(
          maxLines: 3,
          text: "Note: You can not exit the campaign when only 4 hours left.",
          textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_14,
            fontWeight: FontWeight.w500,
          ),
        ).paddingOnly(left: margin_8,right: margin_8,top: margin_8,bottom: margin_8),
      );

  _dividerView() => SizedBox(
        height: margin_4,
        child: Divider(
          thickness: margin_1,
          color: Colors.grey.shade300,
        ),
      );

  Widget _stepsWithButton() {
    return Column(
      children: [
        _dividerView(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: TextView(
                text: "Step 2 of 2",
                textStyle: textStyleBodyMedium().copyWith(
                    color: AppColors.categoriesgrey,
                    fontWeight: FontWeight.w500,
                    fontSize: font_14),
              ),
            ),
            Expanded(
              flex: 2,
              child: MaterialButtonWidget(
                onPressed: () {
                  if ((formKey1.currentState?.validate() ?? false) ||
                      (formKey2.currentState?.validate() ?? false)) {
                    controller.hitJoinCampaignApiCall();
                  } else {
                    showToast(message: "Purchase a minimum of one product to start the campaign");
                  }
                },
                buttonText: strStartCampaign.toUpperCase(),
                buttonBgColor: AppColors.gradient2nd,
                buttonRadius: margin_10,
                buttonTextStyle: textStyleBodyMedium().copyWith(
                    color: Colors.white,
                    fontSize: font_14,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ).paddingSymmetric(vertical: margin_20, horizontal: margin_20),
      ],
    );
  }

  _itemQuantityCard(
    dynamic productVariation,
    int index,
  ) {
    GlobalKey<FormState> currentFormKey = index % 2 == 0 ? formKey1 : formKey2;
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(margin_10),
          border: Border.all(color: AppColors.gradient2nd, width: margin_1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: "${productVariation?.name}",
            textStyle: textStyleBodyMedium()
                .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
          ),
          TextView(
            text:
                "Available Quantity: ${productVariation?.wholesaleQuntity ?? 0}",
            textStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: font_14,
                color: AppColors.gradient2nd),
          ).paddingSymmetric(vertical: margin_8),
          Form(
            key: currentFormKey,
            child: SizedBox(
                width: Get.width / 2.8,
                child: InputQty.int(
                    validator: (value) {
                      if (value == null) {
                        controller.debouncer(() {
                          controller.updateSelectedQuantity(
                              val.toString(), index);
                        });
                        return "Quantity is required";
                      }
                      return null;
                    },
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
                        // isBordered: false,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: margin_10)),
                    initVal: productVariation?.quantity,
                    maxVal: productVariation?.wholesaleQuntity,
                    minVal: 0,
                    onQtyChanged: (val) {
                      controller.updateSelectedQuantity(val.toString(), index);
                    })),
          ),
        ],
      ).paddingSymmetric(vertical: margin_15, horizontal: margin_15),
    ).paddingSymmetric(vertical: margin_15);
  }
}
