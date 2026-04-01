
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

class Area {
  String? sId;
  String? city;
  bool? status;
  bool? isDeleted;
  int? createdAt;
  int? updatedAt;
  List<AreaDetail>? areas;

  Area({
    this.sId,
    this.city,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.areas,
  });

  Area.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['areas'] != null) {
      areas = [];
      json['areas'].forEach((v) {
        areas!.add(AreaDetail.fromJson(v));
      });
    }
  }
}

class AreaDetail {
  String? sId;
  String? cityId;
  String? houseNo;
  String? city;
  String? state;
  String? country;
  String? landmark;
  String? addressLine1;
  String? addressLine2;
  int? pincode;
  Location? location;
  bool? status;
  bool? isDeleted;
  int? createdAt;
  int? updatedAt;
  int? iV;

  AreaDetail({
    this.sId,
    this.cityId,
    this.houseNo,
    this.city,
    this.state,
    this.country,
    this.landmark,
    this.addressLine1,
    this.addressLine2,
    this.pincode,
    this.location,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AreaDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cityId = json['city_id'];
    houseNo = json['house_no'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    landmark = json['landmark'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = (json['coordinates'] as List<dynamic>)
        .map<double>((value) => value.toDouble())
        .toList();
  }
}
