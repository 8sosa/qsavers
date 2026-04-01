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

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:quantity_savers/app/core/widget/search_navigation_widget.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../export.dart';

class RequestCampaignScreen extends StatelessWidget {
  final controller = Get.put(RequestCampaignController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> startCampaignFormGlobalKey =
  GlobalKey<FormState>();

  RequestCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestCampaignController>(
        init: RequestCampaignController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              isCustom: true,
              titleWidget: SearchNavigationWidget(),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                     controller.isRouteFromEditCampaignRequest==true? productDetailss():   productDetails(controller.productDetails),
                        InkWell(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: uploadImage()),
                        TextView(
                          text: "Note:- A video should not be longer than 300 MB.Supported Formats:- .MP4, .MOV.",
                          textStyle: textStyleTitleLarge().copyWith(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w800,
                              fontSize: 14),
                        ).paddingOnly(top: margin_20),
                        InkWell(
                            onTap: () {
                              controller.pickVideo();
                            },
                            child: uploadVideo()),
                        _textEditor().paddingOnly(top: margin_20),
                      ],
                    ).paddingAll(margin_20),
                  ),
                ),
                BottomButtonWidget(
                    onPressed: () {
                      if (controller.isRouteFromEditCampaignRequest == true) {
                        controller.hitEditCampaignEditRequest();
                      } else {
                            if(controller.docImagePath.isEmpty)
                              {
                                showToast(message: "Please select the Image");
                              }
                            else
                              {
                                controller.hitSendCampaignStartRequest();
                              }
                      }
                    },
                    btnTitle: strSendRequest.toUpperCase())
              ],
            ),
          );
        });
  }

  Widget searchBarField() => TextFieldWidget(
        contentPadding:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_0),
        borderColor: Colors.black,
        focusNode: controller.searchFieldFocusNode,
        textController: controller.searchFieldText,
        onChange: (text) {
          controller.updateSuffixIconVisibility();
        },
        prefixIcon:
            const AssetSVGWidget(iconsSearchgray, imageHeight: 1, imageWidth: 1)
                .paddingSymmetric(horizontal: margin_10),
        hint: "Search for products, brands and...",
        suffixIcon: Visibility(
          visible: controller.showSuffixIcon.value,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.grey.shade700),
            onPressed: () {
              controller.clearSearchField();
            },
          ),
        ),
        hintStyle: textStyleBodyMedium().copyWith(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            fontSize: font_14),
      );

  Widget productDetails(dynamic productDetails) => Container(
        padding: EdgeInsets.all(margin_16),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor, width: 1),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width_70,
              child: NetworkImageWidget(
                imageUrl: productDetails.images?[0] ?? "",
                imageHeight: height_50,
                imageWidth: width_50,
                radiusAll: radius_8,
                imageFitType: BoxFit.fill,
              ),
            ).paddingOnly(right: margin_12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "${productDetails.name}",
                    maxLines: 2,
                    textStyle: textStyleTitleLarge().copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: font_14),
                  ),
                  TextView(
                    text: "${productDetails.description}",
                    maxLines: 3,
                    textStyle: textStyleTitleLarge().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w400,
                        fontSize: font_12),
                  ).paddingSymmetric(vertical: margin_4),
                  Row(
                    children: [
                      TextView(
                        text: "price:",
                        textStyle: textStyleTitleLarge().copyWith(
                            color: AppColors.categoriesgrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                      TextView(
                        text: "\$${productDetails.discountPrice}",
                        textStyle: textStyleTitleLarge().copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ).paddingOnly(left: 4)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget productDetailss() => Container(
    padding: EdgeInsets.all(margin_16),
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor, width: 1),
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width_70,
          child: NetworkImageWidget(
            imageUrl: controller.productDetailsResponseModel.data?.images?[0] ?? "",
            imageHeight: height_50,
            imageWidth: width_50,
            radiusAll: radius_8,
            imageFitType: BoxFit.fill,
          ),
        ).paddingOnly(right: margin_12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "${controller.productDetailsResponseModel.data?.name}",
                maxLines: 2,
                textStyle: textStyleTitleLarge().copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: font_14),
              ),
              TextView(
                text: "${controller.productDetailsResponseModel.data?.description}",
                maxLines: 3,
                textStyle: textStyleTitleLarge().copyWith(
                    color: AppColors.categoriesgrey,
                    fontWeight: FontWeight.w400,
                    fontSize: font_12),
              ).paddingSymmetric(vertical: margin_4),
              Row(
                children: [
                  TextView(
                    text: "price:",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: AppColors.categoriesgrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  TextView(
                    text: "\$${controller.productDetailsResponseModel.data?.discountPrice}",
                    textStyle: textStyleTitleLarge().copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ).paddingOnly(left: 4)
                ],
              )
            ],
          ),
        )
      ],
    ),
  );

  Widget uploadImage() {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 1,
      color: AppColors.gradient2nd,
      dashPattern: const [8, 4],
      radius: Radius.circular(radius_12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: height_135,
          width: Get.width,
          color: AppColors.uploadBgColor.withOpacity(0.1),
          child: controller.isRouteFromEditCampaignRequest == true &&
                  controller.isImageUploaded == false
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: height_135,
                      width: Get.width,
                      color: AppColors.uploadBgColor.withOpacity(0.1),
                      child: NetworkImageWidget(
                        imageUrl: controller.campaignRequestDetailsResponseModel
                                .data?.image ??
                            "",
                        imageHeight: height_60,
                        imageWidth: width_70,
                        imageFitType: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                      child: const AssetSVGWidget(iconsEditNew),).paddingOnly(right: margin_12, top: margin_6)
                  ],
                )
              : Center(
                  child: controller.docImagePath.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AssetSVGWidget(iconsUploadIC),
                                TextView(
                                  text: "Upload Image",
                                  textStyle: textStyleTitleLarge().copyWith(
                                      color: AppColors.gradient2nd,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14),
                                ).paddingOnly(left: 8)
                              ],
                            ),
                            TextView(
                              text: ".PNG, .JPG , .JPEG",
                              textStyle: textStyleTitleLarge().copyWith(
                                  color: AppColors.categoriesgrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ).paddingOnly(top: margin_4)
                          ],
                        )
                      : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radius_8),
                              child: Image.file(
                                File(controller.docImagePath),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            if (controller.isImageUploaded == true) ...[
                              InkWell(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                  child: const AssetSVGWidget(iconsEditNew))
                                  .paddingOnly(right: margin_12, top: margin_6)
                            ],
                          ],
                        ),
                ),
        ),
      ),
    ).paddingOnly(top: margin_20);
  }

  Widget uploadVideo() {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: width_1,
      color: AppColors.gradient2nd,
      dashPattern: const [8, 4],
      radius: Radius.circular(radius_12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius_12)),
        child: Container(
          height: height_135,
          width: Get.width,
          color: AppColors.uploadBgColor.withOpacity(0.1),
          child: controller.isRouteFromEditCampaignRequest == true &&
                  controller.isVideoUploaded == false
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    VideoPreviewWidget(
                      mediaFile: MediaFile(
                          networkPath: controller
                              .campaignRequestDetailsResponseModel.data?.video),
                      height: height_135,
                      width: Get.width,
                      padding: 60,
                    ),
                    InkWell(
                        onTap: () {
                          controller.pickVideo();
                        },
                        child: const AssetSVGWidget(iconsEditNew)).paddingOnly(right: margin_12, top: margin_6)
                  ],
                )
              : Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                        child: controller.isVideoUploaded == true
                            ? AspectRatio(
                                aspectRatio: 16 / 8,
                                child: VideoPreviewWidget(
                                  mediaFile: MediaFile(
                                      localPath: controller.docVideoPath),
                                  height: height_135,
                                  width: Get.width,
                                  padding: 60,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const AssetSVGWidget(iconsUploadIC),
                                      TextView(
                                        text: "Upload Video",
                                        textStyle: textStyleTitleLarge()
                                            .copyWith(
                                                color: AppColors.gradient2nd,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14),
                                      ).paddingOnly(left: 8)
                                    ],
                                  ),
                                  TextView(
                                    text: ".MP4, .MOV",
                                    textStyle: textStyleTitleLarge().copyWith(
                                        color: AppColors.categoriesgrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ).paddingOnly(top: 4)
                                ],
                              )),
                    if (controller.isVideoUploaded == true) ...[
                      InkWell(
                          onTap: () {
                            controller.pickVideo();
                          },
                          child: const AssetSVGWidget(iconsEditNew)).paddingOnly(right: margin_12, top: margin_6)
                    ],
                  ],
                ),
        ),
      ),
    ).paddingOnly(top: margin_20);
  }

  Widget _textEditor() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_20),
        border: Border.all(width: height_1, color: AppColors.borderColor),
      ),
      child: SizedBox(
        height: Get.height * 0.4,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HtmlEditor(
              controller: controller.htmlController,
              callbacks: Callbacks(
                onChangeContent: (p0) {
                  controller.htmlContent.value = (p0 ?? '').trim();
                },
              ),
              otherOptions: OtherOptions(
                decoration: const BoxDecoration(),
                height: Get.height * 0.4,
              ),
              htmlEditorOptions: HtmlEditorOptions(
                  adjustHeightForKeyboard: false,
                  autoAdjustHeight: false,
                  darkMode: false,
                  shouldEnsureVisible: false,
                  androidUseHybridComposition: false,
                  hint: strEditorHint,
                  characterLimit: controller.editorMaxLength),
              htmlToolbarOptions: HtmlToolbarOptions(
                  renderBorder: true,
                  buttonColor: Colors.black,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_20,
                  ),
                  toolbarType: ToolbarType.nativeGrid,
                  defaultToolbarButtons: [
                    const FontButtons(
                      clearAll: false,
                      subscript: false,
                      superscript: false,
                      strikethrough: false,
                    ),
                    const ListButtons(listStyles: false),
                    const InsertButtons(
                        video: false,
                        audio: false,
                        table: false,
                        hr: false,
                        picture: false,
                        otherFile: false),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
