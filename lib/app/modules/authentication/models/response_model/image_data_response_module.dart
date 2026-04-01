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

class ImageResposemodel {
  ImageDataModel? data;

  ImageResposemodel({this.data});

  ImageResposemodel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ImageDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ImageDataModel {
  var baseUrl;
  var type;
  var folders;
  var fileName;

  ImageDataModel({this.baseUrl, this.type, this.folders, this.fileName});

  ImageDataModel.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
    type = json['type'];
    folders = json['folders'].cast<String>();
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    data['type'] = this.type;
    data['folders'] = this.folders;
    data['file_name'] = this.fileName;
    return data;
  }
}


