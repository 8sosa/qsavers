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

import 'package:flutter/cupertino.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/campaign_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/edit_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/start_campaign_response_model.dart';
import 'package:video_player/video_player.dart';

import '../../../core/widget/video_player_widget/video_player_widget.dart';
import '../../../export.dart';

class StartCampaignController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ProductDetailsResponseModel? productDetails;
  TextEditingController campaignNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isVideoUploaded = false;
  bool isForCampaignEdit = false;
  bool isImageUploaded = false;
  String docImagePath = "";
  dynamic image;
  String alreadyCreatedCampaignId = "";
  String campaignId = "";
  String docVideoPath = "";
  bool isKeyboardOpen = false;
  DateTime? _maxLastDate;
  late int startDate;
  late int endDate;
  FocusNode campaignNameFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode endDateFocus = FocusNode();
  FocusNode textEditorFocus = FocusNode();
  final ScrollController scrollController = ScrollController();
  StartCampaignResponseModel startCampaignResponseModel =
      StartCampaignResponseModel();
  ImageResposemodel? videoUploadResponse = ImageResposemodel();
  ImageResposemodel? imageUploadResponse = ImageResposemodel();
  UserGroupListResponceModel userGroupListResponseModel =
      UserGroupListResponceModel();
  EditCampaignResponseModel editCampaignResponseModel =
      EditCampaignResponseModel();
  CampaignDetailsResponseModel campaignDetailsResponseModel =
      CampaignDetailsResponseModel();

  final HtmlEditorController htmlController = HtmlEditorController();
  final List<String> items = [];
  var groupId;

  RxString? selectedValue = "".obs;
  RxString htmlContent = "".obs;
  var editorMaxLength = 200;
  bool isRouteFromCampaignDetails = false;
  var productId;
  List<String>? highlights = [];

  scrollToBottom() async {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      update();
    }
  }

  FocusNode focus = FocusNode();

  @override
  void onInit() {
    if (Get.isRegistered<ProductDetailsController>(tag: productDetailTag)) {
      productDetails = Get.find<ProductDetailsController>(tag: productDetailTag)
          .productDetailsResponseModel;
    }
    getArguments();
    highLights();
    debugPrint("Highlights is $highlights");
    lightTheme(color: AppColors.appColor);
    getUserGroupsApi();
    focus.addListener(() {
      debugPrint("show status of focus ${focus.hasFocus}");

      scrollToBottom();
    });
    super.onInit();
  }

  List<String>? highLights() {
    productDetails?.data?.productHighlights?.forEach((value) {
      if (value != null) {
        highlights?.add(value.content);
      }
    });
    return highlights;
  }

  double getDiscountPercentage() {
    final price = productDetails?.data?.price ?? 0.0;
    final wholesalePrice = productDetails?.data?.wholesalePrice ?? 0.0;

    if (price == 0) return 0.0;

    return ((price - wholesalePrice) / price) * 100;
  }

  double getDiscountedPercentage() {
    final price =
        campaignDetailsResponseModel.data?.productDetails?.price ?? 0.0;
    final wholesalePrice =
        campaignDetailsResponseModel.data?.productDetails?.wholesalePrice ??
            0.0;

    if (price == 0) return 0.0;

    return ((price - wholesalePrice) / price) * 100;
  }

  getArguments() {
    if (Get.arguments != null) {
      isForCampaignEdit = Get.arguments[argIsForCampaignEdit] ?? false;
      campaignId = Get.arguments[argCampaignId] ?? "";
      isRouteFromCampaignDetails =
          Get.arguments[argIsRouteFromCampaignDetails] ?? false;
      if (isRouteFromCampaignDetails == true) {
        campaignDetailsResponseModel = Get.arguments[argCampaignDetails];
        Future.delayed(
          const Duration(seconds: 1),
          () {
            htmlController.insertHtml(
                (campaignDetailsResponseModel.data?.description ?? '').trim());
          },
        );
      }
    }
    update();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      image = await cropImage(result.files.single.path!);
      debugPrint("Image is $image");
      if(image!=null)
        {
          docImagePath = image.path;
          debugPrint("Path is $docImagePath");
          isImageUploaded = true;
          update();
        }
    }
    update();
  }

  Future<PickedFile?> cropImage(filePath) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.original],
    );
    if (croppedImage == null) {
      showToast(message: "Image not selected");
    } else {
      debugPrint('The path is:${croppedImage.path}');
      return PickedFile(croppedImage.path);
    }
    return null;
  }

  removeVideo() {
    docVideoPath = "";
    isVideoUploaded = false;
    if (isRouteFromCampaignDetails == true) {
      campaignDetailsResponseModel.data?.video = "";
      docVideoPath = "";
      isVideoUploaded = false;
    }

    update();
  }

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      File videoFile = File(result.files.single.path!);
      int fileSizeInBytes = await videoFile.length();
      double fileSizeInMB=fileSizeInBytes/(1024 * 1024);
      debugPrint("File Size in MB are ${fileSizeInMB}");
      if(fileSizeInMB<=300)
        {
          docVideoPath = result.files.single.path!;
          update();
          isVideoUploaded = true;
        }
      else
        {
          showToast(message: "Video file is too large. Maximum allowed size is 300 MB.");
        }

      update();
    }
  }

  onDateChange(bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: Get.overlayContext!,
        firstDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: AppColors.gradient2nd, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: AppColors.gradient2nd, // body text color
              ),
              dialogBackgroundColor: Colors.white, // background color
            ),
            child: child!,
          );
        },
        lastDate: _maxLastDate?.add(const Duration(days: 7)) ?? DateTime(3000),
        initialDate: DateTime.now());
    if (pickedDate == null) return;
    _maxLastDate = pickedDate;
    if (isStartDate) {
      startDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      startDate = pickedDate.millisecondsSinceEpoch;
    } else {
      endDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      DateTime endDateWithTime =
          pickedDate.add(const Duration(hours: 23, minutes: 59, seconds: 00));
      endDate = endDateWithTime.millisecondsSinceEpoch;
    }
  }

  hitCreateCampaignApiCall() async {
    if (isImageUploaded == true && isVideoUploaded == true) {
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
      videoUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docVideoPath, "video");
    } else if (isImageUploaded == true) {
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
    } else if (isVideoUploaded == true) {
      videoUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docVideoPath, "video");
    }

    String htmlText = await htmlController.getText();
    Map<String, dynamic> requestModel =
        DetailsRequestModel.createCampaignRequestModel(
            campaignName: campaignNameController.text,
            campaignId: alreadyCreatedCampaignId,
            productId: productDetails?.data?.sId,
            groupId: groupId,
            startDate: startDate,
            endDate: endDate,
            image: imageUploadResponse?.data?.fileName ?? "",
            video: isVideoUploaded == true
                ? videoUploadResponse?.data?.fileName ?? ""
                : "",
            description: htmlText);
    _apiRepository
        .createCampaignApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        startCampaignResponseModel = value;
        alreadyCreatedCampaignId = startCampaignResponseModel.data?.sId;
        Get.toNamed(AppRoutes.startCampaignSecondScreenRoute, arguments: {
          argCampaignId: startCampaignResponseModel.data?.sId,
          argProductId: startCampaignResponseModel.data?.productId
        });
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitEditCampaignApiCall() async {
    if (isImageUploaded == true && isVideoUploaded == true) {
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
      videoUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docVideoPath, "video");
    } else if (isImageUploaded == true) {
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
    } else if (isVideoUploaded == true) {
      videoUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docVideoPath, "video");
    }
    String htmlText = await htmlController.getText();
    Map<String, dynamic> requestModel =
        DetailsRequestModel.editCampaignRequestModel(
            id: campaignId,
            campaignName: campaignNameController.text,
            productId: campaignDetailsResponseModel.data?.productDetails?.sId,
            groupId: campaignDetailsResponseModel.data?.groupId?.sId,
            startDate: startDate,
            endDate: endDate,
            image: imageUploadResponse?.data?.fileName ?? "",
            video: videoUploadResponse?.data?.fileName ?? "string",
            description: htmlText);

    _apiRepository.editCampaignApiCall(dataBody: requestModel).then((value) {
      if (value != null) {
        editCampaignResponseModel = value;
        Get.offAllNamed(AppRoutes.viewAllCampaignsScreenRoute,
            arguments: {argBottomNavigationIndex:1});
        showToast(message: editCampaignResponseModel.message);
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getUserGroupsApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productFaqRequestModel();
    _apiRepository.getUserGroupList(queryBody: requestModel).then((value) {
      if (value != null) {
        userGroupListResponseModel = value;
        for (var groupData in (userGroupListResponseModel?.data ?? [])) {
          if (groupData.groupName != "quantity savers") {
            items.add(groupData.groupName);
          }
        }
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  Future<void> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditorFocus.dispose();
    super.dispose();
  }

  @override
  onReady() {
    super.onReady();
  }

  onChangeDropDownValue(String? str) async {
    selectedValue?.value = str ?? "";
    for (var groupData in (userGroupListResponseModel.data ?? [])) {
      if (groupData.groupName == (str ?? "")) {
        groupId = groupData.sId ?? "";
      }
    }
    update();
  }
}
