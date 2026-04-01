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

import 'package:quantity_savers/generated/assets.dart';

import '../../../export.dart';

class CampaignItemCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String price;
  final String pricee;
  final String discount;
  final dynamic quantity;

  const CampaignItemCardWidget(
      {super.key,
      required this.price,
      required this.title,
      required this.description,
      required this.image,
      required this.pricee,
      required this.discount,
      this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_12),
          border: Border.all(color: AppColors.borderColor, width: width_2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width_70,
                child: NetworkImageWidget(
                  imageUrl: image ?? "",
                  imageHeight: height_100,
                  imageWidth: width_80,
                  imageFitType: BoxFit.contain,
                ),
              ).paddingOnly(right: margin_12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      maxLines: 3,
                      text: title ?? "",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w500, fontSize: font_14),
                    ),
                    SizedBox(height: 8,),
                    TextView(
                      maxLines: 3,
                      text: description ?? "",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: font_12,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        TextView(
                          text: "Price: ",
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: font_12,
                              color: Colors.grey),
                        ),
                        TextView(
                          text: "\$$price" ?? "",
                          textStyle: textStyleBodyMedium().copyWith(
                              fontSize: font_16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 2,),
                        TextView(
                          text: "\$$pricee" ?? "",
                          textStyle: textStyleBodyMedium().copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.DustyGray,
                              color: AppColors.DustyGray,
                              fontSize: font_16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 2,),
                        TextView(
                          text: discount ?? "",
                          textStyle: textStyleBodyMedium().copyWith(color: AppColors.gradient2nd,
                              fontSize: font_14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     TextView(
                    //       text: "Wholesale Price: ",
                    //       textStyle: textStyleBodyMedium().copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: font_12,
                    //           color: Colors.grey),
                    //     ),
                    //     TextView(
                    //       text: "\$$pricee" ?? "",
                    //       textStyle: textStyleBodyMedium().copyWith(
                    //           decoration: TextDecoration.lineThrough,
                    //           decorationColor: AppColors.DustyGray,
                    //           color: AppColors.DustyGray,
                    //           fontSize: font_16,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     TextView(
                    //       text: "Discount Price: ",
                    //       textStyle: textStyleBodyMedium().copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: font_12,
                    //           color: Colors.grey),
                    //     ),
                    //     TextView(
                    //       text: discount ?? "",
                    //       textStyle: textStyleBodyMedium().copyWith(color: AppColors.gradient2nd,
                    //           fontSize: font_14, fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
          Center(
            child: Container(
              height: height_40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_4),
                  color: AppColors.catBackgroundColor),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: "Minimum Quantity: ",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontSize: font_12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gradient2nd),
                    ),
                    TextView(
                      text: quantity.toString() ?? "",
                      textStyle: textStyleBodyMedium().copyWith(
                          fontSize: font_14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gradient2nd),
                    )
                  ],
                ),
              ),
            ).paddingSymmetric(vertical: margin_10),
          )
        ],
      ).paddingSymmetric(vertical: margin_10, horizontal: margin_20),
    ).paddingSymmetric(vertical: margin_8);
  }
}
