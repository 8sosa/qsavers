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

import 'package:quantity_savers/app/export.dart';


var themeController = Get.put(ThemeController());

customButton({buttonText, onTap}) {
  return Obx(() => Container(
      padding: EdgeInsets.only(
          top: margin_15, left: margin_20, right: margin_20, bottom: margin_20),
      decoration: BoxDecoration(
          color: themeController.isDarkMode.value == true
              ? Colors.black
              : Colors.white,
          boxShadow: [
            BoxShadow(
                color: themeController.isDarkMode.value == true
                    ? Colors.transparent
                    : Colors.grey.shade300,
                offset: const Offset(0, -2),
                blurRadius: 2.0)
          ]),
      child: MaterialButtonWidget(
        onPressed: onTap ?? () {},
        textColor: Colors.white,
        buttonText: buttonText ?? '',
        buttonBgColor: AppColors.gradient2nd,
      ),),);
}

lightTheme({color}) {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: color ?? Colors.white,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}


Widget emptySizeBox() => SizedBox(
      width: margin_0,
      height: margin_0,
    );

String maskString(String? stringValue) {
  if (stringValue == null) {
    return '';
  }

  String maskedNumber = stringValue.replaceRange(
      12, stringValue.length, '..' * (stringValue.length - 2));
  return maskedNumber;
}