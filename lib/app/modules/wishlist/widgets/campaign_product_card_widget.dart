import "package:quantity_savers/app/core/utils/time_conversion.dart";
import "package:quantity_savers/app/modules/home/widgets/counter_widget.dart";
import "package:quantity_savers/app/modules/wishlist/models/data_models/wishlist_data_model.dart";

import "../../../export.dart";

class CampaignProductCardWidget extends StatelessWidget {
  WishlistDataSubModel? data;

  CampaignProductCardWidget({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height_140,
          child: Stack(
            children: [
              Positioned.fill(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: NetworkImageWidget(
                  imageUrl: data?.campaignId?.image ?? "",
                  imageHeight: height_60,
                  imageWidth: height_70,
                  imageFitType: BoxFit.cover,
                ),
              )),
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  children: [
                    if (data?.campaignId?.isLive == true) ...[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            const AssetSVGWidget(iconsLive),
                            TextView(
                              text: "Streaming Live Now",
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                            )
                          ],
                        ).paddingAll(margin_4),
                      ),
                    ],
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          Get.find<WishlistController>()
                              .hitDeleteFromWishlistApi(data?.campaignId?.sId);
                        },
                        child: AssetSVGWidget((data?.inWishlist == true)
                            ? iconsHeartlikered
                            : iconsHeartDisLike)),
                  ],
                ),
              ),
              Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: CountDownWidget(
                            time: DateTime.fromMillisecondsSinceEpoch(
                                data?.campaignId?.endDate ?? 0))
                        .paddingSymmetric(
                            vertical: margin_2, horizontal: margin_8),
                  ))
            ],
          ),
        ),
        _titleAndPriceInfo(),
        _ratingInfo(),
        _durationInfo(),
        _userJoinedInfo()
      ],
    ).paddingAll(margin_16);
  }

  _titleAndPriceInfo() => Row(
        children: [
          TextView(
            text: "${data?.campaignId?.campaignName}",
            textStyle: textStyleBodyLarge().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: font_16),
          ),
          const Spacer(),
          TextView(
            text: "\$${data?.campaignId?.oneProductPrice}",
            textStyle: textStyleBodyLarge().copyWith(
                color: AppColors.gradient2nd,
                fontWeight: FontWeight.w700,
                fontSize: font_16),
          ),
        ],
      ).paddingSymmetric(vertical: margin_8);

  _ratingInfo() => Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.dividerColor,
              borderRadius: BorderRadius.all(Radius.circular(radius_6)),
            ),
            child: TextView(
              text:
                  "${data?.campaignId?.quantity}/${data?.campaignId?.totalQuantity}",
              textStyle: textStyleBodyLarge().copyWith(
                  color: AppColors.gradient2nd,
                  fontWeight: FontWeight.w600,
                  fontSize: font_12),
            ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.catBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(radius_6)),
            ),
            child: TextView(
              text: "${data?.campaignId?.productId?.name}",
              textStyle: textStyleBodyLarge().copyWith(
                  color: AppColors.gradientColorSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: font_12),
            ).paddingSymmetric(vertical: margin_4, horizontal: margin_8),
          ).paddingOnly(left: margin_16),
          const Spacer(),
          AssetSVGWidget(
            imageHeight: height_20,
            iconsStar,
            color: AppColors.gradient2nd,
          ).paddingOnly(right: margin_4),
          TextView(
            text: "${data?.campaignId?.productId?.averageRating}",
            textStyle: textStyleBodyLarge().copyWith(
                color: AppColors.gradientColorSecondary,
                fontWeight: FontWeight.w600,
                fontSize: font_14),
          )
        ],
      );

  _durationInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
            children: [
              const AssetSVGWidget(iconsClockGreen),
              TextView(
                text: "Campaign duration: ",
                textStyle: textStyleBodyLarge().copyWith(
                    color: AppColors.bottombarColor,
                    fontWeight: FontWeight.w500,
                    fontSize: font_12),
              ).paddingOnly(left: margin_8),

            ],
          ),
      TextView(
        text:
        "${millisecondsToCustomDateFormat(data?.campaignId?.startDate ?? 0)} - ${millisecondsToCustomDateFormat(data?.campaignId?.endDate ?? 0)}",
        textStyle: textStyleBodyLarge().copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: font_12),
      )
    ],
  ).paddingSymmetric(vertical: margin_8);

  _userJoinedInfo() => Row(
        children: [
          const AssetSVGWidget(Assets.iconsUserGreen),
          TextView(
            text: "User joined: ",
            textStyle: textStyleBodyLarge().copyWith(
                color: AppColors.bottombarColor,
                fontWeight: FontWeight.w500,
                fontSize: font_12),
          ).paddingOnly(left: margin_8),
          TextView(
            text: "${data?.campaignId?.userJoined}",
            textStyle: textStyleBodyLarge().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: font_12),
          )
        ],
      );
}
