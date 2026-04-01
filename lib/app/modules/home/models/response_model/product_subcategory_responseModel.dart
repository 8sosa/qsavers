class ProductSubCategoryResponseModel {
  Data? data;

  ProductSubCategoryResponseModel({this.data});

  ProductSubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
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
  CategoryId? categoryId;
  String? name;
  bool? isDeleted;
  String? language;
  String? updatedAt;
  String? createdAt;

  Datum(
      {this.sId,
        this.categoryId,
        this.name,
        this.isDeleted,
        this.language,
        this.updatedAt,
        this.createdAt});

  Datum.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['category_id'] != null
        ? new CategoryId.fromJson(json['category_id'])
        : null;
    name = json['name'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CategoryId {
  String? sId;
  String? name;

  CategoryId({this.sId, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}


