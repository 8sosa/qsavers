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

class PersonalInformationBtnWidget extends StatelessWidget {
  final String btnName;

  const PersonalInformationBtnWidget({super.key, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_8),
          border: Border.all(color: AppColors.gradient2nd),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: btnName == strEditProfile
                ? [AppColors.gradient1st, AppColors.gradient2nd]
                : [Colors.white, Colors.white],
          )),
      child: Center(
        child: Text(btnName.toUpperCase(),
            style: TextStyle(
              fontSize: font_14,
              color: btnName == strEditProfile
                  ? Colors.white
                  : AppColors.gradient2nd,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
