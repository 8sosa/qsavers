class AddPaymentMethodData {
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
  String? sId;
  int? iV;

  AddPaymentMethodData(
      {this.userId,
        this.paymentMethod,
        this.brand,
        this.expMonth,
        this.expYear,
        this.last4,
        this.fingerprint,
        this.isDeleted,
        this.isDefault,
        this.isSaved,
        this.createdAt,
        this.sId,
        this.iV});

  AddPaymentMethodData.fromJson(Map<String, dynamic> json) {
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
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}