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

import 'package:quantity_savers/app/modules/Details/models/details_request_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/mark_all_read_notifications.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/read_single_notifications_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/user_notifications_response_model.dart';

import '../../../export.dart';

class NotificationController extends GetxController with GetSingleTickerProviderStateMixin{

  final APIRepository _repository = Get.find<APIRepository>();
  UserNotificationResponseModel userNotificationResponseModel =UserNotificationResponseModel();
  ReadNotificationResponseModel readNotificationResponseModel =ReadNotificationResponseModel();
  ReadSingleNotificationResponseModel readSingleNotificationResponseModel = ReadSingleNotificationResponseModel();
  bool isLoading=false;
  TabController? tabController;
  var currentIndex = 0;
  var all;
  var campaign;
  var orders;
  var forums;
MainController?mainController;
  void onInit()
  {
    if (Get.isRegistered<MainController>()) {
      mainController = Get.find<MainController>();
    }
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
    getNotifications('');

  }

  onTabChanged(int index) async {
    debugPrint("Index is $index");
    currentIndex = index;

    if (currentIndex == 0) {
     getNotifications('');
    } else if (currentIndex == 1) {
      getNotifications('CAMPAIGNS');
    } else if (currentIndex == 2) {
      getNotifications('ORDERS');
    }

    update();
  }

  getNotifications(String state)
  {
    isLoading = true;
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.getNotificationsRequestModel(type: state);
    _repository
        .getNotificationApiCall(queryBody: requestModel)
        .then((value) {
      if (value != null) {

        isLoading = false;
        userNotificationResponseModel = value;

        update();
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  readNotifications()
  {
    isLoading=true;
    Map<String, dynamic>? requestModel =
    DetailsRequestModel.couponsRequestModel(language: strLanguageEnglish);
   _repository.allReadNotificationApiCall(queryBody: requestModel).then((value){
     if(value!=null)
       {
         readNotificationResponseModel = value;
         showToast(message:readNotificationResponseModel.data?.message.toString() );
         if(currentIndex==0)
           {
             getNotifications('');
             mainController?.getNotifications('');
           }
         else if(currentIndex==1)
           {
             getNotifications('CAMPAIGNS');
             mainController?.getNotifications('CAMPAIGNS');
           }
         else if(currentIndex==2)
           {
             getNotifications('ORDERS');
             mainController?.getNotifications('ORDERS');
           }
         else if(currentIndex==3)
           {
             getNotifications('FORUMS');
             mainController?.getNotifications('FORUMS');
           }

         isLoading=false;
         update();
       }

   }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

  readSingleNotifications(String? id)
  {
    isLoading=true;
    _repository.readSingleNotificationApiCall(id).then((value) {
      if(value!=null)
        {
          readSingleNotificationResponseModel=value;
           // showToast(message:readSingleNotificationResponseModel.data?.message.toString() );
           debugPrint("CurrentIndex is $currentIndex");

          if(currentIndex==0)
          {
            isLoading=false;
            getNotifications('');
            debugPrint("This api call");
            mainController?.getNotifications('');
          }
          else if(currentIndex==1)
          {
            isLoading=false;
            getNotifications('CAMPAIGNS');
            mainController?.getNotifications('CAMPAIGNS');
          }
          else if(currentIndex==2)
          {
            isLoading=false;
            getNotifications('ORDERS');
            mainController?.getNotifications('ORDERS');
          }
          else if(currentIndex==3)
          {
            isLoading=false;
            getNotifications('FORUMS');
            mainController?.getNotifications('FORUMS');
          }
          isLoading=false;
          update();

        }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }

}