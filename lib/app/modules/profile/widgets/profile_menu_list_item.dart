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

class ProfileMenuListItem extends StatelessWidget {
  final Map<String, dynamic> profileMenuList;
  final String profileMenuTitle;

  const ProfileMenuListItem(
      {super.key,
      required this.profileMenuList,
      required this.profileMenuTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: margin_18,
              bottom: margin_18,
              left: margin_20,
              right: margin_20),
          child: Row(
            children: <Widget>[
              AssetSVGWidget(profileMenuList["icon"]),
              SizedBox(
                width: width_16,
              ),
              TextView(
                text: profileMenuList["name"],
                textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                    color: profileMenuTitle == strAccount
                        ? profileMenuList["color"]
                        : Colors.black,
                    fontSize: font_16),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: AppColors.DustyGray,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
