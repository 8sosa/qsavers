import "../../export.dart";

class ProductCardWidget extends StatelessWidget {
  final String rating;
  final String name;
  final String description;
  final String sellingPrice;
  final String markPrice;
  final String discount;
  final String totalReviews;
  final String imageUrl;
  final bool? isOnWishlist;
  final ontap;

  const ProductCardWidget(
      {super.key,
      required this.rating,
      required this.name,
      required this.description,
      required this.sellingPrice,
      required this.markPrice,
      required this.discount,
      required this.totalReviews,
      required this.imageUrl,
      required this.isOnWishlist,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            child: Stack(
              children: [
                NetworkImageWidget(
                                  imageUrl: imageUrl ?? "",
                                  imageHeight: height_150,
                                  imageWidth: width_150,
                                  imageFitType: BoxFit.cover,
                                  radiusAll: 6,
                                ).paddingOnly(right: margin_12),
                if (rating != "0.0" && totalReviews != "0") ...[
                  Positioned(
                      bottom: 12,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            TextView(
                              text: rating,
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: Colors.black,
                                  fontSize: font_14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const AssetSVGWidget(
                              iconsRatingStar,
                              color: AppColors.gradient2nd,
                            ).paddingSymmetric(horizontal: margin_4),
                            SizedBox(
                              height: height_10,
                              width: width_4,
                              child: const VerticalDivider(
                                thickness: 2,
                                color: Colors.black,
                              ),
                            ),
                            TextView(
                              text: totalReviews,
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: Colors.black,
                                  fontSize: font_14,
                                  fontWeight: FontWeight.w600),
                            ).paddingOnly(left: margin_4)
                          ],
                        ).paddingSymmetric(
                            vertical: margin_2, horizontal: margin_8),
                      ))
                ]
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: TextView(
              text: name,
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: font_16),
            ),
          ),
          IconButton(
            onPressed: ontap,
            icon: AssetSVGWidget((isOnWishlist == true)
                ? iconsHeartlikered
                : iconsHeartDisLike,),
          ),
        ]),
        TextView(
          text: description,
          maxLines: 1,
          textStyle: textStyleTitleLarge().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: font_16),
        ).paddingOnly(top: margin_2),
        Row(
          children: [
            TextView(
              text: "\$$sellingPrice",
              textStyle: textStyleTitleLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ),
            TextView(
              text: "\$$markPrice",
              textStyle: textStyleTitleLarge().copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: font_14,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.DustyGray,
              ),
            ).paddingOnly(left: margin_4),
            TextView(
              text: "$discount% off",
              textStyle: textStyleTitleLarge().copyWith(
                  color: AppColors.gradient2nd,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).paddingOnly(left: margin_4)
          ],
        ).paddingOnly(top: margin_10)
      ],
    ).paddingOnly(left: margin_0);
  }
}
