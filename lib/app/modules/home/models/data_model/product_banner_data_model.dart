class ProductBannerDataModel {
  int? totalCount;
  List<Data>? data;

  ProductBannerDataModel({this.totalCount, this.data});

  ProductBannerDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var sId;
  var title;
  var subTitle;
  var image;
  var categoryId;
  var subcategoryId;
  var subSubcategoryId;
  var brandId;
  var position;
  var isEnable;
  var isDeleted;
  var language;
  var updatedAt;
  var createdAt;

  Data(
      {this.sId,
      this.title,
      this.subTitle,
      this.image,
      this.categoryId,
      this.subcategoryId,
      this.subSubcategoryId,
      this.brandId,
      this.position,
      this.isEnable,
      this.isDeleted,
      this.language,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    image = json['image'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subSubcategoryId = json['sub_subcategory_id'];
    brandId = json['brand_id'];
    position = json['position'];
    isEnable = json['is_enable'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['sub_subcategory_id'] = this.subSubcategoryId;
    data['brand_id'] = this.brandId;
    data['position'] = this.position;
    data['is_enable'] = this.isEnable;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
