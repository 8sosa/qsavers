class CardListData {
  int? totalCount;
  List<CardListSubData>? data;

  CardListData({this.totalCount, this.data});

  CardListData.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <CardListSubData>[];
      json['data'].forEach((v) {
        data!.add(new CardListSubData.fromJson(v));
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

class CardListSubData {
  String? sId;
  String? userId;
  String? paymentMethod;
  String? brand;
  int? expMonth;
  int? expYear;
  int? last4;
  String? fingerprint;
  bool? isDeleted;
  bool? isDefault;
  bool? isSaved;
  String? createdAt;

  CardListSubData(
      {this.sId,
        this.userId,
        this.paymentMethod,
        this.brand,
        this.expMonth,
        this.expYear,
        this.last4,
        this.fingerprint,
        this.isDeleted,
        this.isDefault,
        this.isSaved,
        this.createdAt});

  CardListSubData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    brand = json['brand'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    last4 = json['last4'];
    fingerprint = json['fingerprint'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    isSaved = json['is_saved'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['payment_method'] = this.paymentMethod;
    data['brand'] = this.brand;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['last4'] = this.last4;
    data['fingerprint'] = this.fingerprint;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['is_saved'] = this.isSaved;
    data['created_at'] = this.createdAt;
    return data;
  }
}