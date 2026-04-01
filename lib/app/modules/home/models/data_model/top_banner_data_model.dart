class Data {
  int? totalCount;
  List<Dataa>? dataa;

  Data({this.totalCount, this.dataa});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      dataa = <Dataa>[];
      json['data'].forEach((v) {
        dataa!.add(new Dataa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.dataa != null) {
      data['data'] = this.dataa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Dataa {
  var sId;
  var title;
  var subTitle;
  var image;
  CategoryId? categoryId;
  CategoryId? subcategoryId;
  CategoryId? subSubcategoryId;
  CategoryId? brandId;
  var position;
  var isEnable;
  var language;
  var updatedAt;
  var createdAt;

  Dataa(
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
        this.language,
        this.updatedAt,
        this.createdAt});

  Dataa.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    image = json['image'];
    categoryId = json['category_id'] != null
        ? new CategoryId.fromJson(json['category_id'])
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? new CategoryId.fromJson(json['subcategory_id'])
        : null;
    subSubcategoryId = json['sub_subcategory_id'] != null
        ? new CategoryId.fromJson(json['sub_subcategory_id'])
        : null;
    brandId = json['brand_id'] != null
        ? new CategoryId.fromJson(json['brand_id'])
        : null;
    position = json['position'];
    isEnable = json['is_enable'];
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
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    if (this.subcategoryId != null) {
      data['subcategory_id'] = this.subcategoryId!.toJson();
    }
    if (this.subSubcategoryId != null) {
      data['sub_subcategory_id'] = this.subSubcategoryId!.toJson();
    }
    if (this.brandId != null) {
      data['brand_id'] = this.brandId!.toJson();
    }
    data['position'] = this.position;
    data['is_enable'] = this.isEnable;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class CategoryId {
  var sId;
  var name;

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