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

class BottomButtonWidget extends StatelessWidget {
  final dynamic onPressed;
  final String btnTitle;
  final Color? btnBgColor;
  final bool isBorderColor;
  final Color? borderColor;

  const BottomButtonWidget(
      {super.key,
      required this.onPressed,
      required this.btnTitle,
      this.btnBgColor,
        this.borderColor,
      this.isBorderColor = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(
          top: margin_20, left: margin_20, right: margin_20, bottom: margin_30),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: (isBorderColor
                      ? borderColor ?? AppColors.borderColor
                      : Colors.transparent),
                  width: 1))),
      child: MaterialButtonWidget(
        minHeight: height_40,
        onPressed: onPressed,
        buttonText: btnTitle.toUpperCase(),
        buttonBgColor: btnBgColor ?? AppColors.gradient2nd,
        buttonTextStyle: textStyleBodyMedium().copyWith(
            fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
