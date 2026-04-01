
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

import '../../export.dart';


class ThemeConfig {
  var themeController=Get.put(ThemeController());
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    required Color buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    return ThemeData(
      brightness: brightness,
      disabledColor: buttonBackground,
      canvasColor: background,
      primaryColorDark: buttonBackground,
      primarySwatch: Colors.red,
      cardColor: background,
      dividerColor: divider,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      primaryColor: accentColor,

      colorScheme: ColorScheme.fromSwatch(
          backgroundColor: background,
          errorColor: error,

          accentColor: accentColor, brightness: brightness),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: AppColors.appColor,

      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,),
        color: Colors.black,
        toolbarTextStyle: TextStyle(
          color: primaryText,
          fontSize: 18.0.sp,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: height_25),
      ),
      iconTheme: IconThemeData(
        color: primaryText,
        size: height_25,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: buttonBackground,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(

          brightness: brightness,
          primary:buttonBackground,
          primaryContainer: accentColor,
          secondary: accentColor,

          secondaryContainer: accentColor,
          surface: buttonBackground,
          background: buttonBackground,
          error: error,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.black,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor:Colors.white
      ),

      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        errorStyle: TextStyle(color: error),
        hintStyle: TextStyle(
          color: primaryText,
          fontSize: font_12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: primaryText,
          fontSize: font_24,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          color: primaryText,
          fontSize: font_22,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
        displaySmall: TextStyle(
          color: primaryText,
          fontSize: font_20,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color:primaryText,
          fontSize: font_20,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
          color: primaryText,
          fontSize: font_18,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color:primaryText,
          fontSize: font_16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: primaryText,
          fontSize: font_15,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: primaryText,
          fontSize: font_14,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: primaryText,
          fontSize: font_13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: primaryText,
          fontSize: font_13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: primaryText,
          fontSize: font_12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: primaryText,
          fontSize: font_11,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: primaryText,
          fontSize: font_16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: primaryText,
          fontSize: font_15,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: primaryText,
          fontSize: font_14,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.dark,
        background: Colors.white,
        cardBackground: Colors.white,
        primaryText: Colors.black,
        secondaryText: Colors.black,
        accentColor: AppColors.appColor.withOpacity(0.5),
        divider: Colors.black,
        buttonBackground: AppColors.appColor,
        buttonText: Colors.black,
        disabled: Colors.black,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.light,
        background: Colors.black,
        cardBackground: Colors.black,
        primaryText: Colors.white,
        secondaryText: Colors.white,
        accentColor: Colors.black,
        divider: Colors.white,
        buttonBackground: AppColors.appColor,
        buttonText: Colors.white,
        disabled: Colors.black,
        error: Colors.red,
      );
}
