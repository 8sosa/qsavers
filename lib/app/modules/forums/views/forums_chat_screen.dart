import "package:clipboard/clipboard.dart";
import "package:emoji_picker_flutter/emoji_picker_flutter.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";

import "../../../export.dart";

class ForumsChatScreen extends StatelessWidget {
  final themeController = Get.put(ForumsChatController());
  final controller = Get.put(ForumsChatController());
  final GlobalKey<FormState> joinRequestFormGlobalKey = GlobalKey<FormState>();

  ForumsChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForumsChatController>(
        init: ForumsChatController(),
        builder: (controller) {
          return PopScope(
            canPop: true,
            onPopInvoked: (data) {},
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: CustomAppBar(
                onTap: () {
                  Get.find<ForumsController>().onInit();
                  controller.hitGroupLeaveSocket();
                  Get.back();
                },
                appBarTitleText:
                    controller.groupInfoResponseModel.data?.groupName,
                actionWidget: [
                  controller.isSearchedForumCampaign == false
                      ? PopupMenuButton(
                          surfaceTintColor: Colors.transparent,
                          icon: const Icon(Icons.more_vert),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(radius_8),
                            ),
                          ),
                          offset: const Offset(0, 60),
                          iconColor: Colors.white,
                          color: Colors.white,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  Get.toNamed(AppRoutes.groupInfoRoute,
                                      arguments: {
                                        argIsSearchedForum:
                                            controller.isSearchedForum,
                                        argForumGroupType: controller
                                            .groupInfoResponseModel
                                            .data
                                            ?.groupType,
                                        argIsDefaultGroup: controller
                                            .groupInfoResponseModel
                                            .data
                                            ?.isDefault
                                      });
                                },
                                height: height_20,
                                child: TextView(
                                  text: controller.groupInfoResponseModel.data
                                              ?.isDefault ==
                                          true
                                      ? strForumInfo
                                      : strGroupInfo,
                                  textStyle: textStyleBodyMedium().copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: font_14),
                                ),
                              ),
                              if (controller.groupInfoResponseModel.data
                                          ?.isDefault ==
                                      false &&
                                  controller.groupInfoResponseModel.data
                                          ?.isJoined ==
                                      1) ...[
                                PopupMenuItem(
                                    height: height_10,
                                    child: const Divider(
                                      color: AppColors.textfieldborder,
                                    )),
                                PopupMenuItem(
                                  onTap: () {
                                    Get.dialog(_deleteOrExitDialog());
                                  },
                                  height: height_20,
                                  child: TextView(
                                    text: controller.userLoggedInId ==
                                            controller.groupInfoResponseModel
                                                .data?.createdBy?.sId
                                        ? strDeleteGroup
                                        : strExitGroup,
                                    textStyle: textStyleBodyMedium().copyWith(
                                        color: AppColors.titleRed,
                                        fontWeight: FontWeight.w500,
                                        fontSize: font_14),
                                  ),
                                )
                              ]
                            ];
                          },
                        )
                      : SizedBox()
                ],
                titlePrefixIcon: [
                  AssetSVGWidget(
                          controller.groupInfoResponseModel.data?.groupType ==
                                  strPrivate
                              ? Assets.iconsLockCloseWhiteBg
                              : iconsLockOpenWhiteBg)
                      .paddingOnly(right: margin_8)
                ],
              ),
              body: controller.groupInfoResponseModel.data?.isRequest == 1 &&
                      controller.groupInfoResponseModel.data?.isJoined == 0 &&
                      controller.groupRequestId == ""
                  ? _requestAlreadySentScreen()
                  : (controller.isSearchedForum == true &&
                          controller.forumGroupType == "PUBLIC")
                      ? Column(
                          children: [
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.chatBackgroundColor),
                              child: _chatScreen(),
                            )),
                            controller.isPublicGroupJoined ||
                                    controller.groupInfoResponseModel.data
                                            ?.isJoined ==
                                        1
                                ? _bottomInputField()
                                : BottomButtonWidget(
                                    onPressed: () {
                                      Get.dialog(
                                        CustomDialogWidget(
                                          confirmBtnBgColor:
                                              AppColors.gradientColorSecondary,
                                          cancelBtnBorder: Border.all(
                                              color: AppColors.textfieldborder),
                                          cancelTitleColor:
                                              AppColors.lightBlackColor,
                                          title: strJoinPublicGroup,
                                          confirmTitle: strYes,
                                          cancelTitle: strNo,
                                          onTapConfirm: () {
                                            Get.back();
                                            controller.hitJoinPublicGroupApi();
                                          },
                                          isImage: false,
                                          isCloseBtn: true,
                                        ),
                                      );
                                    },
                                    btnTitle: strJoinGroup)
                          ],
                        )
                      : (controller.groupInfoResponseModel.data?.isJoined ==
                                  0 &&
                              controller.isRouteFromRequest == false)
                          ? _privateGroupScreen()
                          : Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: margin_16),
                                  decoration: const BoxDecoration(
                                      color: AppColors.chatBackgroundColor),
                                  child: _chatScreen(),
                                )),
                                Column(
                                  children: [
                                    if (controller.groupInfoResponseModel.data
                                                ?.isJoined ==
                                            0 ||
                                        controller.isRouteFromViewRequest ==
                                            true) ...[_manageRequestScreen()],
                                    Column(children: [
                                      _bottomInputField(),
                                      if (controller.showEmoji == true) ...[
                                        SizedBox(
                                          height: Get.height / 2.8,
                                          child: EmojiPicker(
                                            textEditingController: controller
                                                .textEditingController,
                                            config: const Config(
                                              bottomActionBarConfig:
                                                  BottomActionBarConfig(
                                                      enabled: false),
                                            ),
                                          ),
                                        )
                                      ]
                                    ])
                                  ],
                                )
                              ],
                            ),
            ),
          );
        });
  }

  _manageRequestScreen() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.textfieldborder,
                blurRadius: radius_4,
                offset: const Offset(0, -2)),
          ],
        ),
        padding: EdgeInsets.all(margin_12),
        child: controller.isRouteFromRequest == true
            ? _manageRequestBtn(strCancelRequest, Colors.red, () {
                controller.requestStatus = "CANCEL";
                controller.update();
                controller.hitManageForumRequestApi();
              })
            : Row(
                children: [
                  Expanded(
                      child: _manageRequestBtn(strAccept, Colors.green, () {
                    controller.requestStatus = "ACCEPTED";
                    controller.update();
                    controller.hitManageForumRequestApi();
                  })),
                  SizedBox(
                    width: width_8,
                  ),
                  Expanded(
                      child: _manageRequestBtn(strReject, Colors.red, () {
                    controller.requestStatus = "REJECTED";
                    controller.update();
                    controller.hitManageForumRequestApi();
                  }))
                ],
              ).paddingOnly(bottom: margin_8),
      );

  _manageRequestBtn(btnName, bgColor, onBtnPressed) => InkWell(
        onTap: onBtnPressed,
        child: Container(
          padding: EdgeInsets.all(margin_16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius_4),
          ),
          child: Center(
            child: Text(btnName.toUpperCase(),
                style: TextStyle(
                  fontSize: font_12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
      );

  Widget _bottomInputField() {
    if (controller.groupInfoResponseModel.data?.isBlocked == true) {
      return SizedBox(
        width: Get.width,
        height: height_50,
        child: const Center(
            child: Text(
          'You are Blocked',
          style: TextStyle(fontSize: 24, color: Colors.red),
        )),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.textfieldborder,
              blurRadius: radius_4,
              offset: const Offset(0, -2)),
        ],
      ),
      padding: EdgeInsets.all(margin_12),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onLongPress: () {
              FlutterClipboard.paste().then((value) {
                debugPrint("Value is $value");
                controller.textEditingController.text = value;
              });
            },
            child: TextFieldWidget(
              onTap: () {
                controller.hideEmoji();
                controller.update();
              },
              formatter: const [],
              textController: controller.textEditingController,
              focusNode: controller.focusNode,
              hint: strTypeMessage,
              borderRadius: radius_30,
              suffixIcon: controller.groupRequestId == ""
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // GestureDetector(
                        //   onTapDown: (details) async {
                        //     debugPrint("Attachment Pressed");
                        //     if (controller.showEmoji) {
                        //       controller.hideEmoji();
                        //       await Future.delayed(
                        //           const Duration(milliseconds: 100));
                        //     }
                        //     if (WidgetsBinding
                        //             .instance.window.viewInsets.bottom >
                        //         0.0) {
                        //       FocusScope.of(Get.context!).unfocus();
                        //       await Future.delayed(
                        //           const Duration(milliseconds: 100));
                        //     }
                        //     _attachmentScreen(details.globalPosition);
                        //   },
                        //   child: const AssetSVGWidget(iconsAttachment),
                        // ),
                        GestureDetector(
                          onTapDown: (details) async {
                            debugPrint("Attachment Pressed");
                            if (controller.showEmoji) {
                              controller.hideEmoji();
                              await Future.delayed(
                                  const Duration(milliseconds: 100));
                            }
                            if (WidgetsBinding
                                    .instance.window.viewInsets.bottom >
                                0.0) {
                              _attachmentScreen(details.globalPosition);
                            } else {
                              _attachmentScreen(details.globalPosition);
                            }
                          },
                          child: const AssetSVGWidget(iconsAttachment),
                        ),

                        SizedBox(
                          width: margin_10,
                        ),
                        InkWell(
                          onTap: () {
                            debugPrint("ShowEmoji is ${controller.showEmoji}");
                            controller.toggleEmojiPicker();
                          },
                          child: const AssetSVGWidget(iconsSmilyEmoji)
                              .paddingSymmetric(horizontal: margin_12),
                        ),
                        SizedBox(
                          width: margin_2,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          )),
          SizedBox(
            width: width_8,
          ),
          InkWell(
            onTap: () {
              controller.onFieldSubmitted();
            },
            child: AssetSVGWidget(
              Assets.iconsSendMessage,
              imageHeight: height_35,
            ),
          ),
        ],
      ).paddingOnly(bottom: margin_8),
    );
  }

  /* _attachmentScreen(Offset globalPosition) async {
    final RenderBox renderBox = Get.context!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final RelativeRect positionMenu = RelativeRect.fromRect(
      Rect.fromPoints(
        position.translate(Get.width / 2, Get.height / 1.40),
        position.translate(Get.width / 1.10, Get.height / 1.10),
      ),
      Offset.zero & Get.context!.size!,
    );

    await showMenu(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      context: Get.overlayContext!,
      position: positionMenu,
      items: [
        PopupMenuItem(
          value: 1,
          child: SizedBox(
            width: 120,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                child: const AssetSVGWidget(
                  iconsAttachmentGallery,
                  imageHeight: 40,
                  imageWidth: 40,
                ),
              ),
            ]),
          ),
          onTap: () {
            controller.pickImage();
          },
        ),
        PopupMenuItem(
          value: 2,
          child: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: const AssetSVGWidget(
                    iconsAttachmentVideo,
                    imageHeight: 40,
                    imageWidth: 40,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            controller.pickVideo();
          },
        ),
        PopupMenuItem(
          value: 3,
          child: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: const AssetSVGWidget(
                    iconsDocument,
                    imageHeight: 50,
                    imageWidth: 50,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            controller.pickDocument();
          },
        ),
      ],
    );
  }*/

  void _attachmentScreen(Offset globalPosition) async {
    showDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Container(
                    width: 50, // Set a fixed width
                    height: 50, // Set a fixed height
                    alignment: Alignment.center,
                    child: const AssetSVGWidget(
                      iconsAttachmentGallery,
                      imageHeight: 40,
                      imageWidth: 40,
                    ),
                  ),
                  title: const Text("Image",
                      style: TextStyle(color: AppColors.gradient2nd)),
                  onTap: () {
                    Navigator.pop(context);
                    controller.pickImage();
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 50, // Set a fixed width
                    height: 50, // Set a fixed height
                    alignment: Alignment.center,
                    child: const AssetSVGWidget(
                      iconsAttachmentVideo,
                      imageHeight: 40,
                      imageWidth: 40,
                    ),
                  ),
                  title: const Text("Video",
                      style: TextStyle(color: AppColors.gradient2nd)),
                  onTap: () {
                    debugPrint("Open Video Dialog");
                    Navigator.pop(context);
                    controller.pickVideo();
                  },
                ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: const AssetSVGWidget(
                      iconsDocument,
                      imageHeight: 50,
                      imageWidth: 50,
                    ),
                  ),
                  title: const Text("Document",
                      style: TextStyle(color: AppColors.gradient2nd)),
                  onTap: () {
                    Navigator.pop(context);
                    controller.pickDocument();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _chatScreen() => controller.chatHistoryResponseModel.data?.length == 0
      ? _noChatFoundScreen()
      : controller.isLoading == true
          ? Center(
              child: LoadingAnimationWidget.hexagonDots(
                  color: AppColors.gradientColorPrimary, size: 50),
            )
          : Align(
              alignment: Alignment.topCenter,
              child: GroupedListView(
                controller: controller.scrollController,
                shrinkWrap: true,
                elements: controller.chatHistoryResponseModel.data ?? [],
                groupBy: (message) {
                      DateTime timeInfo = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(message.createdAt));
                      return DateTime(timeInfo.year, timeInfo.month, timeInfo.day);
                },
                useStickyGroupSeparators: true,
                floatingHeader: true,
                groupHeaderBuilder: (message) {
                  return  SizedBox(
                    height: height_40,
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              horizontal: margin_10, vertical: margin_3),
                          child: TextView(
                            text: controller.calculateDifferenceInDays(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(message.createdAt))) ==
                                    -1
                                ? strYesterday
                                : controller.calculateDifferenceInDays(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(
                                                    message.createdAt))) ==
                                        0
                                    ? strToday
                                    : DateFormat.yMMMd()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(message.createdAt)))
                                        .toString(),
                            textStyle: textStyleBodyMedium().copyWith(
                                color: AppColors.categoriesgrey,
                                fontWeight: FontWeight.w500,
                                fontSize: font_12),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                indexedItemBuilder: (context, element, index) {
                  debugPrint(
                      "Debug:${controller.userLoggedInId}   ${controller.chatHistoryResponseModel.data?[index].sentBy?.sId} ${controller.chatHistoryResponseModel.data?[index].groupId}");
                  return controller.chatHistoryResponseModel.data != null
                      ? ForumsChatBubbleWidget(
                          readState: controller
                              .chatHistoryResponseModel.data?[index].readState,
                          userLoggedInId: controller.userLoggedInId,
                          currentChat:
                              controller.chatHistoryResponseModel.data![index],
                          index: index,
                          previousChat: index == 0
                              ? null
                              : controller
                                  .chatHistoryResponseModel.data![index - 1])
                      : const SizedBox();
                },
              ),
            );

  _privateGroupScreen() => Column(
        children: [
          Expanded(
            child: controller.isJoinRequestFormOpened == true
                ? Container(
                    padding: EdgeInsets.all(margin_16),
                    child: ListView(
                      children: [
                        TextView(
                          text:
                              "$strJoinPrivateGroup${controller.groupInfoResponseModel.data?.groupName}",
                          textStyle: textStyleBodyMedium().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: font_20),
                        ),
                        TextView(
                          text: strPleaseEnterDescription,
                          textStyle: textStyleBodyMedium().copyWith(
                              color: AppColors.categoriesgrey,
                              fontWeight: FontWeight.w400,
                              fontSize: font_14),
                        ).paddingOnly(top: margin_10, bottom: margin_20),
                        Form(
                          key: joinRequestFormGlobalKey,
                          child: TextFieldWidget(
                            textController: controller
                                .joinRequestDescriptionEditingController,
                            focusNode:
                                controller.joinRequestDescriptionFocusNode,
                            validate: (value) => FieldChecker.fieldChecker(
                                value: value, message: strFieldRequired),
                            hint: strEnterYourMessage,
                            minLine: 5,
                            maxLines: 10,
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AssetSVGWidget(
                          iconsIconsLockClose,
                          imageHeight: height_80,
                        ).paddingOnly(bottom: margin_20),
                        TextView(
                          text: strThisIsPrivateGroup,
                          textStyle: textStyleBodyMedium().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: font_16),
                        ),
                        TextView(
                          textAlign: TextAlign.center,
                          text: strJoinTheGroup,
                          textStyle: textStyleBodyMedium().copyWith(
                              color: AppColors.categoriesgrey,
                              fontWeight: FontWeight.w500,
                              fontSize: font_14),
                        ).paddingSymmetric(vertical: margin_16),
                      ],
                    ),
                  ),
          ),
          BottomButtonWidget(
            btnTitle: strSendJoinRequest.toUpperCase(),
            onPressed: () {
              if (controller.isJoinRequestFormOpened == true &&
                  joinRequestFormGlobalKey.currentState!.validate()) {
                controller.hitSendJoinForumRequestSocket();
              } else {
                controller.isJoinRequestFormOpened = true;
              }
              controller.update();
            },
          )
        ],
      );

  _requestAlreadySentScreen() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetSVGWidget(
              iconsIconsLockClose,
              imageHeight: height_80,
            ).paddingOnly(bottom: margin_20),
            TextView(
              text: strRequestAlreadySent,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: font_16),
            ),
          ],
        ),
      );

  _noChatFoundScreen() => Center(
        child: TextView(
          text: strNoChatHistory,
          textStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: font_16),
        ),
      );

  _deleteOrExitDialog() => CustomDialogWidget(
      cancelTitleColor: AppColors.categoriesgrey,
      cancelBtnBorder: Border.all(color: AppColors.textfieldborder),
      confirmBtnBgColor: AppColors.redColor,
      textWidget: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
            text:
                "$strWantTo ${controller.userLoggedInId == controller.groupInfoResponseModel.data?.createdBy?.sId ? "delete" : "exit from"}",
            style: textStyleBodyLarge()
                .copyWith(fontWeight: FontWeight.w500, fontSize: font_20),
            children: [
              TextSpan(
                  text:
                      " ${controller.groupInfoResponseModel.data?.groupName} ",
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: font_20,
                      color: Colors.black)),
              TextSpan(
                  text: "Group?",
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w500, fontSize: font_20)),
            ]),
      ).paddingOnly(bottom: margin_12),
      title: strJoinPublicGroup,
      confirmTitle: strYes,
      cancelTitle: strNo,
      onTapConfirm: () {
        controller.userLoggedInId ==
                controller.groupInfoResponseModel.data?.createdBy?.sId
            ? controller.hitDeleteGroupApi()
            : controller.hitExitGroupApi();
      });
}
