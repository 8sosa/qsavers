class ApplyCouponDataModel {
  var couponDiscount;
  Response? response;

  ApplyCouponDataModel({this.couponDiscount, this.response});

  ApplyCouponDataModel.fromJson(Map<String, dynamic> json) {
    couponDiscount = json['coupon_discount'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_discount'] = this.couponDiscount;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}
class Response {
  String? sId;
  String? name;
  bool? forHomepage;
  String? code;
  String? description;
  String? type;
  String? subType;
  String? startDate;
  String? endDate;
  int? price;
  int? percentage;
  int? maxDiscount;
  bool? isAvailable;
  bool? isDeleted;
  String? applicableFor;
  var productIds;
  String? addedBy;
  String? sellerId;
  String? language;
  String? updatedAt;
  String? createdAt;

  Response(
      {this.sId,
        this.name,
        this.forHomepage,
        this.code,
        this.description,
        this.type,
        this.subType,
        this.startDate,
        this.endDate,
        this.price,
        this.percentage,
        this.maxDiscount,
        this.isAvailable,
        this.isDeleted,
        this.applicableFor,
        this.productIds,
        this.addedBy,
        this.sellerId,
        this.language,
        this.updatedAt,
        this.createdAt});

  Response.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    forHomepage = json['for_homepage'];
    code = json['code'];
    description = json['description'];
    type = json['type'];
    subType = json['sub_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    percentage = json['percentage'];
    maxDiscount = json['max_discount'];
    isAvailable = json['is_available'];
    isDeleted = json['is_deleted'];
    applicableFor = json['applicable_for'];
    productIds = json['product_ids'];
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    language = json['language'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['for_homepage'] = this.forHomepage;
    data['code'] = this.code;
    data['description'] = this.description;
    data['type'] = this.type;
    data['sub_type'] = this.subType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['percentage'] = this.percentage;
    data['max_discount'] = this.maxDiscount;
    data['is_available'] = this.isAvailable;
    data['is_deleted'] = this.isDeleted;
    data['applicable_for'] = this.applicableFor;
    data['product_ids'] = this.productIds;
    data['added_by'] = this.addedBy;
    data['seller_id'] = this.sellerId;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}