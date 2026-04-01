class CategoriesDetailResponseModel {
  bool? success;
  String? message;
  Data? data;

  CategoriesDetailResponseModel({this.success, this.message, this.data});

  CategoriesDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CategoryDataModel>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDataModel {
  String? sId;
  String? name;
  int? designType;
  bool? isDeleted;
  String? updatedAt;
  String? language;
  String? createdAt;
  int? iV;
  List<Subcategories>? subcategories;

  CategoryDataModel(
      {this.sId,
        this.name,
        this.designType,
        this.isDeleted,
        this.updatedAt,
        this.language,
        this.createdAt,
        this.iV,
        this.subcategories});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    designType = json['design_type'];
    isDeleted = json['is_deleted'];
    updatedAt = json['updated_at'];
    language = json['language'];
    createdAt = json['created_at'];
    iV = json['__v'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
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
    data['__v'] = this.iV;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  String? sId;
  String? categoryId;
  String? name;
  bool? isDeleted;
  String? language;
  String? updatedAt;
  String? createdAt;
  int? iV;
  List<SubSubcategories>? subSubcategories;

  Subcategories(
      {this.sId,
        this.categoryId,
        this.name,
        this.isDeleted,
        this.language,
        this.updatedAt,
        this.createdAt,
        this.iV,
        this.subSubcategories});

  Subcategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['category_id'];
    name = json['name'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
    if (json['sub_subcategories'] != null) {
      subSubcategories = <SubSubcategories>[];
      json['sub_subcategories'].forEach((v) {
        subSubcategories!.add(new SubSubcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    if (this.subSubcategories != null) {
      data['sub_subcategories'] =
          this.subSubcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubcategories {
  String? sId;
  String? subcategoryId;
  String? name;
  bool? isDeleted;
  String? language;
  String? updatedAt;
  String? createdAt;
  int? iV;

  SubSubcategories(
      {this.sId,
        this.subcategoryId,
        this.name,
        this.isDeleted,
        this.language,
        this.updatedAt,
        this.createdAt,
        this.iV});

  SubSubcategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subcategoryId = json['subcategory_id'];
    name = json['name'];
    isDeleted = json['is_deleted'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['subcategory_id'] = this.subcategoryId;
    data['name'] = this.name;
    data['is_deleted'] = this.isDeleted;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
