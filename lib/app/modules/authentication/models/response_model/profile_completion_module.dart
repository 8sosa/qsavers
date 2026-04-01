
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

import 'dart:convert';

Datamodel datamodelFromJson(String str) => Datamodel.fromJson(json.decode(str));

String datamodelToJson(Datamodel data) => json.encode(data.toJson());

class Datamodel {
  String id;
  String name;
  String image;
  String appImage;
  String video;
  int createdAt;
  int updatedAt;
  List<SubService> subServices;

  Datamodel({
    required this.id,
    required this.name,
    required this.image,
    required this.appImage,
    required this.video,
    required this.createdAt,
    required this.updatedAt,
    required this.subServices,
  });

  factory Datamodel.fromJson(Map<String, dynamic> json) => Datamodel(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    appImage: json["app_image"],
    video: json["video"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    subServices: List<SubService>.from(json["sub_services"].map((x) => SubService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "app_image": appImage,
    "video": video,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sub_services": List<dynamic>.from(subServices.map((x) => x.toJson())),
  };
}

class SubService {
  String id;
  String serviceType;
  String name;
  List<SubService> subServices;

  SubService({
    required this.id,
    required this.serviceType,
    required this.name,
    required this.subServices,
  });

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
    id: json["_id"],
    serviceType: json["service_type"],
    name: json["name"],
    subServices: List<SubService>.from(json["sub_services"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "service_type": serviceType,
    "name": name,
    "sub_services": List<dynamic>.from(subServices.map((x) => x)),
  };
}