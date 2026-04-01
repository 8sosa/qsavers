class ExpiredCouponDataModel {
  var sId;
  var name;
  bool? forHomepage;
  var code;
  var description;
  var type;
  var subType;
  var startDate;
  var endDate;
  int? price;
  int? percentage;
  int? maxDiscount;
  bool? isAvailable;
  bool? isDeleted;
  var applicableFor;
  List<String>? productIds;
  var addedBy;
  var sellerId;
  var language;
  var updatedAt;
  var createdAt;

  ExpiredCouponDataModel(
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

  ExpiredCouponDataModel.fromJson(Map<String, dynamic> json) {
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
    if (json['product_ids'] != null) {
      productIds = <String>[];
      json['product_ids'].forEach((v) {
        productIds!.add(v);
      });
    }
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
    // if (this.productIds != null) {
    //   data['product_ids'] = this.productIds!.map((v) => v.toJson()).toList();
    // }
    data['added_by'] = this.addedBy;
    data['seller_id'] = this.sellerId;
    data['language'] = this.language;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}




