class DefaultBankDataModel {
  var userId;
  var stripeConnectId;
  var name;
  int? last4;
  var fingerprint;
  var bankAccountId;
  var routingNumber;
  var dob;
  bool? isDeleted;
  bool? isDefault;
  var createdAt;
  var sId;
  int? iV;

  DefaultBankDataModel(
      {this.userId,
        this.stripeConnectId,
        this.name,
        this.last4,
        this.fingerprint,
        this.bankAccountId,
        this.routingNumber,
        this.dob,
        this.isDeleted,
        this.isDefault,
        this.createdAt,
        this.sId,
        this.iV});

  DefaultBankDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    stripeConnectId = json['stripe_connect_id'];
    name = json['name'];
    last4 = json['last4'];
    fingerprint = json['fingerprint'];
    bankAccountId = json['bank_account_id'];
    routingNumber = json['routing_number'];
    dob = json['dob'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['stripe_connect_id'] = this.stripeConnectId;
    data['name'] = this.name;
    data['last4'] = this.last4;
    data['fingerprint'] = this.fingerprint;
    data['bank_account_id'] = this.bankAccountId;
    data['routing_number'] = this.routingNumber;
    data['dob'] = this.dob;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

