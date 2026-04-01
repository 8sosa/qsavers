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

import 'package:another_stepper/another_stepper.dart';
import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/can_add_review_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/download_invoice_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/order_place_response_model.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_completed_order_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/order_cancellation_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/user_product_review_response_model.dart';

import '../../../export.dart';
import '../../my_orders/data_model/order_data_model.dart';

class OrderPlacedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  var isLinkActivate = true;
  var argument = "";
  var bottomButtonTitle = "";
  var afterReviewed = false;
  var isLoading = true;
  var orderId = "";
  var productId = "";
  var reviewId = "";
  var title = "";
  var bannerTitle = "";
  bool show = false;
  var bannerSubTitle = "";
  var activeIndex = 0;
  var isForCampaign = false;
  var isForOrderScreen = false;
  var isForNotificationScreen = false;
  String campaignId = "";
  var result;
  String _pdfPath = '';
  String startFormattedDate = '';
  bool isForViewOrderDetails = false;
  OrdersController ordersController = OrdersController();
  CheckOutResponceModel checkOutResponceModel = CheckOutResponceModel();
  CampaignDetailsResponseModel campaignDetailsResponseModel =
      CampaignDetailsResponseModel();
  JoinedCampaignDetailResponseModel joinedCampaignDetailResponseModel =
      JoinedCampaignDetailResponseModel();
  OrderDetailsResponceModel orderDetailsResponceModel =
      OrderDetailsResponceModel();
  CampaignCompletedOrderResponseModel campaignCompletedOrderResponseModel =
      CampaignCompletedOrderResponseModel();
  OrderDataModel orderDataModel = OrderDataModel();
  UserProductReviewResponseModel userProductReviewResponseModel =
      UserProductReviewResponseModel();
  CanAddReviewResponseModel canAddReviewResponseModel =
      CanAddReviewResponseModel();
  DownloadInvoiceResponseModel downloadInvoiceResponseModel =
      DownloadInvoiceResponseModel();
  OrderCancellationRequestResponseModel orderCancellationRequestResponseModel =
      OrderCancellationRequestResponseModel();

  List<StepperData> stepperData = [];
  LocalStorage _localStorage = LocalStorage();
  dynamic token = "";

  @override
  void onReady() {
    if (_localStorage.getAuthToken() != null) {
      token = _localStorage.getAuthToken();
      debugPrint("Access token is $token");
    }
  }

  @override
  void onInit() {
    if (Get.isRegistered<OrdersController>()) {
      ordersController = Get.find<OrdersController>();
    }
    lightTheme(color: AppColors.appColor);
    getArguments();
    initializeStepperData();
    super.onInit();
  }

  void initializeStepperData() {
    if (argument == strOrderCancelled) {
      var startDate =
          int.parse(orderDetailsResponceModel.data?.createdAt ?? '8');
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      String startFormattedDate =
          DateFormat('dd/MMM/yyyy').format(confirmedDate);

      var cancelledDate =
          int.parse(orderDetailsResponceModel.data?.cancelledAt ?? '8');
      DateTime confirmDate = DateTime.fromMillisecondsSinceEpoch(cancelledDate);
      String cancelDate = DateFormat('dd/MMM/yyyy').format(confirmDate);
      stepperData = [
        StepperData(
          title: StepperText(
            "${strOrderrConfirmed.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 0) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 0) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPaid.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 1) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 1) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strCancelled.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 2) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(cancelDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 2) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
      ];
    } else if (argument == "ORDER_CANCELLED_REQUESTED" ||
        argument == "CANCELLED") {
      var startDate =
          int.parse(campaignCompletedOrderResponseModel.data?.createdAt ?? '8');
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      String startFormattedDate =
          DateFormat('dd/MMM/yyyy').format(confirmedDate);

      var cancelledDate = int.parse(campaignCompletedOrderResponseModel
              .data?.orderProducts?[0].cancelledAt ??
          '8');
      DateTime confirmDate = DateTime.fromMillisecondsSinceEpoch(cancelledDate);
      String cancelDate = DateFormat('dd/MMM/yyyy').format(confirmDate);
      stepperData = [
        StepperData(
          title: StepperText(
            "${strOrderrConfirmed.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 0) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 0) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPaid.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 1) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 1) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strCancelled.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 2) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(cancelDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 2) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
      ];
    } else if (argument == "ORDER_CREATED") {
      var startDate =
          int.parse(campaignCompletedOrderResponseModel.data?.createdAt ?? '0');
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      String startFormattedDate =
          DateFormat('dd/MMM/yyyy').format(confirmedDate);

      var shippedDate = int.parse(campaignCompletedOrderResponseModel
              .data?.orderProducts?[0].shippedAt ??
          "0");
      DateTime shippedConFirmedDate =
          DateTime.fromMillisecondsSinceEpoch(shippedDate);
      String shippedFormattedDate =
          DateFormat('dd/MMM/yyyy').format(shippedConFirmedDate);

      var deliveryDate = int.parse(campaignCompletedOrderResponseModel
              .data?.orderProducts?[0].deliveryDate ??
          "0");
      DateTime deliveryConFirmedDate =
          DateTime.fromMillisecondsSinceEpoch(deliveryDate);
      String deliveryFormattedDate =
          DateFormat('dd/MMM/yyyy').format(deliveryConFirmedDate);

      debugPrint('startFormattedDate $startFormattedDate');
      stepperData = [
        StepperData(
          title: StepperText(
            "${isForCampaign == true ? "CAMPAIGN JOINED" : strOrderrConfirmed.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 0) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 0) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPaid.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 1) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 1) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPlaced.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 2) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 2) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            strShipped,
            textStyle: TextStyle(
              color: (activeIndex == 3) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(shippedFormattedDate != "01/Jan/1970"
              ? shippedFormattedDate
              : ""),
          iconWidget: AssetSVGWidget((activeIndex == 3)
              ? iconsRadioFill
              : (activeIndex > 3)
                  ? iconsOrderConfirmRight
                  : iconsRadioUnselected),
        ),
        StepperData(
          title: StepperText(
            "${strOrderDispatched.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 4) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(deliveryFormattedDate != "01/Jan/1970"
              ? deliveryFormattedDate
              : ""),
          iconWidget: AssetSVGWidget((activeIndex == 4)
              ? iconsRadioFill
              : (activeIndex > 4)
                  ? iconsOrderConfirmRight
                  : iconsRadioUnselected),
        ),
        StepperData(
          title: StepperText(
            "${strDelivered.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 5) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(deliveryFormattedDate != "01/Jan/1970"
              ? deliveryFormattedDate
              : ""),
          iconWidget: AssetSVGWidget(
              (activeIndex == 5) ? iconsRadioFill : iconsRadioUnselected),
        ),
      ];
    } else {
      var startDate =
          int.parse(orderDetailsResponceModel.data?.createdAt ?? '0');
      DateTime confirmedDate = DateTime.fromMillisecondsSinceEpoch(startDate);
      String startFormattedDate =
          DateFormat('dd/MMM/yyyy').format(confirmedDate);

      var shippedDate =
          int.parse(orderDetailsResponceModel.data?.shippedAt ?? "0");
      DateTime shippedConFirmedDate =
          DateTime.fromMillisecondsSinceEpoch(shippedDate);
      String shippedFormattedDate =
          DateFormat('dd/MMM/yyyy').format(shippedConFirmedDate);

      var deliveryDate =
          int.parse(orderDetailsResponceModel.data?.deliveryDate ?? "0");
      DateTime deliveryConFirmedDate =
          DateTime.fromMillisecondsSinceEpoch(deliveryDate);
      String deliveryFormattedDate =
          DateFormat('dd/MMM/yyyy').format(deliveryConFirmedDate);

      debugPrint('startFormattedDate $startFormattedDate');
      stepperData = [
        StepperData(
          title: StepperText(
            "${isForCampaign == true ? "CAMPAIGN JOINED" : strOrderrConfirmed.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 0) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 0) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPaid.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 1) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 1) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            "${strOrderPlaced.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 2) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(startFormattedDate),
          iconWidget: AssetSVGWidget(
              (activeIndex == 2) ? iconsRadioFill : iconsOrderConfirmRight),
        ),
        StepperData(
          title: StepperText(
            strShipped,
            textStyle: TextStyle(
              color: (activeIndex == 3) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(shippedFormattedDate != "01/Jan/1970"
              ? shippedFormattedDate
              : ""),
          iconWidget: AssetSVGWidget((activeIndex == 3)
              ? iconsRadioFill
              : (activeIndex > 3)
                  ? iconsOrderConfirmRight
                  : iconsRadioUnselected),
        ),
        StepperData(
          title: StepperText(
            "${strOrderDispatched.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 4) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(deliveryFormattedDate != "01/Jan/1970"
              ? deliveryFormattedDate
              : ""),
          iconWidget: AssetSVGWidget((activeIndex == 4)
              ? iconsRadioFill
              : (activeIndex > 4)
                  ? iconsOrderConfirmRight
                  : iconsRadioUnselected),
        ),
        StepperData(
          title: StepperText(
            "${strDelivered.capitalize}",
            textStyle: TextStyle(
              color: (activeIndex == 5) ? AppColors.gradient2nd : Colors.black,
            ),
          ),
          subtitle: StepperText(deliveryFormattedDate != "01/Jan/1970"
              ? deliveryFormattedDate
              : ""),
          iconWidget: AssetSVGWidget(
              (activeIndex == 5) ? iconsRadioFill : iconsRadioUnselected),
        ),
      ];
    }
  }

  getArguments() {
    if (Get.arguments != null) {
      argument = Get.arguments[argForOrderPlaced];
      if (argument == strOrderConfirmed) {
        bottomButtonTitle = strCancelOrder;
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        hitGetOrderDetailsApi();
      } else if (argument == strOrderCancelled) {
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        debugPrint("This is orderId is $orderId");
        hitGetOrderDetailsApi();
      } else if (argument == strDelivered) {
        bottomButtonTitle = strWriteAProductReview;
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        reviewId = Get.arguments[argReviewId] ?? "";
        hitGetOrderDetailsApi();
      } else if (argument == strForNormalOrderPlace) {
        bottomButtonTitle = strKeepShoping;
        title = strOrderPlaced.toUpperCase();
        bannerTitle = "Order Placed";
        show = Get.arguments[argShow] ?? false;
        bannerSubTitle = strSuccessFullyPlaced;
        checkOutResponceModel = Get.arguments[argForOrderPlacedData];
        orderId = checkOutResponceModel.data?[0].sId ?? "";
        isForCampaign = Get.arguments[argForCompaign] ?? false;
        hitGetOrderDetailsApi();
        update();
      } else if (argument == "ORDER_CREATED") {
        bottomButtonTitle = strCancelOrder;
        title = Get.arguments[argTitle];
        isForNotificationScreen =
            Get.arguments[argIsRouteForNotificationScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        hitGetCampaignCompletedOrderDetailsApi(orderId);
        update();
      } else if (argument == "REQUESTED_CANCELLED") {
        bottomButtonTitle = strCancelOrder;
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        hitGetOrderDetailsApi();
        update();
      }
      else if (argument == "SHIPPED") {
          bottomButtonTitle = strCancelOrder;
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        reviewId = Get.arguments[argReviewId] ?? "";
        hitGetOrderDetailsApi();
        update();
      } else if (argument == "ORDER_CANCELLED_REQUESTED") {
        title = Get.arguments[argTitle];
        isForNotificationScreen =
            Get.arguments[argIsRouteForNotificationScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        debugPrint("This is orderId is $orderId");

        hitGetCampaignCompletedOrderDetailsApi(orderId);
        update();
      } else if (argument == "CANCELLED") {
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        hitGetOrderDetailsApi();
        update();
      }
      /*It is not used because  SHIPPED and  DElIVERED are same, so we use SHIPPED . For USE in Future we make it.*/
      else if (argument == "DELIVERED") {
        bottomButtonTitle = strWriteAProductReview;
        title = Get.arguments[argTitle];
        isForOrderScreen = Get.arguments[argIsRouteForOrderScreen] ?? false;
        orderId = Get.arguments[argOrderId] ?? '';
        reviewId = Get.arguments[argReviewId] ?? "";
        hitGetOrderDetailsApi();
        update();
      } else {
        isForViewOrderDetails =
            Get.arguments[argIsForViewOrderDetails] ?? false;
        if (isForViewOrderDetails == true) {
          if (Get.arguments[argForOrderProductID] != null) {
            orderId = Get.arguments[argForOrderProductID];
            bannerTitle = strCampaignJoined.toUpperCase();
            bannerSubTitle = strSuccessFullyJoined;
            title = strCampaignJoined.toUpperCase();
            hitGetOrderDetailsApi();
            bottomButtonTitle = strViewCampaign;
            isForCampaign = Get.arguments[argForCompaign] ?? "";
          }
        } else {
          checkOutResponceModel = Get.arguments[argForOrderPlacedData];
          orderId = checkOutResponceModel.data?[0].sId ?? "";
          bannerTitle = strCampaignJoined.toUpperCase();
          bannerSubTitle = strSuccessFullyJoined;
          title = strCampaignJoined.toUpperCase();
          hitGetOrderDetailsApi();
          bottomButtonTitle = strViewCampaign;
          isForCampaign = Get.arguments[argForCompaign] ?? "";
          if (isForCampaign == true) {
            show = Get.arguments[argShow] ?? false;
          }
        }
        update();
      }
    }
  }

  hitGetProductReviewApi(var reviewId, var productId) {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.userProductReviewRequestModel(
            reviewId: reviewId, productId: productId);
    _apiRepository
        .userProductReviewApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {
        userProductReviewResponseModel = value;
        isLoading = false;
        afterReviewed = true;
        if (afterReviewed == true) {
          ordersController.getOrderList("DELIVERED");
        }
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitCanAddReviewApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.canAddReviewRequestModel(
            productId: (argument == "ORDER_CANCELLED_REQUESTED" ||
                    argument == "ORDER_CREATED")
                ? campaignCompletedOrderResponseModel
                    .data?.orderProducts![0].productId
                : orderDetailsResponceModel.data?.productId?.sId);
    _apiRepository.canAddReviewApiCall(queryBody: requestModel).then((value) {
      if (value != null) {
        canAddReviewResponseModel = value;
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      showToast(message: error.toString());
    });
  }

  hitGetOrderDetailsApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productDetailsRequestModel();
    _apiRepository
        .getOrderDetailsApiCall(queryBody: requestModel, id: orderId)
        .then((value) {
      if (value != null) {
        orderDetailsResponceModel = value;
        if (reviewId != "") {
          hitGetProductReviewApi(
              reviewId, orderDetailsResponceModel.data?.productId?.sId);
        }
        if (orderDetailsResponceModel.data?.orderStatus == "CONFIRMED") {
          activeIndex = 0;
        } else if (orderDetailsResponceModel.data?.orderStatus == "PAID") {
          activeIndex = 1;
        } else if (orderDetailsResponceModel.data?.orderStatus == "PLACED" ||
            orderDetailsResponceModel.data?.orderStatus ==
                "PENDING_CANCELLATION") {
          activeIndex = 2;
        } else if (orderDetailsResponceModel.data?.orderStatus == "SHIPPED") {
          activeIndex = 3;
        } else if (orderDetailsResponceModel.data?.orderStatus ==
            "DISPATCHED") {
          activeIndex = 4;
        } else {
          activeIndex = 5;
        }
        debugPrint("ActiveIndex is $activeIndex");
        initializeStepperData();
        isLoading = false;
        update();
        hitCanAddReviewApi();
      }
    }).catchError((error, stackTrace) {
      debugPrint("message: '$stackTrace'");
    });
  }

  hitGetCampaignCompletedOrderDetailsApi(String orderId) {
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productDetailsRequestModel(id: orderId);
    _apiRepository
        .getCompletedCampaignOrderDetailsApiCall(
            queryBody: requestModel, id: orderId)
        .then((value) {
      if (value != null) {
        campaignCompletedOrderResponseModel = value;
        if (campaignCompletedOrderResponseModel
                .data?.orderProducts?[0].orderStatus ==
            "CONFIRMED") {
          activeIndex = 0;
        } else if (campaignCompletedOrderResponseModel
                .data?.orderProducts?[0].orderStatus ==
            "PAID") {
          activeIndex = 1;
        } else if (campaignCompletedOrderResponseModel
                    .data?.orderProducts?[0].orderStatus ==
                "PLACED" ||
            campaignCompletedOrderResponseModel
                    .data?.orderProducts?[0].orderStatus ==
                "PENDING_CANCELLATION") {
          activeIndex = 2;
        } else if (campaignCompletedOrderResponseModel
                .data?.orderProducts?[0].orderStatus ==
            "SHIPPED") {
          activeIndex = 3;
        } else if (campaignCompletedOrderResponseModel
                .data?.orderProducts?[0].orderStatus ==
            "DISPATCHED") {
          activeIndex = 4;
        } else {
          activeIndex = 5;
        }
        debugPrint("ActiveIndex is $activeIndex");
        initializeStepperData();
        isLoading = false;
        update();
        hitCanAddReviewApi();
      }
    }).catchError((error, stackTrace) {
      debugPrint("message: '$stackTrace'");
    });
  }

  hitCancelRequestOrderApi() {
    debugPrint("Order Id is $orderId");
    isLoading = true;
    Map<String, dynamic> requestModel =
        DetailsRequestModel.productCancelRequestModel(id: orderId);
    _apiRepository
        .productCancelOrderApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {
        orderCancellationRequestResponseModel = value;
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 3});
        showToast(
            message: orderCancellationRequestResponseModel.message.toString());
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      isLoading = false;
      debugPrint("message: '$stackTrace'");
    });
  }

  hitCancelRequestOrderApiFromNotificationRoute(var id) {
    debugPrint("Order Id is $id");
    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.productCancelRequestModel(id: id);
    _apiRepository
        .productCancelOrderApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {
        orderCancellationRequestResponseModel = value;
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 3});
        showToast(
            message: orderCancellationRequestResponseModel.message.toString());
        isLoading = false;
        update();
      }
    }).catchError((error, stackTrace) {
      isLoading = false;
      debugPrint("message: '$stackTrace'");
    });
  }

  // Future downloadFiles(
  //     {url,
  //       name,
  //       extension,
  //       required Function(String) path,
  //       Function(String)? openFileFunctionCall,
  //       Function? afterComplete}) async {
  //   var dir;
  //   dir = await getApplicationDocumentsDirectory();
  //   await File("${dir?.path}/$name.$extension").exists().then((value) async {
  //     if (value) {
  //       if (openFileFunctionCall != null) {
  //         openFileFunctionCall("${dir?.path}/$name.$extension");
  //       }
  //     } else {
  //       downloadFunction(
  //           dir: dir,
  //           url: url,
  //           name: name,
  //           extension: extension,
  //           openFileFunction: path,
  //           afterComplete: afterComplete,
  //           openPath: openFileFunctionCall);
  //     }
  //   }).onError((error, stackTrace) {
  //     downloadFunction(
  //         dir: dir,
  //         url: url,
  //         name: name,
  //         openFileFunction: path,
  //         afterComplete: afterComplete);
  //   });
  // }

  // Future<void> openFile({path, controller}) async {
  //   final filePath = path;
  //   final result = await OpenFilex.open(filePath);
  //   controller.update();
  //   var openResult = "type= ${result.type}  message= ${result.message}";
  //   debugPrint(' $openResult');
  //   if (result.type == ResultType.noAppToOpen) {
  //     toast("");
  //   }
  // }

}
