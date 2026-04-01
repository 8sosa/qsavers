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

class AddServices {
  int? count;
  List<Data>? data;

  AddServices({this.count, this.data});

  AddServices.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
//to
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? image;
  String? appImage;
  String? video;
  int? createdAt;
  int? updatedAt;
  List<SubServices>? subServices;

  Data(
      {this.sId,
        this.name,
        this.image,
        this.appImage,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.subServices});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    appImage = json['app_image'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(SubServices.fromJson(v));
      });
    }
  }
//to
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['app_image'] = appImage;
    data['video'] = video;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subServices != null) {
      data['sub_services'] = subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServices {
  String? sId;
  String? serviceType;
  String? name;
  List<SubServices1>? subServices;

  SubServices({this.sId, this.serviceType, this.name, this.subServices});

  SubServices.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    serviceType = json['service_type'];
    name = json['name'];
    if (json['sub_services'] != null) {
      subServices = <SubServices1>[];
      json['sub_services'].forEach((v) {
        subServices!.add(SubServices1.fromJson(v));
      });
    }
  }
//to
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['service_type'] = serviceType;
    data['name'] = name;
    if (subServices != null) {
      data['sub_services'] = subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServices1 {
  String? sId;
  String? serviceType;
  String? name;
  String? image;

  SubServices1({this.sId, this.serviceType, this.name, this.image});

  SubServices1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    serviceType = json['service_type'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['service_type'] = serviceType;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
