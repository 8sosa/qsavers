/*
 *
 *  * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 *  * @author     : Gaurav Negi
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of Henceforth Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *  *
 *
 */

class NearbyDriverDataModel {
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? address;
  String? latitude;
  String? longitude;
  String? email;
  var dateOfBirth;
  int? gender;
  String? countryCode;
  String? contactNo;
  String? language;
  String? profileFile;
  int? step;
  String? otp;
  int? otpVerified;
  int? isOnline;
  int? roleId;
  int? stateId;
  int? typeId;
  String? timezone;
  String? createdOn;
  int? rideId;

  NearbyDriverDataModel(
      {this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.address,
        this.latitude,
        this.longitude,
        this.email,
        this.dateOfBirth,
        this.gender,
        this.countryCode,
        this.contactNo,
        this.language,
        this.profileFile,
        this.step,
        this.otp,
        this.otpVerified,
        this.isOnline,
        this.roleId,
        this.stateId,
        this.typeId,
        this.timezone,
        this.createdOn,
        this.rideId,
      });

  NearbyDriverDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    language = json['language'];
    profileFile = json['profile_file'];
    step = json['step'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    isOnline = json['is_online'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    rideId = json['ride_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['country_code'] = countryCode;
    data['contact_no'] = contactNo;
    data['language'] = language;
    data['profile_file'] = profileFile;
    data['step'] = step;
    data['otp'] = otp;
    data['otp_verified'] = otpVerified;
    data['is_online'] = isOnline;
    data['role_id'] = roleId;
    data['state_id'] = stateId;
    data['type_id'] = typeId;
    data['timezone'] = timezone;
    data['created_on'] = createdOn;
    data['ride_id'] = rideId;
    return data;
  }
}