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

class PersonalInformationViewBarWidget extends StatelessWidget {
  final dynamic personalInfoTypeIcon;
  final String personalInfoName;
  final dynamic isVerifiedIcon;
  var ontap;
  var onTextTap;

  PersonalInformationViewBarWidget(
      {super.key,
      required this.personalInfoTypeIcon,
      required this.personalInfoName,
      required this.isVerifiedIcon,
      this.ontap,
      this.onTextTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AssetSVGWidget(personalInfoTypeIcon),
        Padding(
          padding: EdgeInsets.only(left: margin_12, right: margin_6),
          child: InkWell(
            onTap: onTextTap,

            child: Text(personalInfoName,
                style: TextStyle(
                  fontSize: font_15,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        InkWell(
          onTap: ontap,
          child: AssetSVGWidget(isVerifiedIcon),
        )
      ],
    );
  }
}
