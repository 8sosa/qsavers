class AddBankDataModel {
  bool? isVerifiyRequest;
  List<AddBankSubDataModel>? data;

  AddBankDataModel({this.isVerifiyRequest, this.data});

  AddBankDataModel.fromJson(Map<String, dynamic> json) {
    isVerifiyRequest = json['is_verifiy_request'];
    if (json['data'] != null) {
      data = <AddBankSubDataModel>[];
      json['data'].forEach((v) {
        data!.add(new AddBankSubDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_verifiy_request'] = this.isVerifiyRequest;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddBankSubDataModel {
  var userId;
  var stripeConnectId;
  var type;
  var ssn;
  var paypalEmail;
  var accountDetail;
  var country;
  var country_id;
  var name;
  var last4;
  var accountNo;
  var fingerprint;
  var bankAccountId;
  var routingNumber;
  var dob;
  var isDeleted;
  var isDefault;
  var createdAt;
  var sId;

  AddBankSubDataModel(
      {this.userId,
      this.stripeConnectId,
        this.type,
        this.ssn,
        this.paypalEmail,
        this.accountDetail,
        this.country,
        this.country_id,
      this.name,
      this.last4,
        this.accountNo,
      this.fingerprint,
      this.bankAccountId,
      this.routingNumber,
      this.dob,
      this.isDeleted,
      this.isDefault,
      this.createdAt,
      this.sId});

  AddBankSubDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    stripeConnectId = json['stripe_connect_id'];
    type= json['type'];
    ssn = json['ssn'];
    paypalEmail=json['paypal_email'];
    accountDetail=json['account_detail'];
    country=json['country'];
    name = json['name'];
    last4 = json['last4'];
    fingerprint = json['fingerprint'];
    bankAccountId = json['bank_account_id'];
    routingNumber = json['routing_number'];
    dob = json['dob'];
    isDeleted = json['is_deleted'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    accountNo = json['account_number'];
    sId = json['_id'];
    country_id=json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['stripe_connect_id'] = this.stripeConnectId;
    data['type']=this.type;
    data['ssn']=this.ssn;
    data['country_id']=this.country_id;
    data['paypal_email']=this.paypalEmail;
    data['account_detail']=this.accountDetail;
    data['country']=this.country;
    data['name'] = this.name;
    data['last4'] = this.last4;
    data['account_number']=this.accountNo;
    data['fingerprint'] = this.fingerprint;
    data['bank_account_id'] = this.bankAccountId;
    data['routing_number'] = this.routingNumber;
    data['dob'] = this.dob;
    data['is_deleted'] = this.isDeleted;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    return data;
  }
}
