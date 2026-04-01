import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_link_previewer/flutter_link_previewer.dart";
import "package:quantity_savers/app/core/widget/image_preview_widget.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/media_file.dart";
import "package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart";
import "package:quantity_savers/app/modules/forums/models/data_model/chat_history_response_model.dart";

import "../../../core/widget/progress_bar.dart";
import "../../../export.dart";

class ForumsChatBubbleWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final ChatHistoryDataModel currentChat;
  final ChatHistoryDataModel? previousChat;
  final String? userLoggedInId;
  final String? localImage;
  int index;
  var readState;
  GlobalKey _textKey;

  ForumsChatBubbleWidget({
    super.key,
    this.margin,
    required this.currentChat,
    this.previousChat,
    this.userLoggedInId,
    this.readState,
    this.localImage,
    required this.index,
  }) : _textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    debugPrint("Local Image Path is $localImage");
    debugPrint("Current Chat Message type is ${currentChat.messageType}");
    debugPrint("Current Chat Message type is ${currentChat.mediaUrl}");
    bool showAvatarAndName =
        currentChat.sentBy?.sId != previousChat?.sentBy?.sId;
    return GestureDetector(
      onLongPress: () {
        if (userLoggedInId == currentChat.sentBy?.sId) {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return BottomSheet(
          //       onClosing: () {},
          //       builder: (BuildContext context) {
          //         return SizedBox(
          //           height: height_100,
          //           child: Padding(
          //             padding: EdgeInsets.symmetric(horizontal: margin_30),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 if (currentChat.messageType == 'TEXT') ...[
          //                   InkWell(
          //                     onTap: () {
          //                       Get.find<ForumsChatController>()
          //                           .setMessageForEdit(currentChat.sId);
          //                       Navigator.pop(context);
          //                     },
          //                     child: const Row(
          //                       children: [
          //                         Icon(
          //                           Icons.edit,
          //                           color: AppColors.gradient2nd,
          //                           size: 24,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //                 if (currentChat.messageType == 'TEXT') ...[
          //                   GestureDetector(
          //                     onLongPress: () async {
          //                       final RenderBox renderBox =
          //                           _textKey.currentContext!.findRenderObject()
          //                               as RenderBox;
          //                       final Offset localOffset =
          //                           renderBox.localToGlobal(Offset.zero);
          //                       final TextSelection? selection =
          //                           await showMenu<TextSelection>(
          //                         context: context,
          //                         position: RelativeRect.fromLTRB(
          //                           localOffset.dx,
          //                           localOffset.dy,
          //                           localOffset.dx + renderBox.size.width,
          //                           localOffset.dy + renderBox.size.height,
          //                         ),
          //                         items: [
          //                           PopupMenuItem<TextSelection>(
          //                             value: TextSelection(
          //                                 baseOffset: 0,
          //                                 extentOffset:
          //                                     currentChat.message.length),
          //                             child: Text('Select All'),
          //                           ),
          //                         ],
          //                       );
          //
          //                       if (selection != null) {
          //                         Clipboard.setData(ClipboardData(
          //                             text: currentChat.message.substring(
          //                                 selection.baseOffset,
          //                                 selection.extentOffset)));
          //                         showToast(
          //                             message:
          //                                 "Copied: ${currentChat.message.substring(selection.baseOffset, selection.extentOffset)}");
          //                       }
          //                     },
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           padding: const EdgeInsets.all(8.0),
          //                           decoration: BoxDecoration(color: Colors.transparent,
          //                             border: Border.all(
          //                               color: AppColors.gradient2nd,
          //                               width: 2.0
          //                             ),
          //                             borderRadius: BorderRadius.circular(4.0),
          //                           ),
          //                           child: SelectableText(
          //                             currentChat.message,
          //                             key: _textKey,
          //                             style: const TextStyle(
          //                               fontSize: 16,
          //                               color: Colors.black,
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           width: margin_30,
          //                         ),
          //                         GestureDetector(
          //                           onTap: () {
          //                             Clipboard.setData(ClipboardData(
          //                                 text: currentChat.message));
          //                             showToast(
          //                                 message:
          //                                     "Copied: ${currentChat.message}");
          //                           },
          //                           child: const Icon(
          //                             Icons.copy,
          //                             color: AppColors.gradient2nd,
          //                             size: 24,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //                 if (currentChat.messageType == 'TEXT' ||
          //                     currentChat.messageType == 'IMAGE' ||
          //                     currentChat.messageType == 'VIDEO')
          //                   InkWell(
          //                     onTap: () {
          //                       Get.find<ForumsChatController>()
          //                           .hitDeleteMessageSocket(currentChat.sId);
          //                       Navigator.pop(context);
          //                     },
          //                     child: Row(
          //                       children: [
          //                         const Icon(
          //                           Icons.delete,
          //                           color: Colors.red,
          //                           size: 24,
          //                         ),
          //                         if (currentChat.messageType == 'IMAGE' ||
          //                             currentChat.messageType == 'VIDEO') ...[
          //                           const SizedBox(
          //                             width: 8,
          //                           ),
          //                           const Text(
          //                             "DELETE",
          //                             style: TextStyle(
          //                                 color: Colors.red,
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.w400),
          //                           )
          //                         ]
          //                       ],
          //                     ),
          //                   ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // );
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin_30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentChat.messageType == 'TEXT') ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: AppColors.gradient2nd,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: SelectableText(
                              currentChat.message,
                              key: _textKey,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (currentChat.messageType == 'TEXT') ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.10),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.gradient2nd,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    Get.find<ForumsChatController>()
                                        .setMessageForEdit(currentChat.sId);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.10),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.copy,
                                    color: AppColors.gradient2nd,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: currentChat.message));
                                    showToast(
                                        message:
                                            "Copied: ${currentChat.message}");
                                  },
                                ),
                              ),
                            ],
                            if (currentChat.messageType == 'TEXT' ||
                                currentChat.messageType == 'IMAGE' ||
                                currentChat.messageType == 'VIDEO') ...[
                              if (currentChat.sId != null) ...[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.10),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      debugPrint(
                                          'CurrentChatSid is ${currentChat.sId}');
                                      Get.find<ForumsChatController>()
                                          .hitDeleteMessageSocket(
                                              currentChat.sId);
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ],
                          ],
                        ).paddingOnly(bottom: margin_5),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else if (userLoggedInId != currentChat.sentBy?.sId) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin_30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentChat.messageType == 'TEXT') ...[
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.gradient2nd,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SelectableText(
                                    currentChat.message,
                                    key: _textKey,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: currentChat.message));
                                  showToast(
                                      message:
                                          "Copied: ${currentChat.message}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.10),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.copy,
                                    color: AppColors.gradient2nd,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
      },
      child: Column(
        crossAxisAlignment: crossAlignmentOnType(),
        children: [
          if (showAvatarAndName) ...[
            Row(
              mainAxisAlignment: alignmentOnType(),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (userLoggedInId != currentChat.sentBy?.sId &&
                    currentChat.sentBy?.sId != previousChat?.sentBy?.sId)
                  NetworkImageWidget(
                      imageUrl: currentChat.sentBy?.profilePic ?? "",
                      imageHeight: height_25,
                      imageWidth: height_25,
                      radiusAll: radius_50,
                      imageFitType: BoxFit.cover,
                      placeHolder: iconsProfilePlaceholderS),
                TextView(
                  text: currentChat.sentBy?.name,
                  textStyle: textStyleBodyMedium().copyWith(
                      color: AppColors.pricesColor,
                      fontWeight: FontWeight.w600,
                      fontSize: font_14),
                ).paddingSymmetric(horizontal: margin_8),
                if (userLoggedInId == currentChat.sentBy?.sId &&
                    currentChat.sentBy?.sId != previousChat?.sentBy?.sId)
                  NetworkImageWidget(
                      imageUrl: currentChat.sentBy?.profilePic ?? "",
                      imageHeight: height_25,
                      imageWidth: height_25,
                      radiusAll: radius_50,
                      imageFitType: BoxFit.cover,
                      placeHolder: iconsProfilePlaceholderS),
              ],
            ).paddingOnly(top: margin_8, bottom: margin_4),
          ],
          if (currentChat.messageType == 'VIDEO' &&
              currentChat.inProgress == true &&
              currentChat.sentBy?.sId != userLoggedInId) ...[
            emptySizeBox()
          ] else ...[
            Container(
              margin: margin ?? EdgeInsets.zero,
              child: PhysicalShape(
                clipper: clipperOnType,
                elevation: 1,
                color: Colors.white,
                shadowColor: Colors.grey.shade200,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.8,
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: margin_10, horizontal: margin_12),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (currentChat.messageType == "IMAGE") ...[
                          InkWell(
                            onTap: () {
                              if (currentChat.isNetwork == null) {
                                Get.dialog(ImagePreviewWidget(
                                  imageProvider: currentChat.mediaUrl,
                                ));
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (currentChat.isNetwork == null) ...[
                                  NetworkImageWidget(
                                      imageUrl: currentChat.mediaUrl,
                                      imageHeight: height_120,
                                      imageWidth: height_120,
                                      imageFitType: BoxFit.cover,
                                      placeHolder: iconsProfilePlaceholderS),
                                ] else ...[
                                  Stack(
                                    children: [
                                      Image.file(
                                        File(currentChat.mediaUrl),
                                        fit: BoxFit.cover,
                                        width: height_120,
                                        height: height_120,
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                                TextView(
                                  text:
                                      "${currentChat.createdAt != currentChat.updatedAt ? " Edited " : ""}${formatDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(currentChat.createdAt)))}",
                                  textStyle: textStyleBodyMedium().copyWith(
                                      color: AppColors.categoriesgrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: font_10),
                                ).paddingOnly(top: margin_8)
                              ],
                            ),
                          )
                        ] else if (currentChat.messageType == "VIDEO") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (currentChat.inProgress == true &&
                                  userLoggedInId ==
                                      currentChat.sentBy?.sId) ...[
                                // VideoPreviewWidget(
                                //   mediaFile: MediaFile(
                                //       localPath: currentChat.mediaUrl),
                                //   height: height_120,
                                //   width: height_120,
                                //   padding: 60,
                                //   videoType: true,
                                //   userName: currentChat.sentBy?.name,
                                //   time: formatDateTime(
                                //       DateTime.fromMillisecondsSinceEpoch(
                                //           int.parse(currentChat.createdAt))),
                                // ),
                                Stack(
                                  children: [
                                    VideoPreviewWidget(
                                      mediaFile: MediaFile(
                                          localPath: currentChat.mediaUrl),
                                      height: height_120,
                                      width: height_120,
                                      loader: false,
                                      padding: 60,
                                      videoType: true,
                                      autoplay: false,
                                      userName: currentChat.sentBy?.name,
                                      time: formatDateTime(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(
                                                  currentChat.createdAt))),
                                    ),
                                    if (currentChat.uploadProgress != null &&
                                        currentChat.uploadProgress! < 1.0)
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors
                                              .black54,
                                          child: Center(
                                            child: ProgressDialog(
                                                progress: currentChat
                                                    .uploadProgress!),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                              ] else if (currentChat.inProgress == false) ...[
                                VideoPreviewWidget(
                                  mediaFile: MediaFile(
                                      networkPath: currentChat.mediaUrl),
                                  height: height_120,
                                  width: height_120,
                                  loader: false,
                                  padding: 60,
                                  videoType: true,
                                  userName: currentChat.sentBy?.name,
                                  time: formatDateTime(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(currentChat.createdAt))),
                                ),
                              ] else if (currentChat.isLocal == true &&
                                  userLoggedInId ==
                                      currentChat.sentBy?.sId) ...[
                                Stack(
                                  children: [
                                    VideoPreviewWidget(
                                      mediaFile: MediaFile(
                                          localPath: currentChat.mediaUrl),
                                      height: height_120,
                                      width: height_120,
                                      loader: false,
                                      padding: 60,
                                      videoType: true,
                                      autoplay: false,
                                      userName: currentChat.sentBy?.name,
                                      time: formatDateTime(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(
                                                  currentChat.createdAt))),
                                    ),
                                    if (currentChat.uploadProgress != null &&
                                        currentChat.uploadProgress! < 1.0)
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors
                                              .black54,
                                          child: Center(
                                            child: ProgressDialog(
                                                progress: currentChat
                                                    .uploadProgress!),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                              TextView(
                                text:
                                    "${currentChat.createdAt != currentChat.updatedAt ? " Edited " : ""}${formatDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(currentChat.createdAt)))}",
                                textStyle: textStyleBodyMedium().copyWith(
                                    color: AppColors.categoriesgrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: font_10),
                              ).paddingOnly(top: margin_8)
                            ],
                          )
                        ] else if (currentChat.messageType == "DOCUMENT") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (currentChat.isNetwork == null) ...[
                                if (GetUtils.isPDF(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ] else if (GetUtils.isPPT(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ] else if (GetUtils.isTxt(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ] else if (GetUtils.isTxt(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ] else if (GetUtils.isWord(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ] else if (GetUtils.isExcel(
                                    currentChat.mediaUrl ?? "")) ...[
                                  InkWell(
                                    child: AssetSVGWidget(
                                      iconsDocument,
                                      imageHeight: height_40,
                                      imageWidth: height_40,
                                    ),
                                    onTap: () {
                                      var launchLink =
                                          "$documentEndPoint${currentChat.mediaUrl}";
                                      launchUrl(Uri.parse(launchLink),
                                          mode: LaunchMode.externalApplication);
                                    },
                                  )
                                ],
                                LinkPreview(
                                  linkStyle: const TextStyle(
                                    color: AppColors.gradient2nd,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ),
                                  metadataTextStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  metadataTitleStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  onPreviewDataFetched: (_) {},
                                  text:
                                      "$documentEndPoint${currentChat.mediaUrl}",
                                  textStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ),
                                  width: 180,
                                  previewData: null,
                                ),
                              ] else ...[
                                if (GetUtils.isPDF(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ] else if (GetUtils.isPPT(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ] else if (GetUtils.isTxt(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ] else if (GetUtils.isTxt(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ] else if (GetUtils.isWord(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ] else if (GetUtils.isExcel(
                                    currentChat.mediaUrl ?? "")) ...[
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: AssetSVGWidget(
                                          iconsDocument,
                                          imageHeight: height_40,
                                          imageWidth: height_40,
                                        ),
                                        onTap: () {
                                          var launchLink =
                                              "$documentEndPoint${currentChat.mediaUrl}";
                                          launchUrl(Uri.parse(launchLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                      if (currentChat.uploadProgress != null &&
                                          currentChat.uploadProgress! < 1.0)
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors
                                                .black54, // Semi-transparent background
                                            child: Center(
                                              child: ProgressDialog(
                                                  progress: currentChat
                                                      .uploadProgress!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                                LinkPreview(
                                  linkStyle: const TextStyle(
                                    color: AppColors.gradient2nd,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ),
                                  metadataTextStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  metadataTitleStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ).copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  onPreviewDataFetched: (_) {},
                                  text:
                                      "$documentEndPoint${currentChat.mediaUrl}",
                                  textStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.375,
                                  ),
                                  width: 180,
                                  previewData: null,
                                ),
                              ],
                              TextView(
                                text:
                                    "${currentChat.createdAt != currentChat.updatedAt ? " Edited " : ""}${formatDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(currentChat.createdAt)))}",
                                textStyle: textStyleBodyMedium().copyWith(
                                    color: AppColors.categoriesgrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: font_10),
                              ).paddingOnly(top: margin_8)
                            ],
                          ),
                        ] else ...[
                          Flexible(
                            child: TextView(
                              text: currentChat.message,
                              textStyle: textStyleBodyMedium().copyWith(
                                  color: textColorOnType,
                                  fontSize: font_12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width_8,
                          ),
                          Row(
                            children: [
                              TextView(
                                text:
                                    "${currentChat.createdAt != currentChat.updatedAt ? " Edited " : ""}${formatDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(currentChat.createdAt)))}",
                                textStyle: textStyleBodyMedium().copyWith(
                                    color: AppColors.categoriesgrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: font_10),
                              ),
                              if (currentChat.groupId == null) ...[
                                const SizedBox()
                              ],
                              if (userLoggedInId == currentChat.sentBy?.sId &&
                                  currentChat.groupId != null) ...[
                                if (readState == 0) ...[
                                  const AssetSVGWidget(iconsSingleGreyTick)
                                      .paddingOnly(left: margin_4)
                                ] else if (readState == 1) ...[
                                  const AssetSVGWidget(iconsGreyTick)
                                      .paddingOnly(left: margin_4)
                                ] else if (readState == 2) ...[
                                  const AssetSVGWidget(
                                    iconsBlueTick,
                                    color: AppColors.gradient2nd,
                                  ).paddingOnly(left: margin_4)
                                ]
                              ]
                            ],
                          )
                        ],
                      ]),
                ),
              ),
            ),
          ]
        ],
      ).marginSymmetric(
          vertical: (currentChat.messageType == 'VIDEO' &&
                  currentChat.inProgress == true &&
                  currentChat.sentBy?.sId != userLoggedInId)
              ? margin_0
              : margin_4),
    );
  }

  Color get textColorOnType {
    return AppColors.lightBlackColor;
  }

  CustomClipper<Path> get clipperOnType {
    return currentChat.sentBy?.sId == userLoggedInId
        ? ChatBubbleClipper5(type: BubbleType.sendBubble)
        : ChatBubbleClipper5(type: BubbleType.receiverBubble);
  }

  CrossAxisAlignment crossAlignmentOnType() {
    return userLoggedInId == currentChat.sentBy?.sId
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
  }

  MainAxisAlignment alignmentOnType() {
    return currentChat.sentBy?.sId == userLoggedInId
        ? MainAxisAlignment.end
        : MainAxisAlignment.start;
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('hh:mm a');
    return dateFormat.format(dateTime);
  }
}
