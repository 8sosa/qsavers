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

import '../data_model/ride_detail_data_model.dart';

class RideDetailResponseModel {
  List<RideDetailDataModel>? list;
  String? copyrighths;

  RideDetailResponseModel({this.list, this.copyrighths});

  RideDetailResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <RideDetailDataModel>[];
      json['list'].forEach((v) {
        list!.add(RideDetailDataModel.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }

    data['copyrighths'] = copyrighths;
    return data;
  }
}
