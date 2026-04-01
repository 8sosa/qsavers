class ProductMediaResponseModel {
  Data? data;

  ProductMediaResponseModel({this.data});

  ProductMediaResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserId? userId;
  String? productId;
  String? sellerId;
  var title;
  var description;
  var ratings;
  String? type;
  var images;
  var videos;
  String? language;
  var updatedAt;
  String? createdAt;

  Datum(
      {this.sId,
        this.userId,
        this.productId,
        this.sellerId,
        this.title,
        this.description,
        this.ratings,
        this.type,
        this.images,
        this.videos,
        this.language,
        this.updatedAt,
        this.createdAt});

  Datum.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    productId = json['product_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    description = json['description'];
    ratings = json['ratings'];
    type = json['type'];
    images = json['images'];
    videos = json['videos'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['ratings'] = this.ratings;
    data['type'] = this.type;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UserId {
  String? sId;
  var profilePic;
  var name;

  UserId({this.sId, this.profilePic, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profile_pic'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    return data;
  }
}

