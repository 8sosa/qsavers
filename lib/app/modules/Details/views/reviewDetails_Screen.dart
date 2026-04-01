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
import 'package:quantity_savers/app/core/utils/read_more.dart';
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/modules/Details/controllers/reviewDetails_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../export.dart';

class ReviewsDetailsScreen extends StatelessWidget {
  final controller = Get.put(ReviewsDetailsController());
  final themeController = Get.put(ThemeController());

  ReviewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsDetailsController>(
        init: ReviewsDetailsController(),
        builder: (context) {
          return Scaffold(
            body: controller.images == true
                ? Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        child: Center(
                          child: NetworkImageWidget(
                            imageUrl: controller.imageUrl,
                            imageWidth: Get.width,
                            imageHeight: Get.height / 2,
                            imageFitType: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 300,
                        right: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      StoryView(
                        controller: controller.storyController,
                        storyItems: [
                          // StoryItem.text(
                          //     title: "title", backgroundColor: Colors.cyan),
                          // StoryItem.inlineImage(
                          //   url:
                          //   "https://fastly.picsum.photos/id/1015/200/300.jpg?hmac=Rx9zhHRx_cf574gBuoMH5d7HlhZitGMA81AgPmhJDSI",
                          //   controller: controller.storyController,
                          //
                          // ),
                          StoryItem.pageVideo("${controller.video}",
                              // "https://www.taxmann.com/emailer/images/CompaniesAct.mp4",
                              controller: controller.storyController)
                          // Add more story items as needed
                        ],
                        // onStoryShow: () {
                        //   print('Story shown: $storyItem');
                        // },
                        onComplete: () {
                          print('All stories have been viewed');
                          Get.back();
                        },
                      ),
                      Positioned(
                          top: 120,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: controller.rating.toDouble(),
                                    itemSize: 25,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: AppColors.gradient2nd,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextView(
                                      text: "${controller.title.toString()}",
                                      textStyle: textStyleTitleLarge().copyWith(
                                          color: AppColors.storyTitleColor,
                                          fontSize: font_16,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              ReadMoreTextWidget(
                                  text: "${controller.description.toString()}",
                                  textStyle: textStyleTitleLarge().copyWith(
                                      color: AppColors.storyTitleColor,
                                      fontSize: font_12,
                                      fontWeight: FontWeight.w400)),
                              Row(
                                children: [
                                  TextView(
                                    text: "${controller.userName}",
                                    textStyle: textStyleTitleLarge().copyWith(
                                        color: AppColors.storyTitleColor,
                                        fontSize: font_12,
                                        fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 5,),

                                  SizedBox(
                                    height: 14,
                                    width: 5,
                                    child: VerticalDivider(
                                      indent: 2,
                                      thickness: 1,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  TextView(
                                    text: " ${convertMillisecondsToTimeAgo(int.parse(controller.updatedAt))}",
                                    textStyle: textStyleTitleLarge().copyWith(
                                        color: AppColors.storyTitleColor,
                                        fontSize: font_12,
                                        fontWeight: FontWeight.w400)),
                                ],
                              )

                            ],
                          ).paddingOnly(left: margin_10)),
                    ],
                  ),
          );
        });
  }
}
