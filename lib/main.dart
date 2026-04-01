/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this fil  e, via any medium is strictly prohibited.
 *  *
 *
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quantity_savers/app/core/base/socket_file.dart';
import 'app/export.dart';
import 'app/modules/Details/controllers/dynamic_controller.dart';
import 'firebase_options.dart';

CustomLoader customLoader = CustomLoader();
GetStorage localStorage = GetStorage();
RxBool isDarkModeTheme = false.obs;
late DynamicLinkingController dynamicLinkingController;

SocketIOManager? socketIOManager;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  init();
  systemThemeMode();
  orientation();
  initApp();
}

@pragma('vm:entry-point')
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification?.title.toString());
}

systemThemeMode() {
  var window = WidgetsBinding.instance.window;
  var brightness = window.platformBrightness;
  isDarkModeTheme.value = brightness == Brightness.dark;
  window.onPlatformBrightnessChanged = () {
    WidgetsBinding.instance.handlePlatformBrightnessChanged();
    var brightness = window.platformBrightness;
    isDarkModeTheme.value = brightness == Brightness.dark;
  };
}

init() async {
  GetStorage.init();
   // socketIOManager = Get.put(SocketIOManager());
  APIRepository();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

initApp() {
  dynamicLinkingController = Get.put(DynamicLinkingController());
  runApp(const MyApp());
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor:
          Platform.isAndroid ? AppColors.appColor : Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
