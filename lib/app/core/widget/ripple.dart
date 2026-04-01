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

class ButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color rippleColor;
  final double rippleRadius;

  const ButtonWidget({
    Key? key,
    this.child,
    required this.onTap,
    this.rippleColor = Colors.transparent,
    this.rippleRadius = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(rippleRadius),
        highlightColor: rippleColor,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
