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

import '../data_model/package_type_data_model.dart';

class PackageTypeResponseModel {
  List<PackageTypeDataModel>? list;
  String? copyrighths;

  PackageTypeResponseModel({this.list, this.copyrighths});

  PackageTypeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <PackageTypeDataModel>[];
      json['list'].forEach((v) {
        list!.add(PackageTypeDataModel.fromJson(v));
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



