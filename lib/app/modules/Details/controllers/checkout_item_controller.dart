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

import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:quantity_savers/app/core/utils/time_conversion.dart';
import 'package:quantity_savers/app/modules/Details/models/data_models/joined_campaign_data_model.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import '../../../export.dart';

class CheckoutItemController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();

  var argument = "";
  bool isRouteFromCampaignOrder = false;
  var campaignId = "";
  // int? value ;
  bool isLoading = false;
  RxString? selectedQuantityValue = "1".obs;
  final List<String> itemsCount = List.generate(5, (index) => "${index + 1}");
  CartDataResponseModel? cartDataResponseModel = CartDataResponseModel();
  PriceDetailsResponseModel? priceDetailsResponseModel =
      PriceDetailsResponseModel();
  JoinedCampaignDetailResponseModel? joinedCampaignDetailResponseModel =
      JoinedCampaignDetailResponseModel();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  List<int> timeComponents = convertMs(1000);

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    getArguments();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      isRouteFromCampaignOrder =
          Get.arguments[argIsRouteFromCampaignOrder] ?? false;
      // value=Get.arguments[argProductQuantity] ?? 0;
      if (isRouteFromCampaignOrder) {
        campaignId = Get.arguments[argCampaignId];
        getCampaignCartDatApiCall();
      } else {
        getCartDatApiCall();
        getPriceDetailApiCall();
      }
    }
  }

  double getDiscountPercentage() {
    final wholesalePrice =
        joinedCampaignDetailResponseModel
        ?.data
        ?.mainProductDetails?.wholesalePrice?? 0.0;
    final price = joinedCampaignDetailResponseModel
        ?.data
        ?.mainProductDetails?.price ?? 0.0;

    if (price == 0) return 0.0;

    return ((price-wholesalePrice) / price) * 100;
  }

  getCartDatApiCall() {
    isLoading = true;
    _apiRepository.getCartDataApiCall(queryBody: null).then((value) {
      if (value != null) {
        cartDataResponseModel = value;
        selectedQuantityValue?.value =
            "${cartDataResponseModel?.data?.data?[0].quantity ?? 0}";
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getPriceDetailApiCall() {
    _apiRepository.getPriceDetailsApiCall(queryBody: null).then((value) {
      if (value != null) {
        priceDetailsResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  onChangeDropDownValueQuantity(String? str) async {
    selectedQuantityValue?.value = str ?? "";
    debugPrint("${selectedQuantityValue?.value}");
    updateToCartApi();
    update();
  }

  updateToCartApi() {
    Map<String, dynamic> requestModel =
        DetailsRequestModel.updateToCartRequestModel(
            id: cartDataResponseModel?.data?.data?[0].sId ?? "",
            quantity: int.parse(selectedQuantityValue!.value));
    _apiRepository
        .updateProductToCartApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        getCartDatApiCall();
        getPriceDetailApiCall();
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  getCampaignCartDatApiCall() {
    isLoading = true;
    _apiRepository.getCampaignCartData(id: campaignId).then((value) {
      if (value != null) {
        joinedCampaignDetailResponseModel = value;
        startTimer();
        if (joinedCampaignDetailResponseModel?.data != null) {
          joinedCampaignDetailResponseModel
                  ?.data?.mainProductDetails?.productVariations ??=
              []; // Ensure productVariations list is initialized
          joinedCampaignDetailResponseModel
              ?.data?.mainProductDetails?.productVariations!
              .insert(
            0,
            ProductVariations(
              sId: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.sId ??
                  "",
              name: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.name ??
                  "",
              price: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.price ??
                  0,
              discountPrice: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.discountPrice ??
                  0.0,
              quantity: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.quantity ??
                  0,
              productId: joinedCampaignDetailResponseModel
                      ?.data?.mainProductDetails?.prodctId ??
                  "",
            ),
          );
        }
        isLoading = false;
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  updateCampaignApiCall() async {
    List<Map<String, dynamic>> selectedProducts = [];
    var totalQuantity = 0;
    for (Products? prducts
        in (joinedCampaignDetailResponseModel?.data?.products ?? [])) {
      final Map<String, dynamic> product = {
        "product_id": prducts?.productId?.sId ?? "",
        "quantity": prducts?.quantity ?? 0,
      };
      totalQuantity = totalQuantity + int.parse("${prducts?.quantity ?? 0}");
      selectedProducts.add(product);
    }
    Map<String, dynamic> requestModel =
        DetailsRequestModel.joinCampaignRequestModel(
            id: joinedCampaignDetailResponseModel?.data?.campaignId?.sId ?? "",
            products: selectedProducts,
            totalQuantity: totalQuantity);
    _apiRepository
        .updateCampaignApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        getCampaignCartDatApiCall();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  startTimer() {
    int endDateMillis =
        joinedCampaignDetailResponseModel?.data?.campaignId?.endDate ?? 0;
    int differenceMillis =
        endDateMillis - int.parse("${DateTime.now().millisecondsSinceEpoch}");
    debugPrint("time: ${differenceMillis}");
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (differenceMillis <= 0) {
        timer.cancel();
        print("Timer ended!");
      } else {
        timeComponents = convertMs(differenceMillis);
        differenceMillis -= 1000;
      }
      update();
    });
  }
}
