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

import "../../../export.dart";

class EditProfileBtnWidget extends StatelessWidget {
  final String btnName;

  EditProfileBtnWidget({super.key, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_8),
          border: Border.all(color: AppColors.gradient2nd),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColors.gradient1st, AppColors.gradient2nd])),
      child: Center(
        child: Text(btnName,
            style: TextStyle(
              fontSize: font_14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
