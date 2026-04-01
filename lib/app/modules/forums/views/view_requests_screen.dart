import "package:quantity_savers/app/core/utils/time_conversion.dart";

import "../../../export.dart";

class ViewRequestsScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final controller = Get.put(ViewRequestsController());

  ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewRequestsController>(
        init: ViewRequestsController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(appBarTitleText: controller.groupName),
            body: Container(
              padding: EdgeInsets.all(margin_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    textAlign: TextAlign.center,
                    text:
                        "$strRequests (${controller.forumRequestMembersResponseModel.data?.length ?? 0})",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: font_18),
                  ).paddingOnly(bottom: margin_16),
                  Expanded(
                      child: ListView.separated(
                    itemCount: controller
                            .forumRequestMembersResponseModel.data?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return _requestsListItem(index);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: margin_12),
                        child: const Divider(
                          color: AppColors.borderColor,
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          );
        });
  }

  _requestsListItem(int index) => InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
            argGroupRequestId:
                controller.forumRequestMembersResponseModel.data?[index].sId,
            argGroupId: controller.groupId,
            argGroupName: controller.groupName,
            argIsRouteFromViewRequest: true
          });
          controller.update();
        },
        child: Row(
          children: [
            NetworkImageWidget(
                    imageUrl: controller.forumRequestMembersResponseModel
                            .data?[index].sentBy?.profilePic ??
                        "",
                    imageHeight: height_45,
                    imageWidth: height_45,
                    radiusAll: radius_50,
                    imageFitType: BoxFit.fill,
                    placeHolder: iconsProfilePlaceholderS)
                .paddingOnly(right: margin_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text:
                            "${controller.forumRequestMembersResponseModel.data?[index].sentBy?.name}",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font_16),
                      ),
                      const Spacer(),
                      TextView(
                        text: formatMillisecondsToHhMm(controller
                            .forumRequestMembersResponseModel
                            .data?[index]
                            .createdAt),
                        textStyle: textStyleBodyMedium().copyWith(
                            color: AppColors.DustyGray,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12),
                      ),
                    ],
                  ),
                  TextView(
                    text:
                        "${controller.forumRequestMembersResponseModel.data?[index].message}",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_12),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
