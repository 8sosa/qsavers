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
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/profile/controllers/campaign_request_details_controller.dart';
import '../../../export.dart';
import '../../profile/models/response_model/campaign_request_details_response_model.dart';
import '../models/data_models/product_details_data_model.dart';

class RequestCampaignController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  bool isVideoUploaded = false;
  bool isImageUploaded = false;
  bool isVideoPlayed = false;
  String docImagePath = "";
  String docVideoPath = "";
  bool isRouteFromEditCampaignRequest = false;
  CampaignRequestDetailsResponseModel campaignRequestDetailsResponseModel =
      CampaignRequestDetailsResponseModel();
  ProductDetailsDataModel? productDetails;
  final HtmlEditorController htmlController = HtmlEditorController();
  ImageResposemodel? videoUploadResponse = ImageResposemodel();
  ImageResposemodel? imageUploadResponse = ImageResposemodel();
  RxBool showSuffixIcon = false.obs;
  TextEditingController searchFieldText = TextEditingController();
  FocusNode searchFieldFocusNode = FocusNode();
  RxString htmlContent = "".obs;
  var editorMaxLength = 200;
  bool isLoading = false;
  var totalReviews = 0;
  CampaignRequestDetailsController? campaignRequestDetailsController;
  ProductDetailsResponseModel productDetailsResponseModel = ProductDetailsResponseModel();

  @override
  void onInit() {
    if (Get.isRegistered<ProductDetailsController>(tag:productDetailTag)) {
      productDetails =
          Get.find<ProductDetailsController>(tag:productDetailTag).productDetailsResponseModel.data;
    }
    if (Get.isRegistered<CampaignRequestDetailsController>()) {
      campaignRequestDetailsController =
          Get.find<CampaignRequestDetailsController>();
    }

    getArguments();
    lightTheme(color: AppColors.appColor);
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isRouteFromEditCampaignRequest =
          Get.arguments[argIsRouteFromEditCampaignRequest] ?? false;
      campaignRequestDetailsResponseModel =
          Get.arguments[argCampaignRequestDetails];
      debugPrint("our prdct id is ${campaignRequestDetailsResponseModel.data?.productId}");
      if (campaignRequestDetailsResponseModel.data != null) {
        // productDetails = campaignRequestDetailsResponseModel.data?.productId;
        Future.delayed(
          const Duration(seconds: 1),
          () {
            htmlController.insertHtml(
                (campaignRequestDetailsResponseModel.data?.description ?? '')
                    .trim());
          },
        );
      }
      if(isRouteFromEditCampaignRequest==true)
        {
          hitGetProductsDetailsApi(campaignRequestDetailsResponseModel.data?.productId['_id']);
        }
    }
    update();
  }

  hitGetProductsDetailsApi(var productId) {

    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productDetailsRequestModel(id: productId);

    _apiRepository
        .getProductDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        productDetailsResponseModel = value;
        productId = productDetailsResponseModel.data?.sId ?? "";
        if (productDetailsResponseModel.data != null) {
          productDetailsResponseModel.data!.productVariations ??=
          []; // Ensure productVariations list is initialized
          productDetailsResponseModel.data!.productVariations!.insert(
            0,
            ProductVariations(
                sId: productDetailsResponseModel.data!.sId ?? "",
                name: productDetailsResponseModel.data!.name ?? "",
                price: productDetailsResponseModel.data!.price ?? 0,
                discountPrice:
                productDetailsResponseModel.data!.discountPrice ?? 0.0,
                quantity: productDetailsResponseModel.data!.quantity ?? 0,
                productId: productDetailsResponseModel.data!.sId ?? "",
                wholesaleQuntity:
                productDetailsResponseModel.data!.wholesaleQuntity ?? 0),
          );
        }
        totalReviews = productDetailsResponseModel.data?.totalReviews ?? 0;
        isLoading = false;
        // hitGetProductReviewApi(productDetailsResponseModel.data?.sId);
        update();
      }
    }).catchError((error, stackTrace) {
      debugPrint("message: '$stackTrace'");
    });
  }

  updateSuffixIconVisibility() async {
    if (searchFieldText.length > 0) {
      showSuffixIcon.value = true;
    } else {
      showSuffixIcon.value = false;
    }
    update();
  }

  clearSearchField() async {
    searchFieldText.clear();
    updateSuffixIconVisibility();
    update();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      docImagePath = result.files.single.path!;
      imageUploadResponse =
          await _apiRepository.uploadImageAndVideoApi(docImagePath, "image");
      isImageUploaded = true;
      update();
    }
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
          if (isVideoUploaded) {
            videoUploadResponse =
            await _apiRepository.uploadImageAndVideoApi(docVideoPath, "video");
          }
        }
      else
        {
          showToast(message: "Video file is too large. Maximum allowed size is 300 MB.");
        }

      update();
    }
  }

  hitSendCampaignStartRequest() async {
    String htmlText = await htmlController.getText();
    Map<String, dynamic> requestModel =
        DetailsRequestModel.createCampaignRequestModel(
            productId: productDetails?.sId,
            image: imageUploadResponse?.data?.fileName ?? "",
            video: isVideoUploaded==true? videoUploadResponse?.data?.fileName ?? "" : "",
            description: htmlText);
    _apiRepository
        .sendCampaignRequestApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        campaignRequestDetailsResponseModel = value;
        Get.back();
        showToast(message: "Request raised successfully");
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitEditCampaignEditRequest() async {
    String htmlText = await htmlController.getText();
    Map<String, dynamic> requestModel =
        DetailsRequestModel.createCampaignRequestModel(
            productId: productDetails?.sId,
            image: imageUploadResponse?.data?.fileName ?? "",
            video: videoUploadResponse?.data?.fileName ?? "",
            description: htmlText);
    _apiRepository
        .editCampaignRequestApiCall(
            dataBody: requestModel,
            id: campaignRequestDetailsResponseModel.data?.sId)
        .then((value) async {
      if (value != null) {
        campaignRequestDetailsResponseModel = value;
        campaignRequestDetailsController?.hitGetCampaignRequestDetailsApi();
        Get.back();
        showToast(message: "Edited successfully");
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void dispose() {
    searchFieldFocusNode.dispose();
    super.dispose();
  }
}
