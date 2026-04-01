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

// To parse this JSON data, do
//
//     final getotherdoclist = getotherdoclistFromJson(jsonString);

import 'dart:convert';

Getotherdoclist getotherdoclistFromJson(String str) => Getotherdoclist.fromJson(json.decode(str));

String getotherdoclistToJson(Getotherdoclist data) => json.encode(data.toJson());

class Getotherdoclist {
  int count;
  List<OtherDoc> data;

  Getotherdoclist({
    required this.count,
    required this.data,
  });

  factory Getotherdoclist.fromJson(Map<String, dynamic> json) => Getotherdoclist(
    count: json["count"],
    data: List<OtherDoc>.from(json["data"].map((x) => OtherDoc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OtherDoc {
  String id;
  String? name;
  int createdAt;
  bool isDeleted;
  int updatedAt;
  int deletedAt;

  OtherDoc({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isDeleted,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory OtherDoc.fromJson(Map<String, dynamic> json) => OtherDoc(
    id: json["_id"],
    name: json["name"],
    createdAt: json["created_at"],
    isDeleted: json["is_deleted"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "created_at": createdAt,
    "is_deleted": isDeleted,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}