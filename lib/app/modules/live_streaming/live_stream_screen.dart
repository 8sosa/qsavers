import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_overlay/heart_overlay.dart';
import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/modules/live_streaming/heart_animation.dart';
import 'package:quantity_savers/app/modules/live_streaming/live_streaming_controller.dart';

import '../../core/widget/botom_btn_widget.dart';
import '../../export.dart';
import 'heart_animation_show.dart';

class LiveScreen extends StatelessWidget {
  final controller = Get.put(LiveController());
  final themeController = Get.put(ThemeController());
  LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await controller.handleBackButton();
      },
      child: GetBuilder<LiveController>(
          init: LiveController(),
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  child: SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: _bodyWidget())),
            );
          }),
    );
  }

  Widget _bodyWidget() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: [
        (controller.engine != null) ? _singleVideoWidget() : const SizedBox(),
        _upperWidget()
      ],
    );
  }

  Widget _singleVideoWidget() {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            clipBehavior: Clip.hardEdge,
            child:controller.cameraOn.value==false?Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.lightBlackColor
              ),
            ): AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: controller.engine!,
                canvas: VideoCanvas(uid: controller.shownId),
              ),
              onAgoraVideoViewCreated: (viewId) {
                controller.engine?.startPreview();
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.cameraOn.value == false &&
                  controller.micOn.value == false) ...[
                Center(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.mic_off,
                        size: 60.0,
                        color: Colors.white,
                      ).paddingOnly(left: 40),
                      const SizedBox(width: 50,),
                      NetworkImageWidget(
                        imageUrl: controller.productImage ?? "",
                        imageWidth: height_150,
                        imageHeight: height_150,
                        radiusAll: radius_100,
                        imageFitType: BoxFit.cover,
                        placeHolder: iconsProfilePlaceholderL,
                      ).paddingOnly(right: 20),
                    ],
                  ),
                ),
              ] else if (controller.cameraOn.value == false) ...[
                NetworkImageWidget(
                  imageUrl: controller.productImage ?? "",
                  imageWidth: height_150,
                  imageHeight: height_150,
                  radiusAll: radius_100,
                  imageFitType: BoxFit.cover,
                  placeHolder: iconsProfilePlaceholderL,
                ).paddingOnly(left: 100, right: 100),
              ] else if (controller.micOn.value == false) ...[
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      width: Get.width,
                      height: height_55,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.mic_off,
                        size: 30.0,
                        color: Colors.black,
                      )).paddingOnly(left: 100, right: 100),
                ),
              ],
            ],
          ).paddingOnly(top: Get.height / 2-100),
        ],
      ),
    );
  }

  Widget _upperWidget() {
    return Column(
      children: [
        SafeArea(child: _liveUsersStack()),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _commentsList()),
                  Container(
                    height: height_300,
                    width: margin_80,
                    child: ListView(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [...controller.hearts],
                    ),
                  ),
                ],
              ),
            ),
            // _commentsList(),
            (controller.createdById != controller.userLoggedInId)
                ? _bottomInputField()
                : Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.only(right: 30.0, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          Spacer(
                            flex: 500,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: IconButton(
                              icon: Icon(
                                controller.micOn.value
                                    ? Icons.mic
                                    : Icons.mic_off,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                controller.toggleMic();
                              },
                            ),
                          ),
                          Spacer(flex: 2),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: IconButton(
                              icon: Icon(
                                controller.cameraOn.value
                                    ? Icons.videocam
                                    : Icons.videocam_off,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                controller.toggleCamera();
                              },
                            ),
                          ),
                          Spacer(flex: 2),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                Assets.iconsCroses,
                                width: 20.0,
                                height: 20,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.dialog(CustomDialogWidget(
                                  title: strEndLiveStream,
                                  confirmTitle: strYes,
                                  cancelTitle: strNo,
                                  confirmBtnBgColor: Colors.red,
                                  cancelTitleColor:
                                      AppColors.gradientColorSecondary,
                                  cancelBtnBorder: Border.all(
                                      color: AppColors.borderColor, width: 1),
                                  cancelBtnBgColor: Colors.transparent,
                                  onTapConfirm: () {
                                    controller.hitLeaveCall();
                                    Get.back();
                                  },
                                  isImage: false,
                                  isCloseBtn: true,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).paddingOnly(right: 100,bottom: 5),
            (controller.createdById != controller.userLoggedInId)
                ? BotomButtonWidget(
                    btnTitle: "VIEW CAMPAIGN",
                    onPressed: () {
                      Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
                          arguments: {
                            argLiveStream: true,
                            argCampaignId: controller.campaignId
                          });
                    },
                    iconWidget: AssetSVGWidget(
                      Assets.iconsExclamationGray,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox()
          ],
        ))
      ],
    );
  }

  Widget _liveUsersStack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_usersStackAndLiveIcon(), _liveCountIconAndCross()],
    ).paddingSymmetric(horizontal: margin_15).paddingOnly(top: margin_15);
  }

  Widget _usersStackAndLiveIcon() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Stack(
                  alignment: Alignment.centerLeft,
                  textDirection: TextDirection.rtl,
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: List.generate(
                      (1),
                      (index) => Container(
                            height: height_40,
                            width: width_40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: height_1, color: Colors.white),
                                shape: BoxShape.circle),
                            child: NetworkImageWidget(
                              imageUrl: controller.profilePic ?? "",
                              imageWidth: height_40,
                              imageHeight: height_40,
                              radiusAll: radius_100,
                              imageFitType: BoxFit.cover,
                              placeHolder: iconsProfilePlaceholderL,
                            ),
                          ).paddingOnly(left: index * margin_20))),
              Positioned(
                bottom: -height_5,
                child: Container(
                  height: height_15,
                  width: height_38,
                  decoration: BoxDecoration(
                      border: Border.all(width: height_1, color: Colors.white),
                      borderRadius: BorderRadius.circular(radius_3),
                      color: Colors.red),
                  child: Center(
                    child: TextView(
                      text: strLive.toUpperCase(),
                      textStyle: textStyleBodySmall().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
                    text: controller.creatorName,
                    textStyle: textStyleBodySmall().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16))
                .paddingOnly(left: 20, top: 10),
            TextView(
                    text: controller.campaignName,
                    textStyle: textStyleBodySmall().copyWith(
                        color: Colors.white.withOpacity(0.3),
                        fontWeight: FontWeight.w500,
                        fontSize: 16))
                .paddingOnly(left: 20)
          ],
        )
      ],
    );
  }

  Widget _liveCountIconAndCross() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_5),
                color: Colors.black38),
            child: Row(
              children: [
                AssetSVGWidget(
                  iconsEye,
                  imageWidth: height_14,
                  imageHeight: height_14,
                ),
                Obx(() => TextView(
                      text: (controller.userLoggedInId ==
                              controller.createdById)
                          ? controller.remoteViewerIds.length.toString()
                          : (controller.remoteViewerIds.length > 1
                              ? (controller.remoteViewerIds.length - 1)
                                  .toString()
                              : controller.remoteViewerIds.length.toString()),
                      textStyle: textStyleTitleSmall().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ).paddingOnly(left: margin_5)),
              ],
            ).paddingSymmetric(horizontal: margin_8, vertical: margin_5),
          ),
        ),
        controller.userType == 0
            ? GestureDetector(
                onTap: () {
                  if (controller.createdById == controller.userLoggedInId) {
                    Get.dialog(CustomDialogWidget(
                      title: strEndLiveStream,
                      confirmTitle: strYes,
                      cancelTitle: strNo,
                      confirmBtnBgColor: Colors.red,
                      cancelTitleColor: AppColors.gradientColorSecondary,
                      cancelBtnBorder:
                          Border.all(color: AppColors.borderColor, width: 1),
                      cancelBtnBgColor: Colors.transparent,
                      onTapConfirm: () {
                        controller.hitLeaveCall();
                        Get.back();
                      },
                      isImage: false,
                      isCloseBtn: true,
                    ));
                  } else {
                    controller.leaveCall();
                    Get.back();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: AssetSVGWidget(
                    iconsCroses,
                    imageWidth: height_14,
                    imageHeight: height_14,
                    color: Colors.black54,
                  ).paddingAll(margin_9),
                ).paddingOnly(left: margin_8),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _commentsList() {
    return SizedBox(
      height: height_160,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.transparent, Colors.white, Colors.white],
            ).createShader(rect);
          },
          child: ListView.builder(
              itemCount: controller.messages.length,
              shrinkWrap: true,
              controller: controller.commentsListController,
              itemBuilder: (BuildContext ctx, index) {
                return _singleCommentWidget(index)
                    .paddingOnly(bottom: margin_15);
              }).paddingSymmetric(horizontal: margin_4),
        ),
      ).paddingSymmetric(vertical: margin_8),
    ).paddingOnly(bottom: margin_12);
  }

  //participant section
  Widget _singleCommentWidget(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: margin_1point5, color: Colors.black),
              shape: BoxShape.circle),
          child: NetworkImageWidget(
            imageUrl: controller.messages[index].sentBy.profilePic ?? "",
            imageHeight: height_25,
            imageWidth: height_25,
            radiusAll: radius_20,
            imageFitType: BoxFit.cover,
            placeHolder: iconsProfilePlaceholderL,
          ).paddingAll(margin_4),
        ).paddingOnly(top: margin_2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "${controller.messages[index].sentBy.name}",
                textAlign: TextAlign.start,
                textStyle: textStyleTitleSmall()
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                maxLines: 1,
              ),
              TextView(
                text: "${controller.messages[index].message}",
                textAlign: TextAlign.start,
                textStyle: textStyleTitleSmall().copyWith(
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: FontWeight.w400),
                maxLines: 3,
              ),
            ],
          ).paddingSymmetric(horizontal: margin_8),
        ),
      ],
    );
  }

  Widget _bottomInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFieldWidget(
                onTap: () {
                  controller.update();
                },
                textAlign: TextAlign.left,
                formatter: const [],
                textColor: Colors.white,
                textController: controller.commentController,
                focusNode: controller.commentFocusNode,
                hint: strTypeComment,
                borderRadius: radius_10,
                fillColor: Colors.black,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                suffixIcon: InkWell(
                    onTap: () {
                      controller.onFieldSubmitted();
                    },
                    child: Stack(
                      children: [
                        AssetSVGWidget(
                          Assets.iconsRect,
                          imageHeight: height_40,
                        ).paddingOnly(top: 5, bottom: 5),
                        Positioned(
                            top: 3,
                            left: 7,
                            bottom: 2,
                            child: AssetSVGWidget(
                              Assets.iconsSeend,
                              imageHeight: height_30,
                            ))
                      ],
                    ).paddingOnly(right: 10)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  controller.hitSendHeartSocket();
                },
                child: const AssetSVGWidget(
                  Assets.iconsHeartt,
                  imageHeight: 60,
                  imageWidth: 70,
                )),
          ],
        ).paddingAll(margin_12),
      ],
    );
  }
}
