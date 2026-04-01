import "package:quantity_savers/app/modules/payment/models/add_card_stripe_model.dart";
import "package:quantity_savers/app/modules/payment/models/responce_models/add_payment_method_response_model.dart";
import "package:quantity_savers/app/modules/Details/models/data_models/joined_campaign_data_model.dart";

import "../../../export.dart";

class AddNewCardController extends GetxController {
  var isChecked = true;
  var isForAddNew = false;
  var isForCampaign = false;

  final APIRepository _apiRepository = Get.find<APIRepository>();
  TextEditingController cardTextController = TextEditingController();
  TextEditingController cvcTextController = TextEditingController();
  TextEditingController cardHolderNameTextController = TextEditingController();
  TextEditingController expTextController = TextEditingController();

  FocusNode? cardFocusNode = FocusNode();
  FocusNode? cvcFocusNode = FocusNode();
  FocusNode? cardHolderFocusNode = FocusNode();
  FocusNode? expFocusNode = FocusNode();

  CartDataResponseModel? cartDataResponceModel = CartDataResponseModel();
  PriceDetailsResponseModel? priceDetailsResponceModel =
      PriceDetailsResponseModel();
  ManageAddressDataSubData? manageAddressDataSubData =
      ManageAddressDataSubData();
  AddPaymentMethodResponce addPaymentMethodResponce =
      AddPaymentMethodResponce();
  PaymentReasponceModel? paymentResponseModel = PaymentReasponceModel();
  JoinedCampaignDetailResponseModel? joinedCampaignDetailResponceModel =
      JoinedCampaignDetailResponseModel();
  CheckOutResponceModel? checkOutResponceModel = CheckOutResponceModel();
  PaymentController? paymentController;

  @override
  void onInit() {
    if (Get.isRegistered<PaymentController>()) {
      paymentController = Get.find<PaymentController>();
    }
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
      manageAddressDataSubData = Get.arguments[argAddressData];
      cartDataResponceModel = Get.arguments[argCartDataResponceModel];
      joinedCampaignDetailResponceModel =
          Get.arguments[argJoinedCampaignDetailResponceModel];
      priceDetailsResponceModel = Get.arguments[argPriceDetailsResponceModel];
      isForAddNew = Get.arguments[argForAddNew];
      if (Get.arguments[argForCompaign] != null) {
        isForCampaign = Get.arguments[argForCompaign];
        debugPrint("$isForAddNew");
      }
    }
  }

  getStripeCardTokenApiCall() async {
    List<String> parts = expTextController.text.split('/');
    String month = parts[0]; // Extract month
    String year = parts[1];
    var requestModel = StripeCardRequestModel.stripeRequestModel(
      cardNo: cardTextController.text,
      cvc: cvcTextController.text,
      expYear: year,
      expMonth: month,
    );
    _apiRepository
        .generatePaymentMethod(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        paymentResponseModel = value;
        isForAddNew
            ? addCardTokenApiCall(paymentResponseModel, true)
            : addCardTokenApiCall(paymentResponseModel, true);
      }
    }).onError((error, stackTrace) {
      showToast(message: 'Please enter valid details');
    });
  }

  addCardTokenApiCall(
      PaymentReasponceModel? paymentReasponceModel, bool isSave) async {
    var requestModel = StripeCardRequestModel.addCardRequestModel(
      paymentMethod: paymentReasponceModel?.id ?? "",
      isSaved: isSave,
    );
    _apiRepository
        .addPaymentMethodApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        addPaymentMethodResponce = value;
        if (isForAddNew == true) {
          paymentController?.getCardListData();
          Get.back(result: true);
        } else {
          (isForCampaign) ? checkOutCampaignAPiCall() : checkOutAPiCall();
        }
      }
    }).onError((error, stackTrace) {
      showToast(message:"Please enter valid details");
    });
  }

  onChangeCheckValue() {
    isChecked = !isChecked;
    update();
  }

  checkOutAPiCall() async {
    debugPrint("${priceDetailsResponceModel?.data?.totalPrice}");
    var requestModel = PaymentsRequestsModel.makePaymentRequestModel(
      products: [
        PaymentsRequestsModel.products(
          productId: cartDataResponceModel?.data?.data?[0].productId?.sId ?? "",
          quantity: cartDataResponceModel?.data?.data?[0].quantity ?? 0,
          deliveryPrice:0,
        )
      ],
      cardId: addPaymentMethodResponce.data?.sId ?? "",
      addressId: manageAddressDataSubData?.sId ?? "",
    );
    _apiRepository.checkOutApiCall(queryBody: requestModel).then((value) async {
      if (value != null) {
        checkOutResponceModel = value;
        Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
          argForOrderPlaced: strForNormalOrderPlace,
          argForOrderPlacedData: checkOutResponceModel
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
        in (joinedCampaignDetailResponceModel?.data?.products ?? [])) {
      allProducts.add(PaymentsRequestsModel.products(
        productId: product.productId?.sId ?? "",
        quantity: product.quantity ?? 0,
      ));
    }

    var requestModel = PaymentsRequestsModel.makePaymentRequestModel(
        cardId: addPaymentMethodResponce?.data?.sId ?? "",
        products: allProducts,
        addressId: manageAddressDataSubData?.sId ?? "",
        campaignId:
            joinedCampaignDetailResponceModel?.data?.campaignId?.sId ?? "",
        totalQuantity: joinedCampaignDetailResponceModel?.data?.totalQuantity ??
                "".runtimeType == String
            ? int.parse(
                joinedCampaignDetailResponceModel?.data?.totalQuantity ?? "")
            : joinedCampaignDetailResponceModel?.data?.totalQuantity ?? "");
    _apiRepository
        .checkOutForCampaignApiCall(queryBody: requestModel)
        .then((value) async {
      if (value != null) {
        checkOutResponceModel = value;
        Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
          argForOrderPlaced: strForCampaignOrderPlace,
          argForCompaign: true,
          argForOrderPlacedData: checkOutResponceModel
        });
      }
    }).onError((error, stackTrace) {
      showToast(message: error.toString());
    });
    update();
  }
}
