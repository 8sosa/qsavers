class VendorsDataModel {
  var totalCount;
  List<Data>? data;

  VendorsDataModel({this.totalCount, this.data});

  VendorsDataModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var sId;
  var name;
  var email;
  var countryCode;
  var phoneNumber;
  var image;
  var emailOtp;
  var emailVerified;
  var uniqueCode;
  var fpOtp;
  var fpOtpVerified;
  var company;
  var country;
  var state;
  var city;
  var pinCode;
  var apartmentNumber;
  var fullAddress;
  var shippoAddressId;
  var accountStatus;
  var deactivationReason;
  var isDeleted;
  var isBlocked;
  var maxCampaignDuration;
  var language;
  var createdAt;

  Data(
      {this.sId,
      this.name,
      this.email,
      this.countryCode,
      this.phoneNumber,
      this.image,
      this.emailOtp,
      this.emailVerified,
      this.uniqueCode,
      this.fpOtp,
      this.fpOtpVerified,
      this.company,
      this.country,
      this.state,
      this.city,
      this.pinCode,
      this.apartmentNumber,
      this.fullAddress,
      this.shippoAddressId,
      this.accountStatus,
      this.deactivationReason,
      this.isDeleted,
      this.isBlocked,
      this.maxCampaignDuration,
      this.language,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    emailOtp = json['email_otp'];
    emailVerified = json['email_verified'];
    uniqueCode = json['unique_code'];
    fpOtp = json['fp_otp'];
    fpOtpVerified = json['fp_otp_verified'];
    company = json['company'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pinCode = json['pin_code'];
    apartmentNumber = json['apartment_number'];
    fullAddress = json['full_address'];
    shippoAddressId = json['shippo_address_id'];
    accountStatus = json['account_status'];
    deactivationReason = json['deactivation_reason'];
    isDeleted = json['is_deleted'];
    isBlocked = json['is_blocked'];
    maxCampaignDuration = json['max_campaign_duration'];
    language = json['language'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['email_otp'] = this.emailOtp;
    data['email_verified'] = this.emailVerified;
    data['unique_code'] = this.uniqueCode;
    data['fp_otp'] = this.fpOtp;
    data['fp_otp_verified'] = this.fpOtpVerified;
    data['company'] = this.company;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['apartment_number'] = this.apartmentNumber;
    data['full_address'] = this.fullAddress;
    data['shippo_address_id'] = this.shippoAddressId;
    data['account_status'] = this.accountStatus;
    data['deactivation_reason'] = this.deactivationReason;
    data['is_deleted'] = this.isDeleted;
    data['is_blocked'] = this.isBlocked;
    data['max_campaign_duration'] = this.maxCampaignDuration;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    return data;
  }
}
