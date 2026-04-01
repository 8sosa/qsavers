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

import 'package:logger/logger.dart';
import '../../export.dart';

int defaultItemCount = 10;

var preLoginNestedId = 1;
var postLoginNestedId = 2;

var log = Logger();
GetStorage storage = GetStorage();

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
    GlobalKey<ScaffoldMessengerState>();

cardDecoration({Color? bgColor}) => BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
    ],
    borderRadius: BorderRadius.circular(radius_20));
