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

class ForgotPasswordDataModel {
  String? message;
  String? uniqueCode;

  ForgotPasswordDataModel({this.message, this.uniqueCode});

  ForgotPasswordDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    uniqueCode = json['unique_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['unique_code'] = this.uniqueCode;
    return data;
  }
}
