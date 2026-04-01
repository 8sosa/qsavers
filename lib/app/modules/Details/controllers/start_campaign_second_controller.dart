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

import 'dart:core';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/product_details_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/join_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/start_campaign_response_model.dart';

import '../../../export.dart';

class StartCampaignSecondController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
   ProductDetailsResponseModel? productDetails;
  CampaignDetailsResponseModel campaignDetailsResponseModel =
      CampaignDetailsResponseModel();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  bool isRouteFromCampaignDetails = false;
  String campaignId = "";
  var productId;
  var join=false;
  var totalReviews = 0;
  bool isLoading =false;
  List<Map<String, dynamic>> selectedProducts = [];
  JoinCampaignResponseModel joinCampaignResponseModel =
      JoinCampaignResponseModel();
  // ProductDetailsResponseModel productDetailsResponseModel = ProductDetailsResponseModel();
  var quantity=false;
  var allQuantity=false;
  var value=1;

  @override
  void onInit() {
    // if (Get.isRegistered<ProductDetailsController>(tag:productDetailTag)) {
    //   productDetails =
    //       Get.find<ProductDetailsController>(tag:productDetailTag).productDetailsResponseModel;
    // }
    lightTheme(color: AppColors.appColor);
    getArguments();

    autoSelectQuantity();
    super.onInit();
  }


  double getDiscountPercentage() {
    final price = productDetails?.data?.price ?? 0.0;
    final wholesalePrice = productDetails?.data?.wholesalePrice ?? 0.0;

    if (price == 0) return 0.0;

    return ((price - wholesalePrice) / price) * 100;
  }

  double getDiscountedPercentage() {
    final price = campaignDetailsResponseModel.data?.productDetails?.price ?? 0.0;
    final wholesalePrice = campaignDetailsResponseModel.data?.productDetails?.wholesalePrice ?? 0.0;

    if (price == 0) return 0.0;

    return ((price - wholesalePrice) / price) * 100;
  }

  @override
  void onReady()
  {
    if(join==true)
      {
        showToast(message: "You can not exit the campaign when only 4 hours to left");
      }

  }

  getArguments() {
    if (Get.arguments != null) {
      isRouteFromCampaignDetails =
          Get.arguments[argIsRouteFromStartCampaign] ?? false;
      join=Get.arguments[argJoin] ?? false;
      if (isRouteFromCampaignDetails) {
        campaignDetailsResponseModel = Get.arguments[argProductDetails];
      }
      campaignId = Get.arguments[argCampaignId];
      productId = Get.arguments[argProductId];
       hitGetProductsDetailsApi();
    }
  }

  hitGetProductsDetailsApi({bool showLoader=true}) {
    if(showLoader)
    {
      isLoading = true;
    }
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productDetailsRequestModel(id: productId);
    _apiRepository
        .getProductDetailsApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        productDetails = value;
        productId = productDetails?.data?.sId ?? "";
        if (productDetails?.data != null) {
          productDetails?.data!.productVariations ??=
          []; // Ensure productVariations list is initialized

          productDetails!.data!.productVariations!.forEach((variation) {
            variation.quantity = 1;
          });

          productDetails?.data!.productVariations!.insert(
            0,
            ProductVariations(
                sId: productDetails?.data!.sId ?? "",
                name: productDetails?.data!.name ?? "",
                price: productDetails?.data!.price ?? 0,
                discountPrice:
                productDetails?.data!.discountPrice ?? 0.0,
                quantity: 1,
                productId: productDetails?.data!.sId ?? "",
                wholesaleQuntity:
                productDetails?.data!.wholesaleQuntity ?? 0),
          );
        }
        totalReviews = productDetails?.data?.totalReviews ?? 0;
        isLoading = false;
        // hitGetProductReviewApi(productDetailsResponseModel.data?.sId);
        update();
      }
    }).catchError((error, stackTrace) {
      debugPrint("message: '$stackTrace'");
    });
  }

  autoSelectQuantity() {
    for (int index = 0;
        index <
            (isRouteFromCampaignDetails == true
                    ? campaignDetailsResponseModel
                        .data?.productDetails?.productVariations
                    : productDetails?.data?.productVariations ?? [])!
                .length;
        index++) {
      updateSelectedQuantity("1", index);
    }
  }

  void updateSelectedQuantity(String value, int variantIndex) {

        quantity=true;

    debugPrint('GetValue is $value');

    value=value;

    if (isRouteFromCampaignDetails == true) {
      campaignDetailsResponseModel.data?.productDetails
          ?.productVariations?[variantIndex].quantity  =  int.parse(value);
    } else {
      productDetails?.data?.productVariations?[variantIndex].quantity =
          int.parse(value);
    }
    update();
  }

  hitJoinCampaignApiCall() async {
    if (isRouteFromCampaignDetails == true) {
      campaignDetailsResponseModel.data?.productDetails?.productVariations
          ?.forEach((element) {
        selectedProducts.add(
            {"product_id": element.productId, "quantity":element.quantity});
      });
    } else {
      productDetails?.data?.productVariations?.forEach((element) {
        selectedProducts.add(
            {"product_id": element.productId, "quantity":element.quantity});
      });
    }

    int totalQuantity = selectedProducts.fold(
        0, (prev, curr) => prev + (curr['quantity'] as int));
    if (totalQuantity == 0) {
      showToast(message: "Quantity is Required");
      return;
    }

    Map<String, dynamic> requestModel =
        DetailsRequestModel.joinCampaignRequestModel(
            id: campaignId,
            products: selectedProducts,
            totalQuantity: totalQuantity);
    debugPrint("Total quantity is $totalQuantity");
    debugPrint("Total quantity is $quantity");
    _apiRepository
        .joinCampaignApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        joinCampaignResponseModel = value;
        selectedProducts = [];
        totalQuantity = 0;
        Get.toNamed(AppRoutes.checkoutItemScreenRoute, arguments: {
          argForCheckout: strForJoin,
          argIsRouteFromCampaignOrder: true,
          argCampaignId: joinCampaignResponseModel.data?.campaignId ?? "",
          argProductQuantity:quantity==true?value:1
        });
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
