class ProductCategoriesDataModel {
  int? totalCount;
  List<Data>? data;

  ProductCategoriesDataModel({this.totalCount, this.data});

  ProductCategoriesDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  String? name;
  int? designType;
  bool? isDeleted;
  String? updatedAt;
  String? language;
  String? createdAt;

  Data(
      {this.sId,
      this.name,
      this.designType,
      this.isDeleted,
      this.updatedAt,
      this.language,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    designType = json['design_type'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    language = json['language'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['design_type'] = this.designType;
    data['is_deleted'] = this.isDeleted;
    data['updated_at'] = this.updatedAt;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    return data;
  }
}
