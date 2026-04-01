class DealsOfTheDayDataModel {
  int? totalCount;
  List<DealsOfTheDayData>? data;

  DealsOfTheDayDataModel({this.totalCount, this.data});

  DealsOfTheDayDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = List<DealsOfTheDayData>.from(
          json['data'].map((dataJson) => DealsOfTheDayData.fromJson(dataJson)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((data) => data.toJson()).toList();
    }
    return data;
  }
}

class DealsOfTheDayData {
  var sId;
  var image;
  var title;
  var price;
  CategoryId? categoryId;
  CategoryId? subcategoryId;
  CategoryId? subSubcategoryId;
  CategoryId? brandId;
  var discount;
  var validTill;
  var isEnable;
  var updatedAt;
  var createdAt;
  var language;

  DealsOfTheDayData({
    this.sId,
    this.image,
    this.title,
    this.price,
    this.categoryId,
    this.subcategoryId,
    this.subSubcategoryId,
    this.brandId,
    this.discount,
    this.validTill,
    this.isEnable,
    this.updatedAt,
    this.createdAt,
    this.language,
  });

  DealsOfTheDayData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    categoryId = json['category_id'] != null
        ? CategoryId.fromJson(json['category_id'])
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? CategoryId.fromJson(json['subcategory_id'])
        : null;
    subSubcategoryId = json['sub_subcategory_id'] != null
        ? CategoryId.fromJson(json['sub_subcategory_id'])
        : null;
    brandId = json['brand_id'] != null
        ? CategoryId.fromJson(json['brand_id'])
        : null;
    discount = json['discount'];
    validTill = json['valid_till'];
    isEnable = json['is_enable'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    if (categoryId != null) {
      data['category_id'] = categoryId!.toJson();
    }
    if (subcategoryId != null) {
      data['subcategory_id'] = subcategoryId!.toJson();
    }
    if (subSubcategoryId != null) {
      data['sub_subcategory_id'] = subSubcategoryId!.toJson();
    }
    if (brandId != null) {
      data['brand_id'] = brandId!.toJson();
    }
    data['discount'] = discount;
    data['valid_till'] = validTill;
    data['is_enable'] = isEnable;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['language'] = language;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
