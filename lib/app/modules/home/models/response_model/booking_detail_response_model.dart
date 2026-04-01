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

import '../data_model/booking_detail_data_model.dart';

class BookingDetailResponseModel {
  BookingDetailDataModel? detail;
  String? copyrighths;

  BookingDetailResponseModel({this.detail, this.copyrighths});

  BookingDetailResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? BookingDetailDataModel.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    data['copyrighths'] = copyrighths;
    return data;
  }
}
