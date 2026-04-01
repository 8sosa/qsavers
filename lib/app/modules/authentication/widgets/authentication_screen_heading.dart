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

import '../../../export.dart';

class AuthenticationScreenHeading extends StatelessWidget {
  var themeController = Get.put(ThemeController());
  final String title;
  final textStyle;

  AuthenticationScreenHeading({
    Key? key,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Align(
        alignment: Alignment.centerLeft,
        child: TextView(
            text: title,
            maxLines: 2,
            textAlign: TextAlign.start,
            textStyle: textStyle ??
                textStyleDisplayLarge().copyWith(
                    fontSize: font_20,
                    color: themeController.isDarkMode.value == true
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600))));
  }
}
