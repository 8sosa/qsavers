


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

import '../dataModels/static_pages_data_model.dart';

class StaticPagesResponseModel {
  StaticPagesDataModel? detail;
  String? copyrighths;

  StaticPagesResponseModel({this.detail, this.copyrighths});

  StaticPagesResponseModel.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? StaticPagesDataModel.fromJson(json['detail']) : null;
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


