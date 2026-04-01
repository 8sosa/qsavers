




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

import '../../../../data/models/links_self_meta_model.dart';
import '../dataModels/faq_data_model.dart';

class FAQResponseModel {
  List<FAQDataModel>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  FAQResponseModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  FAQResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FAQDataModel>[];
      json['list'].forEach((v) {
        list!.add(FAQDataModel.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    if (mMeta != null) {
      data['_meta'] = mMeta!.toJson();
    }
    data['copyrighths'] = copyrighths;
    return data;
  }
}

