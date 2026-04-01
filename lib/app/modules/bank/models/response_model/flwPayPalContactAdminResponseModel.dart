class FlwPayPalConatctAdminBankResponseModel {
  Data? data;

  FlwPayPalConatctAdminBankResponseModel({this.data});

  FlwPayPalConatctAdminBankResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? type;
  var stripeConnectId;
  String? name;
  var last4;
  var fingerprint;
  var bankAccountId;
  String? accountNumber;
  var routingNumber;
  var dob;
  var country;
  bool? isDeleted;
  bool? isDefault;
  String? ssn;
  var bankTokenId;
  var paypalEmail;
  var accountDetail;
  String? createdAt;
  String? sId;
  int? iV;

  Data(
      {this.userId,
        this.type,
        this.stripeConnectId,
        this.name,
        this.last4,
        this.country,
        this.fingerprint,
        this.bankAccountId,
        this.accountNumber,
        this.routingNumber,
        this.dob,
        this.isDeleted,
        this.isDefault,
        this.ssn,
        this.bankTokenId,
        this.paypalEmail,
        this.accountDetail,
        this.createdAt,
        this.sId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    stripeConnectId = json['stripe_connect_id'];
    name = json['name'];
    last4 = json['last4'];
    fingerprint = json['fingerprint'];
    bankAccountId = json['bank_account_id'];
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    dob = json['dob'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    ssn = json['ssn'];
    bankTokenId = json['bank_token_id'];
    paypalEmail = json['paypal_email'];
    accountDetail = json['account_detail'];
    createdAt = json['created_at'];
    country=json['country'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['stripe_connect_id'] = this.stripeConnectId;
    data['name'] = this.name;
    data['last4'] = this.last4;
    data['fingerprint'] = this.fingerprint;
    data['bank_account_id'] = this.bankAccountId;
    data['account_number'] = this.accountNumber;
    data['routing_number'] = this.routingNumber;
    data['dob'] = this.dob;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['ssn'] = this.ssn;
    data['bank_token_id'] = this.bankTokenId;
    data['paypal_email'] = this.paypalEmail;
    data['account_detail'] = this.accountDetail;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['country']=this.country;
    return data;
  }
}

