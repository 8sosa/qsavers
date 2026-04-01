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

import 'package:quantity_savers/app/modules/Details/controllers/all_faqs_controller.dart';
import 'package:quantity_savers/app/modules/Details/controllers/all_product_faq_controller.dart';

import '../../../export.dart';
import '../models/data_models/product_faq_data_model.dart';

class AllProductFAQsScreen extends StatelessWidget {
  final controller = Get.put(AllProductFAQsController());
  final themeController = Get.put(ThemeController());

  AllProductFAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductFAQsController>(
        init: AllProductFAQsController(),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Get.back(result: {argIndex: true});
              return Future.value(true);
            },
            child: Shimmer(
              child: Scaffold(
                appBar: CustomAppBar(appBarTitleText: strFaq,onTap: (){
                  Get.back(result: {argIndex:true});
                },),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [_faqS(controller.productFaqResponseModel.data)],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _faqS(List<ProductFaqDataModel>? data ) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20,),
      _questionAnswerList(data)
    ],
  );

  _questionAnswerList(dynamic data) => ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: data?.length ?? 0,
    padding: EdgeInsets.all(margin_0),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          _questionAnswersWithLikeUnlike(data?[index]),
          _ratingReviewDivider()
        ],
      );
    },
  );

  _questionAnswersWithLikeUnlike(dynamic data) => Column(
    children: [
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Q: ",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: font_14,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: TextView(
                  text: "${data?.question}",
                  maxLines: 10,
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: font_14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "A: ",
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontSize: font_14,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: TextView(
                  text: removeAllHtmlTags(data?.answer),
                  maxLines: 10,
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: font_14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: margin_10),
          Row(
            children: [
              TextView(
                text: "${data?.sellerId?.name}",
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.categoriesgrey,
                    fontSize: font_14,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              _questionsLikesCount(count: data?.totalLikes,id:data?.sId,like: data?.isLiked),
              _questionsDisLikesCount(count: data?.totalDislikes,id:data?.sId,dislike: data?.isDisliked)
            ],
          )
        ],
      ).paddingSymmetric(horizontal: margin_20),
    ],
  );

  _questionsLikesCount({count,id,like})
  {
    return  InkWell(
      onTap: ()
      {
        controller.hitLikeProductFaq(id,"LIKE");
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          like==true?const AssetSVGWidget(iconsThumbUp,color: AppColors.gradient2nd,):const AssetSVGWidget(iconsThumbUp),
         count>0? TextView(
            text: "$count",
            textStyle: textStyleTitleLarge().copyWith(
                color: AppColors.categoriesgrey,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ).paddingOnly(left: margin_10):emptySizeBox()
        ],
      ),
    );
  }


  _questionsDisLikesCount({count,id,dislike}) => InkWell(
    onTap: ()
    {
      controller.hitLikeProductFaq(id, "DISLIKE");
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        dislike==true?const AssetSVGWidget(iconsThumbDown,color: AppColors.gradient2nd,):const AssetSVGWidget(iconsThumbDown),
       count>0? TextView(
          text: "$count",
          textStyle: textStyleTitleLarge().copyWith(
              color: AppColors.categoriesgrey,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ).paddingOnly(left: margin_10):emptySizeBox()
      ],
    ).paddingOnly(left: margin_20),
  );

  _ratingReviewDivider() => SizedBox(
    height: margin_4,
    child: Divider(
      thickness: margin_1,
      color: AppColors.borderColor,
    ),
  ).paddingSymmetric(vertical: margin_20);
}
