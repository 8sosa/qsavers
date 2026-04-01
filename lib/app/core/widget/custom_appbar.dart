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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final themeController = Get.put(ThemeController());
  final dynamic titleWidget;
  final String? appBarTitleText;
  final List<Widget>? actionWidget;
  final dynamic bottomWidget;
  final Color? bgColor;
  final Color? backIconColor;
  final bool? isDrawerIcon;
  final bool isBottomWidget;
  final bool? isAuthentication;
  final bool isTitleCenter;
  final bool isCustom;
  final List<Widget>? titlePrefixIcon;
  final bool isGradient;
  final bool isLeadingPresent;
  final bool hideBackIcon;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final String? titleFontFamily;
  final String? menuIcon;
  final onTap;

  CustomAppBar({
    Key? key,
    this.appBarTitleText,
    this.onTap,
    this.actionWidget,
    this.isDrawerIcon = false,
    this.isCustom = false,
    this.isAuthentication = false,
    this.hideBackIcon = false,
    this.backIconColor,
    this.bgColor,
    this.isGradient = true,
    this.isLeadingPresent = true,
    this.isTitleCenter = true,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleFontFamily,
    this.menuIcon,
    this.bottomWidget,
    this.isBottomWidget = false,
    this.titlePrefixIcon,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: isCustom
          ? _customAppBar()
          : AppBar(
              flexibleSpace: isGradient
                  ? Container(
                      decoration: _appBarGradient(),
                    )
                  : null,
              elevation: 0,
              leading:hideBackIcon?const SizedBox(): isLeadingPresent
                  ? isDrawerIcon == true
                      ? _menuIcon()
                      : IconButton(
                          onPressed: onTap ??
                              () {
                                Get.back();
                              },
                          icon: const AssetSVGWidget(iconsAppBarback),
                        )
                  : null,
              centerTitle: isTitleCenter ? true : false,
              title:titleWidget?? ((appBarTitleText != "") || (appBarTitleText != null))
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...?titlePrefixIcon,
                        Flexible(
                          child: TextView(
                            text: appBarTitleText ?? "",
                            textAlign: TextAlign.center,
                            textStyle: textStyleHeadlineMedium().copyWith(
                                fontSize: titleFontSize ?? font_16,
                                fontWeight: titleFontWeight ?? FontWeight.w600,
                                fontFamily: titleFontFamily,
                                color: isGradient
                                    ? Colors.white
                                    : AppColors.screenHeadingColor),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              actions: actionWidget ?? [],
              bottom: isBottomWidget ? bottomWidget : null,
            ),
    );
  }

  _customAppBar() => Container(
        decoration: _appBarGradient(),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    // onPressed: () {
                    //   onTap ?? Get.back(result: true);
                    // },
                    // icon: const AssetSVGWidget(iconsAppBarback),
                    onPressed: () {
                      if (onTap != null) {
                        onTap(); // Call the onTap function if it is not null
                      } else {
                        Get.back(result: true); // Default behavior
                      }
                    },
                    icon: const AssetSVGWidget(iconsAppBarback),
                  ),
                  Expanded(
                    child: titleWidget != null
                        ? titleWidget
                        : Text(
                      "Default Title",
                      style: textStyleHeadlineMedium().copyWith(
                        fontSize: titleFontSize ?? font_16,
                        fontWeight: titleFontWeight ?? FontWeight.w600,
                        fontFamily: titleFontFamily,
                        color: isGradient ? Colors.white : AppColors.screenHeadingColor,
                      ),
                    ),
                  ),

                ],
              ),
              if (isBottomWidget) ...[Expanded(child: bottomWidget)]
            ],
          ),
        ),
      );



  _appBarGradient() => const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [AppColors.gradient1st, AppColors.gradient2nd]));

  _menuIcon() {
    return IconButton(
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: AssetSVGWidget(menuIcon ?? iconsAdd),
    );
  }

  @override
  Size get preferredSize {
    if (isCustom) {
      return Size.fromHeight(height_105);
    }
    return Size.fromHeight(isBottomWidget ? height_80 : height_55);
  }
}
final double bottomSpace = 16.0;