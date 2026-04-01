class SocialLogInDataModel {
  var sId;
  var socialType;
  var socialToken;
  var profilePic;
  var name;
  var email;
  var countryCode;
  var phoneNo;
  var phoneOtp;
  var uniqueCode;
  var fpOtp;
  var fpOtpVerified;
  var wrongPwdCount;
  var lockedTill;
  var stripeConnectId;
  var customerId;
  var paymentId;
  var description;
  var adminVerified;
  var emailVerified;
  var phoneVerified;
  var about;
  var accountStatus;
  var deactivationReason;
  var isBlocked;
  var isDeleted;
  var isOnline;
  var language;
  var createdAt;
  var accessToken;
  var deviceType;
  var fcmToken;
  var tokenGenAt;

  SocialLogInDataModel(
      {this.sId,
        this.socialType,
        this.socialToken,
        this.profilePic,
        this.name,
        this.email,
        this.countryCode,
        this.phoneNo,
        this.phoneOtp,
        this.uniqueCode,
        this.fpOtp,
        this.fpOtpVerified,
        this.wrongPwdCount,
        this.lockedTill,
        this.stripeConnectId,
        this.customerId,
        this.paymentId,
        this.description,
        this.adminVerified,
        this.emailVerified,
        this.phoneVerified,
        this.about,
        this.accountStatus,
        this.deactivationReason,
        this.isBlocked,
        this.isDeleted,
        this.isOnline,
        this.language,
        this.createdAt,
        this.accessToken,
        this.deviceType,
        this.fcmToken,
        this.tokenGenAt});

  SocialLogInDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    socialType = json['social_type'];
    socialToken = json['social_token'];
    profilePic = json['profile_pic'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phoneNo = json['phone_no'];
    phoneOtp = json['phone_otp'];
    uniqueCode = json['unique_code'];
    fpOtp = json['fp_otp'];
    fpOtpVerified = json['fp_otp_verified'];
    wrongPwdCount = json['wrong_pwd_count'];
    lockedTill = json['locked_till'];
    stripeConnectId = json['stripe_connect_id'];
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    description = json['description'];
    adminVerified = json['admin_verified'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    about = json['about'];
    accountStatus = json['account_status'];
    deactivationReason = json['deactivation_reason'];
    isBlocked = json['is_blocked'];
    isDeleted = json['is_deleted'];
    isOnline = json['is_online'];
    language = json['language'];
    createdAt = json['created_at'];
    accessToken = json['access_token'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    tokenGenAt = json['token_gen_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['social_type'] = this.socialType;
    data['social_token'] = this.socialToken;
    data['profile_pic'] = this.profilePic;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone_no'] = this.phoneNo;
    data['phone_otp'] = this.phoneOtp;
    data['unique_code'] = this.uniqueCode;
    data['fp_otp'] = this.fpOtp;
    data['fp_otp_verified'] = this.fpOtpVerified;
    data['wrong_pwd_count'] = this.wrongPwdCount;
    data['locked_till'] = this.lockedTill;
    data['stripe_connect_id'] = this.stripeConnectId;
    data['customer_id'] = this.customerId;
    data['payment_id'] = this.paymentId;
    data['description'] = this.description;
    data['admin_verified'] = this.adminVerified;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['about'] = this.about;
    data['account_status'] = this.accountStatus;
    data['deactivation_reason'] = this.deactivationReason;
    data['is_blocked'] = this.isBlocked;
    data['is_deleted'] = this.isDeleted;
    data['is_online'] = this.isOnline;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['access_token'] = this.accessToken;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    data['token_gen_at'] = this.tokenGenAt;
    return data;
  }
}
