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
import 'package:quantity_savers/app/core/widget/video_player_widget/media_file.dart';
import 'package:quantity_savers/app/core/widget/video_player_widget/video_preview_widget.dart';

import '../../../export.dart';

class StartCampaignScreen extends StatelessWidget {
  final controller = Get.put(StartCampaignController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> startCampaignFormGlobalKey =
      GlobalKey<FormState>();

  StartCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var appContext = context;
    return GetBuilder<StartCampaignController>(
        init: StartCampaignController(),
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleText: controller.isRouteFromCampaignDetails
                  ? strEditCampaignDetails.toUpperCase()
                  : strStartCampaign.toUpperCase(),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _titleWithStep(),
                        controller.isRouteFromCampaignDetails
                            ? CampaignItemCardWidget(
                                price:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.wholesalePrice ?? 0.0}",
                                title:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.name}",
                                description:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.description}",
                                image:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.images?[0]}",
                                quantity:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.campaignQuantity ?? 0}",
                                pricee:
                                    "${controller.campaignDetailsResponseModel.data?.productDetails?.price ?? 0}",
                                discount:
                                    " ${((controller.getDiscountedPercentage()).toStringAsFixed(2)) ?? 0}%",
                              )
                            : CampaignItemCardWidget(
                                price:
                                    "${controller.productDetails?.data?.wholesalePrice ?? 0.0}",
                                title:
                                    "${controller.productDetails?.data?.name}",
                                description:
                                    "${controller.productDetails?.data?.description}",
                                image:
                                    "${controller.productDetails?.data?.images?[0]}",
                                quantity:
                                    "${controller.productDetails?.data?.campaignQuantity ?? 0}",
                                pricee:
                                    "${controller.productDetails?.data?.price ?? 0}",
                                discount:
                                    "${(controller.getDiscountPercentage()).toStringAsFixed(2) ?? 0}%",
                              ),
                        controller.isRouteFromCampaignDetails
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.createGroupRoute,
                                      arguments: {
                                        argIsFromCreateCampaign: true
                                      });
                                },
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.transparent),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Create Group",
                                        style: TextStyle(
                                            color: AppColors.gradient2nd,
                                            fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: AppColors.gradient2nd,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ).paddingOnly(
                                left: Get.width - 230, top: 10, bottom: 10),
                        controller.isRouteFromCampaignDetails
                            ? _form()
                            : _forms(),
                        _textEditor().paddingOnly(top: margin_20),
                      ],
                    ).paddingSymmetric(
                        vertical: margin_20, horizontal: margin_20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5)),
                  child: _stepsWithButton()
                      .paddingOnly(bottom: margin_32, top: margin_15),
                ),
              ],
            ),
          );
        });
  }

  Widget _textEditor() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_20),
        border: Border.all(width: height_1, color: AppColors.borderColor),
      ),
      child: SizedBox(
        height: Get.height * 0.4,
        child: Focus(
          onFocusChange: (focus) {
            print('focus changed');
            Future.delayed(
              Duration(seconds: 1),
              () {
                controller.scrollToBottom();
              },
            );
          },
          canRequestFocus: true,
          descendantsAreFocusable: true,
          focusNode: controller.focus,
          includeSemantics: true,
          child: HtmlEditor(
            controller: controller.htmlController,
            callbacks: Callbacks(onChangeContent: (p0) {
              //controller.scrollToBottom();
              controller.htmlContent.value = (p0 ?? '').trim();
            }, onScroll: () {
              controller.scrollToBottom();
            }, onFocus: () {
              controller.scrollToBottom();
            }),
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
        ),
      ),
    );
  }

  _titleWithStep() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AssetSVGWidget(iconsStep1).paddingOnly(top: margin_4),
          Expanded(
            child: TextView(
              maxLines: 3,
              text: "Please enter all the details to start the campaign.",
              textStyle: textStyleBodyMedium().copyWith(
                fontSize: font_16,
                fontWeight: FontWeight.w500,
              ),
            ).paddingOnly(left: margin_8),
          )
        ],
      );

  Widget _form() {
    controller.campaignNameController = TextEditingController(
      text: controller.isRouteFromCampaignDetails == true
          ? controller.campaignDetailsResponseModel.data?.campaignName
          : '',
    );
    var startDuration = controller.campaignDetailsResponseModel.data?.startDate;
    var endDuration = controller.campaignDetailsResponseModel.data?.endDate;
    DateTime? startDate;
    if (startDuration != null) {
      startDate = DateTime.fromMillisecondsSinceEpoch(startDuration!);
    } else {
      startDate = DateTime.now();
    }
    DateTime? endDate;
    if (endDuration != null) {
      endDate = DateTime.fromMillisecondsSinceEpoch(endDuration!);
    } else {
      endDate = DateTime.now();
    }
    String startFormattedDate = DateFormat('dd-MM-yyyy').format(startDate);
    String endFormattedDate = DateFormat('dd-MM-yyyy').format(endDate);
    controller.startDateController.text =
        controller.isRouteFromCampaignDetails == true ? startFormattedDate : '';
    controller.endDateController.text =
        controller.isRouteFromCampaignDetails == true ? endFormattedDate : '';
    controller.startDate = startDate.millisecondsSinceEpoch;
    controller.endDate = endDate.millisecondsSinceEpoch;
    controller.update();
    return Form(
      key: startCampaignFormGlobalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _selectCampaignDropDown(),
          TextFieldWidget(
            textController: controller.campaignNameController,
            focusNode: controller.campaignNameFocusNode,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strEnterCampaign,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            onTap: () {
              controller.onDateChange(true);
            },
            suffixIcon: InkWell(
              child: const AssetSVGWidget(iconsCalendarSuffix)
                  .paddingSymmetric(vertical: margin_10, horizontal: margin_10),
            ),
            hint: strStartTime,
            textController: controller.startDateController,
            readOnly: true,
          ).paddingOnly(top: margin_10),
          TextFieldWidget(
            onTap: () {
              controller.onDateChange(false);
            },
            suffixIcon: InkWell(
              child: const AssetSVGWidget(iconsCalendarSuffix)
                  .paddingSymmetric(vertical: margin_10, horizontal: margin_10),
            ),
            hint: strEndTime,
            textController: controller.endDateController,
            readOnly: true,
          ).paddingOnly(top: margin_10),
          InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                debugPrint("picked Image");
                controller.pickImage();
              },
              child: uploadImage()),
          TextView(
            text: "Note:- A video should not be longer than 300 MB.Supported Formats:- .MP4, .MOV.",
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ).paddingOnly(top: margin_20),
          GestureDetector(
              onTap: () {
                controller.pickVideo();
              },
              child: uploadVideo()),
          // TextView(
          //   text: "*Promotional video",
          //   textStyle: textStyleBodyMedium().copyWith(
          //       fontSize: font_14,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.redAccent),
          // ).paddingOnly(top: margin_10)
        ],
      ),
    );
  }

  Widget _forms() {
    return Form(
      key: startCampaignFormGlobalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _selectCampaignDropDown(),
          TextFieldWidget(
            textController: controller.campaignNameController,
            focusNode: controller.campaignNameFocusNode,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strFieldRequired),
            hint: strEnterCampaign,
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
          ),
          TextFieldWidget(
            onTap: () {
              controller.onDateChange(true);
            },
            suffixIcon: InkWell(
              child: const AssetSVGWidget(iconsCalendarSuffix)
                  .paddingSymmetric(vertical: margin_10, horizontal: margin_10),
            ),
            hint: strStartTime,
            textController: controller.startDateController,
            readOnly: true,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strStartDateRequired),
          ).paddingOnly(top: margin_10),
          TextFieldWidget(
            onTap: () {
              controller.onDateChange(false);
            },
            suffixIcon: InkWell(
              child: const AssetSVGWidget(iconsCalendarSuffix)
                  .paddingSymmetric(vertical: margin_10, horizontal: margin_10),
            ),
            hint: strEndTime,
            textController: controller.endDateController,
            readOnly: true,
            validate: (value) => FieldChecker.fieldChecker(
                value: value, message: strEndDateRequired),
          ).paddingOnly(top: margin_10),
          InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                controller.pickImage();
              },
              child: uploadImage()),
          TextView(
            text: "Note:- A video should not be longer than 300 MB.Supported Formats:- .MP4, .MOV.",
            textStyle: textStyleTitleLarge().copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ).paddingOnly(top: margin_20),
          InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                controller.pickVideo();
              },
              child: uploadVideo()),
          // TextView(
          //   text: "*Promotional video",
          //   textStyle: textStyleBodyMedium().copyWith(
          //       fontSize: font_14,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.redAccent),
          // ).paddingOnly(top: margin_10)
        ],
      ),
    );
  }

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
          child: controller.isRouteFromCampaignDetails == true &&
                  controller.isImageUploaded == false
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: height_135,
                      width: Get.width,
                      color: AppColors.uploadBgColor.withOpacity(0.1),
                      child: NetworkImageWidget(
                        imageUrl: controller
                                .campaignDetailsResponseModel.data?.image ??
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
                      child: const AssetSVGWidget(
                        iconsEditNew
                      ),
                        /*child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )*/).paddingOnly(right: margin_12, top: margin_6)
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
                               child: const AssetSVGWidget(
                                  iconsEditNew
                                )
                                      /*child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )*/)
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
          child: controller.isRouteFromCampaignDetails == true &&
                  controller.campaignDetailsResponseModel.data?.video != "" &&
                  controller.campaignDetailsResponseModel.data?.video !=
                      "string" &&
                  controller.isVideoUploaded == false
              ? Stack(alignment: Alignment.topRight, children: [
                  VideoPreviewWidget(
                    mediaFile: MediaFile(
                        networkPath: controller
                            .campaignDetailsResponseModel.data?.video),
                    height: height_135,
                    width: Get.width,
                    padding: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.pickVideo();
                          },
                          child: const AssetSVGWidget(
                              iconsEditNew
                          )
                          /*child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )*/).paddingOnly(right: margin_12, top: margin_6),
                      InkWell(
                          onTap: () {
                            controller.removeVideo();
                          },
                        child: const AssetSVGWidget(iconsCoossNew),
                          /*child: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          )*/).paddingOnly(right: margin_12, top: margin_6)
                    ],
                  )
                ])
              : Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                        child: controller.isVideoUploaded == true
                            ? VideoPreviewWidget(
                                mediaFile: MediaFile(
                                    localPath: controller.docVideoPath),
                                height: height_135,
                                width: Get.width,
                                padding: 60,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                controller.pickVideo();
                              },
                              child: const AssetSVGWidget(
                                  iconsEditNew
                              )
                              /*child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )*/).paddingOnly(right: margin_12, top: margin_6),
                          InkWell(
                              onTap: () {
                                controller.removeVideo();
                              },
                            child: const AssetSVGWidget(iconsCoossNew),
                             /* child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              )*/).paddingOnly(right: margin_12, top: margin_6)
                        ],
                      )
                    ],
                  ],
                ),
        ),
      ),
    ).paddingOnly(top: margin_20);
  }

  Widget _selectCampaignDropDown() {
    return GestureDetector(
      onTap: () {
        if (controller.items.isEmpty) {
          showToast(
            message: 'Kindly Join the Forum first',
          );
        }
      },
      child: DropDownTextFieldWidget(
        borderColor: AppColors.borderColor,
        onFieldSubmitted: controller.isRouteFromCampaignDetails
            ? null
            : (value) {
                controller.onChangeDropDownValue(value);
              },
        height: 60,
        hint: strSelectGroup,
        Quantity: false,
        hintStyle: textStyleLabelLarge().copyWith(
            color: AppColors.categoriesgrey,
            fontSize: font_14,
            fontWeight: FontWeight.w400),
        itemsList: controller.items,
        selectedValue: controller.isRouteFromCampaignDetails
            ? controller.campaignDetailsResponseModel.data?.groupId?.groupName
            : controller.selectedValue?.value,
      ).paddingSymmetric(vertical: margin_10),
    );
  }

  Widget _stepsWithButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextView(
          text: "Step 1 of 2",
          textStyle: textStyleBodyMedium().copyWith(
              color: AppColors.categoriesgrey,
              fontWeight: FontWeight.w500,
              fontSize: font_14),
        ),
        const Spacer(),
        SizedBox(
          height: height_50,
          width: width_120,
          child: MaterialButtonWidget(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.focus.unfocus();
              if (startCampaignFormGlobalKey.currentState!.validate()) {
                if (controller.isForCampaignEdit == true) {
                  controller.hitEditCampaignApiCall();
                } else {
                  if (controller.items.isEmpty) {
                    showToast(message: 'Please Select Group');
                  } else if (controller.docImagePath.isEmpty) {
                    showToast(message: 'Please Select Image');
                  } else {
                    controller.hitCreateCampaignApiCall();
                  }
                }
              }
            },
            buttonText: strNext.toUpperCase(),
            buttonBgColor: AppColors.gradient2nd,
            buttonRadius: margin_10,
            buttonTextStyle: textStyleBodyMedium().copyWith(
                color: Colors.white,
                fontSize: font_14,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    ).paddingSymmetric(horizontal: margin_20);
  }
}
