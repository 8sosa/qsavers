import 'package:quantity_savers/app/core/widget/customtabindicator.dart';
import 'package:quantity_savers/app/core/widget/image_preview_widget.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';
import 'package:quantity_savers/generated/assets.dart';

import '../../../core/widget/video_player_widget/media_file.dart';
import '../../../export.dart';
import '../controllers/forum_media_controller.dart';

class ForumMediaScreen extends StatelessWidget {
  final controller = Get.put(ForumMediaController());
  final themeController = Get.put(ThemeController());

  ForumMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForumMediaController>(
        init: ForumMediaController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: "MEDIA",
              isBottomWidget: true,
              bottomWidget: TabBar(
                controller: controller.tabController,
                indicatorColor: Colors.white,
                indicator: CustomTabIndicator(),
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                labelColor: Colors.white,
                labelStyle: textStyleTitleLarge()
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => controller.onTabChanged(index),
                tabs: const [
                  Tab(text: "Images"),
                  Tab(text: "Docs"),
                  Tab(text: "Links"),
                  Tab(text: "Videos")
                ],
              ),
            ),
            body:controller.isLoading==true? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.gradient2nd,
                )): TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                controller.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.gradient2nd,
                      ))
                    : controller.forumMediaResponseModel.data?.data?.length==0?_noCouponScreen():_tabBarData(),
                controller.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.gradient2nd,
                      ))
                    :controller.forumMediaResponseModel.data?.data?.length==0?_noCouponScreen():_tabBarData(),
                controller.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.gradient2nd,
                      ))
                    : controller.forumMediaResponseModel.data?.data?.length==0?_noCouponScreen():_tabBarData(),
                controller.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.gradient2nd,
                      ))
                    : controller.forumMediaResponseModel.data?.data?.length==0?_noCouponScreen():_tabBarData(),
              ],
            ),
          );
        });
  }

  _tabBarData() {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.forumMediaResponseModel.data?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return card(index);
        },
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_10),
    );
  }

  card(index) => Column(
    children: [
      InkWell(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor, width: 2)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (controller.currentIndex == 0) ...[
                          InkWell(
                            onTap: () {
                              Get.dialog(ImagePreviewWidget(
                                imageProvider:
                                    "${controller.forumMediaResponseModel.data?.data?[index].mediaUrl}",
                              ));
                            },
                            child: NetworkImageWidget(
                              imageUrl:
                                  "${controller.forumMediaResponseModel.data?.data?[index].mediaUrl}",
                              imageHeight: height_70,
                              imageWidth: height_80,
                              imageFitType: BoxFit.cover,
                              radiusAll: radius_5,
                            ).paddingOnly(
                                top: margin_2,
                                right: margin_2,
                                left: margin_2,
                                bottom: margin_2),
                          ),
                        ] else if (controller.currentIndex == 1) ...[
                          AssetSVGWidget(
                            iconsDoc,
                            imageHeight: height_40,
                            imageWidth: height_40,
                          ).paddingOnly(left: margin_15, top: margin_15),
                        ] else if (controller.currentIndex == 2) ...[
                          AssetSVGWidget(
                            iconsDoc,
                            imageHeight: height_40,
                            imageWidth: height_40,
                          ).paddingOnly(left: margin_15, top: margin_15),
                        ] else if (controller.currentIndex == 3) ...[
                          VideoPreviewWidget(
                            mediaFile: MediaFile(
                              networkPath: controller.forumMediaResponseModel.data
                                  ?.data?[index].mediaUrl,
                            ),
                            height: height_80,
                            width: height_80,
                            padding: 60,
                          )
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextView(
                                maxLines: 1,
                                text:
                                    "${controller.forumMediaResponseModel.data?.data?[index].mediaUrl}",
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ).paddingOnly(left: margin_30, top: margin_16),
                              controller.currentIndex == 1
                                  ? TextView(
                                      maxLines: 1,
                                      text:
                                          "Shared by: ${controller.forumMediaResponseModel.data?.data?[index].sentBy?.name}",
                                      textStyle: textStyleBodyMedium().copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ).paddingOnly(left: margin_30, top: margin_16,bottom: margin_8)
                                  : TextView(
                                      maxLines: 1,
                                      text:
                                          "Shared by: ${controller.forumMediaResponseModel.data?.data?[index].sentBy?.name}",
                                      textStyle: textStyleBodyMedium().copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ).paddingOnly(left: margin_30, top: margin_16),
                            ],
                          ),
                        )
                      ],
                    )
                  ]))),
      SizedBox(height: 10,),
    ],
  );

  _noCouponScreen() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AssetSVGWidget(iconsNotPurchased)
            .paddingOnly(bottom: margin_20),
        TextView(
          text: strNoDataFound,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ).paddingOnly(bottom: margin_16),
      ],
    ),
  );
}
