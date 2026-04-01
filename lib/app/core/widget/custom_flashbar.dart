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

// showToast({String? message}) {
//   Fluttertoast.cancel();
//   Fluttertoast.showToast(
//     msg:"Quantity Savers \n $message" ?? "",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.TOP,
//     backgroundColor: AppColors.toastColor,
//     textColor: Colors.black,
//     fontSize: font_13,
//   );
// }
showToast({String? message}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    strApplicationName,
    message??"",
    colorText: Colors.black,
  );
}