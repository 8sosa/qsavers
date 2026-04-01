
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


class ApplicationAvailabilityDialog extends AlertDialog {
  const ApplicationAvailabilityDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          height: height_150,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10),
              )),
          child: const AssetImageWidget(
             iconsSplashLogo,
          )),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: margin_10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
             text:  "Demo ",
              textStyle: textStyleBodyLarge()
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ).marginOnly(bottom: margin_10),
            TextView(
              text: 'Demo description',
              maxLines: 4,
              textStyle: textStyleBodyLarge().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: font_14),
            ).marginOnly(bottom: height_20),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_10)),
    );
  }
}
