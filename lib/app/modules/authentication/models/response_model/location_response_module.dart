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

import 'package:quantity_savers/app/modules/authentication/models/dataModel/login_data_model.dart';

class AddLocationResponseModel {
  String? message;
  LoginDataModel? detail;

  AddLocationResponseModel({
    this.message,
    this.detail,
  });

  AddLocationResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];

    detail =
        json['detail'] != null ? LoginDataModel.fromJson(json['detail']) : null;
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['message'] = this.message;
//
//   if (this.detail != null) {
//     data['detail'] = this.detail!.toJson();
//   }
//
//   return data;
// }
}
