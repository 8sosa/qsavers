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

import 'package:quantity_savers/app/modules/my_orders/data_model/order_data_model.dart';
import 'package:quantity_savers/app/modules/my_orders/response_Model/order_response_model.dart';

import '../../../export.dart';
import '../../Details/models/details_request_model.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final APIRepository _repository = Get.find<APIRepository>();
  OrderResponseModel orderResponseModel =OrderResponseModel();

  RxString? selectedValue = "".obs;
  TabController? tabController;
  var currentIndex = 0;
  bool isLoading=false;
  int confirmed=0;
  int cancelled=0;
  int delivered=0;
  int all=0;
  int currentPage = 1;
  int totalPages = 1;
  int itemsPerPage = 10;
  @override
  void onInit() {
    lightTheme(color: AppColors.appColor);
    tabController = TabController(vsync: this, length: 4);
    tabController?.addListener(() {
      debugPrint("selectedIndexUpdate ${tabController?.index}");
      currentIndex= tabController?.index??0;
      update();
    });
    getOrderList('ALL');
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  onTabChanged(int index) async {
    currentIndex = index;
    debugPrint("$index");
    if(currentIndex==0)
      {
        getOrderList("ALL");
      }
    else if(currentIndex==1)
      {
        getOrderList('CONFIRMED');
      }
    else if(currentIndex==2)
      {
        getOrderList('DELIVERED');
      }
    else
      {
        getOrderList('CANCELLED');
      }

    update();
  }


  getOrderList(String status) {
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.orderRequestModel(type: status);
    _repository
        .getOrderListApiCall(queryBody: requestModel)
        .then((value) {

      if (value != null) {
          orderResponseModel=value;
          if(status=='ALL')
            {
              all=orderResponseModel.totalCount ?? 0;
              confirmed=orderResponseModel.confirmCount ?? 0;
              delivered=orderResponseModel.deliveredCount ?? 0;
              cancelled=orderResponseModel.cancelCount ?? 0;
            }

        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  Future<void> refreshAllOrderList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    debugPrint("List is Refreshed");
    getOrderList("ALL");

  }
  Future<void> refreshConfirmedList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    debugPrint("List is Refreshed");
    getOrderList("CONFIRMED");

  }
  Future<void> refreshDeliveredList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    debugPrint("List is Refreshed");
    getOrderList("DELIVERED");

  }
  Future<void> refreshCancelledList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    debugPrint("List is Refreshed");
    getOrderList("CANCELLED");

  }
}
