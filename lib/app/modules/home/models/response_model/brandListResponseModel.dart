class BrandListResponseModel {
  Data? data;

  BrandListResponseModel({this.data});

  BrandListResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalCount;
  List<Datum>? data;

  Data({this.totalCount, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datum {
  String? sId;
  String? name;
  bool? isDeleted;
  String? updatedAt;
  String? createdAt;
  String? language;

  Datum(
      {this.sId,
        this.name,
        this.isDeleted,
        this.updatedAt,
        this.createdAt,
        this.language});

  Datum.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['language'] = this.language;
    return data;
  }
}

