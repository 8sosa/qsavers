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

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quantity_savers/app/modules/notification_services.dart';
import '../../../export.dart';

dynamic fcmToken;
Rx<int> unreadCount =0.obs;

class SplashController extends GetxController {
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  Timer? timer;
  String? token;

  RxString currentLogo = iconsSplashLogo.obs;
  final APIRepository _repository = APIRepository();
  LoginDataModel? loginDataModel = LoginDataModel() ;
  LoginResponseModel loginResponseModel = LoginResponseModel();
  NotificationServices notificationServices = NotificationServices();
  RemoteMessage? message;

  @override
  void onInit() async {
    if(Platform.isAndroid)
      {
        fcmToken = await notificationServices.getDeviceToken();
        debugPrint("fcm Token is $fcmToken");

        if (fcmToken == null && Platform.isAndroid) {
          _navigateToNextScreen();
        }

        notificationServices.notificationPermission();
        if (message != null) {
          notificationServices.initLocalNotification(Get.context!, message!);
        }
        notificationServices.firebaseInit(Get.context!);
        _fetchDeviceToken();

        if (fcmToken == null && Platform.isAndroid) {
          _navigateToNextScreen();
        }
      }
    if(Platform.isIOS)
      {
        fcmToken = await notificationServices.getDeviceToken();
        debugPrint("fcm Token is $fcmToken");

        if (fcmToken == null && Platform.isIOS) {
          _navigateToNextScreen();
        }

        notificationServices.notificationPermission();
        if (message != null) {
          notificationServices.initLocalNotification(Get.context!, message!);
        }
        notificationServices.firebaseInit(Get.context!);
        _fetchDeviceToken();

        if (fcmToken == null && Platform.isIOS) {
          _navigateToNextScreen();
          }
      }

    super.onInit();
  }

  Future<void> _fetchDeviceToken() async {
    fcmToken = await notificationServices.getDeviceToken();
    if (fcmToken != null) {
      _navigateToNextScreen();
    } else {
      print("Failed to get device token");
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //*===================================================================== Check App validity ==========================================================*
  void _navigateToNextScreen()
  {
    timer = Timer(const Duration(seconds: 3, milliseconds: 500), () async {
      var isFirstCheck = await _localStorage.getFirstLaunch() ?? true;
      loginDataModel = await _localStorage.getSavedLoginData() ;
      token = await _localStorage.getAuthToken();
      if((isFirstCheck == false) || ((token ?? "") != "")) {
        if (loginDataModel?.emailVerified == true) {
          Get.offAllNamed(AppRoutes.mainScreenRoute);
        } else {
          debugPrint("Email is ${loginDataModel?.email}");
          Get.offAllNamed(AppRoutes.loginRoute);
        }
      }
      else
        {
          Get.offAllNamed(AppRoutes.signupRoute);
        }
    });
  }

}
