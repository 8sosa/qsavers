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

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: const CircularProgressIndicator(
        color: AppColors.appColor,
      ).paddingOnly(bottom: margin_20),
    );
  }
}
