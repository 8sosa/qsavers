import "package:quantity_savers/app/modules/Details/models/data_models/joined_campaign_data_model.dart";
import "package:quantity_savers/app/modules/Details/models/details_request_model.dart";
import "package:quantity_savers/app/modules/payment/models/responce_models/apply_coupon_response_model.dart";
import "package:quantity_savers/app/modules/profile/models/response_model/card_delete_response_model.dart";

import "../../../export.dart";

class PaymentController extends GetxController {
  final APIRepository _repository = Get.find<APIRepository>();
  bool isForMakePayment = false;
  var selectedIndex = -1;
  var isForCampaign = false;
  var count = 0;
  var applied = 0;
  bool isRouteFromProfilePayment = false;
  bool isApplyCoupon = false;
  String deleteCardId = "";
  CartDataResponseModel? cartDataResponseModel;
  CardsListResponseModel? cardsListResponseModel = CardsListResponseModel();
  PriceDetailsResponseModel? priceDetailsResponseModel;
  ManageAddressDataSubData? manageAddressDataSubData =
      ManageAddressDataSubData();
  JoinedCampaignDetailResponseModel? joinedCampaignDetailResponseModel;
  CheckOutResponceModel? checkOutResponseModel = CheckOutResponceModel();
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  CardDeleteResponseModel cardDeleteResponseModel = CardDeleteResponseModel();
  ApplyCouponResponseModel applyCouponResponseModel =
      ApplyCouponResponseModel();
  CheckoutItemController? checkoutItemController;
  var startPrice;
  var startDiscount;

  @override
  void onInit() {
    if (Get.isRegistered<CheckoutItemController>()) {
      checkoutItemController = Get.find<CheckoutItemController>();
    }

    if (Get.isRegistered<CheckoutItemController>()) {
      cartDataResponseModel =
          Get.find<CheckoutItemController>().cartDataResponseModel;
      priceDetailsResponseModel =
          Get.find<CheckoutItemController>().priceDetailsResponseModel;
      joinedCampaignDetailResponseModel =
          Get.find<CheckoutItemController>().joinedCampaignDetailResponseModel;
    }
    lightTheme(color: AppColors.appColor);
    getArguments();
    getCardListData();
    startPrice = priceDetailsResponseModel?.data?.totalPrice;
    startDiscount = priceDetailsResponseModel?.data?.discount;
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getArguments() {
    if (Get.arguments != null) {
      isForMakePayment = Get.arguments[argForPayment] ?? false;
      manageAddressDataSubData = Get.arguments[argAddressData];
      isForCampaign = Get.arguments[argForCompaign] ?? false;
      isRouteFromProfilePayment =
          Get.arguments[argIsRouteFromProfilePayment] ?? false;
      update();
    }
  }

  // void clearFields() {
  //   count = 0;
  //   applied = 0;
  //   isApplyCoupon = false;
  //   textEditingController.clear();
  //   priceDetailsResponseModel?.data?.totalPrice = startPrice;
  //   priceDetailsResponseModel?.data?.discount = startDiscount;
  //   update(); // Update the UI
  // }

  getCardListData() async {
    var requestModel = HomepageRequestModel.productCategoriesRequestModel();
    _repository.listCardsApiCall(queryBody: requestModel).then((value) async {
      if (value != null) {
        cardsListResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  hitDeleteCardApi() async {
    _repository.deleteCardApiCall(id: deleteCardId).then((value) async {
      if (value != null) {
        cardDeleteResponseModel = value;
        showToast(message: cardDeleteResponseModel.data);
        getCardListData();
        update();
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  checkOutAPiCall() async {
    debugPrint("${priceDetailsResponseModel?.data?.totalPrice}");
    var requestModel = PaymentsRequestsModel.makePaymentRequestModel(
      products: [
        PaymentsRequestsModel.products(
          productId: cartDataResponseModel?.data?.data?[0].productId?.sId ?? "",
          quantity: cartDataResponseModel?.data?.data?[0].quantity ?? 0,
          deliveryPrice: 0,
        )
      ],
      cardId: cardsListResponseModel?.data?.data?[selectedIndex].sId ?? "",
      addressId: manageAddressDataSubData?.sId ?? "",
      couponCode: textEditingController.text.isNotEmpty
          ? textEditingController.text.trim()
          : null,
    );
    _repository.checkOutApiCall(queryBody: requestModel).then((value) async {
      if (value != null) {
        showToast(message: "Order placed successfully");
        checkOutResponseModel = value;
        Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
          argForOrderPlaced: strForNormalOrderPlace,
          argForOrderPlacedData: checkOutResponseModel,
          argShow: true
        });
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  checkOutCampaignAPiCall() async {
    List<Map<String, dynamic>> allProducts = [];
    for (Products product
        in (joinedCampaignDetailResponseModel?.data?.products ?? [])) {
      allProducts.add(PaymentsRequestsModel.products(
        productId: product.productId?.sId ?? "",
        quantity: product.quantity ?? 0,
      ));
    }
    var requestModel = PaymentsRequestsModel.makePaymentRequestModel(
        cardId: cardsListResponseModel?.data?.data?[selectedIndex].sId ?? "",
        products: allProducts,
        addressId: manageAddressDataSubData?.sId ?? "",
        campaignId:
            joinedCampaignDetailResponseModel?.data?.campaignId?.sId ?? "",
        totalQuantity:
            joinedCampaignDetailResponseModel?.data?.totalQuantity ?? "");

    _repository
        .checkOutForCampaignApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        showToast(message: "Order placed successfully");
        checkOutResponseModel = value;
        Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
          argForOrderPlaced: strForCampaignOrderPlace,
          argForCompaign: true,
          argForOrderPlacedData: checkOutResponseModel,
          argShow: true
        });
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }

  applyCouponApi() {
    isApplyCoupon = true;
    var requestModel = DetailsRequestModel.couponApplyRequestModel(
        name: textEditingController.text);
    _repository.applyCouponsApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        applied = 1;
        count = 2;
        applyCouponResponseModel = value;
        debugPrint(
            "Discount is ${applyCouponResponseModel.data?.couponDiscount}");
        showToast(message: applyCouponResponseModel.message.toString());
        priceDetailsResponseModel?.data?.totalPrice =
            priceDetailsResponseModel?.data?.totalPrice -
                applyCouponResponseModel.data?.couponDiscount;
        priceDetailsResponseModel?.data?.discount =
            priceDetailsResponseModel?.data?.discount +
                applyCouponResponseModel.data?.couponDiscount;
        update();
      }
    }).onError((error, stackTrace) {
      isApplyCoupon = false;
      showToast(message: error.toString());
    });
  }
}
