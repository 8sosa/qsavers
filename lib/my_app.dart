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

import 'app/export.dart';
import 'app/logger/logger_utils.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit( designSize: const Size(360, 690),
        minTextAdapt: true,useInheritedMediaQuery: true,
        splitScreenMode: true,
        builder: (context, widget) => GetMaterialApp(
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.lightTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppPages.INITIAL,
          initialBinding: InitialBinding(),
          getPages: AppPages.routes,
          scaffoldMessengerKey: scaffoldMessengerState,
          navigatorKey: navState,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: LoggerX.write,
          builder: EasyLoading.init(),
          defaultTransition: Transition.cupertino,
        ),
      ),
    );
  }
}
