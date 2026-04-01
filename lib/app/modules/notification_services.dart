import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/data/local/preferences/preference.dart';
import 'package:quantity_savers/app/export.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/message_received_notification_response_model.dart';
import 'package:quantity_savers/app/modules/splash/controllers/splash_controller.dart';

import '../routes/app_routes.dart';

class NotificationServices {
  LocalStorage _localStorage = LocalStorage();
  ForumsChatController forumsChatController = ForumsChatController();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  notificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined permission");
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitilization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitilization = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitilization, iOS: iosInitilization);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("heyy${message.notification?.title.toString()}");
      debugPrint(message.notification?.body.toString());
      debugPrint('this is doen');
      debugPrint(message.data['message_id']);
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(10000).toString(),
            'High Importance Notification',
            importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    debugPrint("Tokeeen is $token");
    if (token == null) {
      token = await _refreshToken(messaging);
    }
    return token!;
  }

  Future<String> _refreshToken(FirebaseMessaging messaging) async {
    final Completer<String> completer = Completer<String>();
    messaging.onTokenRefresh.listen((newToken) {
      print("Token refreshed: $newToken");
      completer.complete(newToken);
    });
    return completer.future;
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    debugPrint("hhhh");
    print("Message data is ${message.data}");
    print("Message type is ${message.messageType}");
    if (message.data['type'] == "ORDER_CREATED") {
      Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
        argForOrderPlaced: "ORDER_CREATED",
        argTitle: "Order Details",
        argIsRouteForNotificationScreen: true,
        argOrderId: message.data['order_id']
      });
    } else if (message.data['type'] == "SHIPPED") {
      Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
        argForOrderPlaced: "SHIPPED",
        argTitle: "Order Details",
        argIsRouteForOrderScreen: true,
        argOrderId: message.data['orderProduct_id']
      });
    }
    else if (message.data['type'] == "Message_received") {
      debugPrint("hjhjhjhj${message.data['group_id']}");
      Get.toNamed(AppRoutes.forumsChatRoute, arguments: {
        argGroupId: message.data['group_id'],
      });
    }
    else if (message.data['type'] == "ORDER_CANCELLED_REQUESTED") {
      Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
        argForOrderPlaced: "ORDER_CANCELLED_REQUESTED",
        argTitle: "Order Details",
        argIsRouteForNotificationScreen: true,
        argOrderId: message.data['order_id']
      });
    } else if (message.data['type'] == "DELIVERED") {
      Get.toNamed(AppRoutes.orderPlacedScreenRoute, arguments: {
        argForOrderPlaced: "SHIPPED",
        argTitle: "Order Details",
        argIsRouteForOrderScreen: true,
        argOrderId: message.data['orderProduct_id']
      });
    } else if (message.data['type'] == "CAMPAIGN") {
      Get.toNamed(AppRoutes.campaignDetailsScreenRoute,
          arguments: {argCampaignId: message.data['campaign_id']});
    }
    else if(message.data['type']=="ADD_IN_GROUP")
      {
        Get.toNamed(AppRoutes.forumsChatRoute,arguments: {argGroupId:message.data['group_id']});
      }
  }
}
