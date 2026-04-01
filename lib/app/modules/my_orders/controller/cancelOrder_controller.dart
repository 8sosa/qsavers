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

import 'package:quantity_savers/app/modules/my_orders/response_Model/cancel_order_response_model.dart';

import '../../../export.dart';
import '../../Details/models/details_request_model.dart';

class CancelOrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _apiRepository = Get.find<APIRepository>();
  TextEditingController textEditingController =TextEditingController();
  FocusNode commentFocusNode = FocusNode();
  CancelOrderResponseModel cancelOrderResponseModel = CancelOrderResponseModel();
  bool isLoading=false;
  String Id = "";
  String orderId="";

  final List<String> items = [
    'I want to change address for the order',
    'Price for the product has decreased',
    'I want to convert my order to Prepaid',
    'I have changed my mind',
    'I have Purchased the product elsewhere',
    'Expected delivery time is very long'
  ];

  RxString? selectedValue = "".obs;

  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    super.onInit();
    getArguments();
  }
  getArguments()
  {
    if (Get.arguments != null)
      {
        Id=Get.arguments[argId] ?? '';
        orderId=Get.arguments[argOrderId] ?? '';
        debugPrint("Id is $Id");
        debugPrint("Order Id is $orderId");
      }
  }

  hitCancelOrderApi() {
    isLoading = true;
    Map<String, dynamic> requestModel =
    DetailsRequestModel.deleteOrderRequestModel(id:Id,orderId:orderId ,cancellationReason:selectedValue?.value ,description:textEditingController.text );
    debugPrint("RequestModel is $requestModel");
    _apiRepository
        .cancelOrderApiCall(dataBody: requestModel)
        .then((value) {
      if (value != null) {
        isLoading = false;
        cancelOrderResponseModel=value;
        showToast(message: cancelOrderResponseModel.data ?? '');
        Get.offAllNamed(AppRoutes.mainScreenRoute,
            arguments: {argBottomNavigationIndex: 3});
        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  onChangeDropDownValue(String? str) async {
    selectedValue?.value = str ?? "";
    update();
  }
}
