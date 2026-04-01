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

import 'package:story_view/controller/story_controller.dart';

import '../../../export.dart';

class ReviewsDetailsController extends GetxController with GetSingleTickerProviderStateMixin{
  final APIRepository _repository = Get.find<APIRepository>();
  final StoryController storyController = StoryController();
 var images=false;
 var imageUrl;
 var videoUrl;
 var video;
 var title;
 var description;
 var rating;
 var userName;
 var updatedAt;

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    super.onInit();
    getArguments();
  }

  getArguments()
  {
    if(Get.arguments!=null)
      {
        images=Get.arguments[argForImages] ?? false;
        imageUrl=Get.arguments[argForImagesUrl];
        videoUrl=Get.arguments[argForVideoUrl];
        if(videoUrl!=null)
          {
            video="https://quantitysavers-live.s3.amazonaws.com/quantitysavers-live/video/${videoUrl}";
            title=Get.arguments[argTitle];
            description=Get.arguments[argDescription];
            rating=Get.arguments[argRating];
            userName=Get.arguments[argUserName]??"";
            updatedAt=Get.arguments[argUpdatedAt]??"";
            debugPrint("It is $video");
          }

      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}