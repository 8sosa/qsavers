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

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:quantity_savers/app/core/values/app_strings.dart';

class AuthRequestModel {
/*===================================================Register Request Model==============================================*/
  static signupRequestModel({
    required var email,
    required var name,
    var profile_pic,
    required var contactNumber,
    required var deviceType,
    required var fcmToken,
    var countryCode,
    required String? countryName,
    required String? password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["profile_pic"] = profile_pic;
    data["phone_no"] = contactNumber;
    data["email"] = email;
    data["country_code"] = countryCode;
    data["device_type"] = deviceType;
    data["fcm_token"] = fcmToken;
    data["password"] = password;
    data["country_name"] = countryName;
    data["language"] = "ENGLISH";
    return data;
  }

  /*===================================================Secondary Address Request Model==============================================*/

  static secondAddressRequestModel(
      {required var email,
      required var name,
      required var contactNumber,
      var countryCode,
      var landMark,
      var latitude,
      var longitude,
      var pinCode,
      var addressLine1,
      var country,
      var city}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["phone_no"] = contactNumber;
    data["email"] = email;
    data["country_code"] = countryCode;
    data["landmark"] = landMark;
    data["lng"] = longitude;
    data["lat"] = latitude;
    data["pincode"] = pinCode;
    data["address_line1"] = addressLine1;
    data["country"] = country;
    data["city"] = city;
    return data;
  }

/*==================================================Login Request Model==============================================*/
  static loginRequestModel({
    required String? email,
    required String? password,
    required String? deviceType,
    required String? fcmToken,
    required String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    data["device_type"] = deviceType;
    data["fcm_token"] = fcmToken;
    data["language"] = language;
    return data;
  }

  /*==================================================phoneNumber Change Request Model==============================================*/
  static phoneNOChangeRequestModel({
    required String? countryCode,
    required String? countryName,
    required int? phoneNo,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country_code"] = countryCode;
    data["country_name"] = countryName;
    data["phone_no"] = phoneNo;

    return data;
  }

  /*=================================================== Profile Completion Model==============================================*/
  static profileCompletionApiCall({
    String? description,
    String? tradeLicence,
    String? insurance,
    String? vat,
    String? otherDoc,
    String? documentId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['trade_license'] = tradeLicence;
    data['insurance'] = insurance;
    data['vat'] = vat;
    data['other_doc'] = otherDoc;
    data['document_id'] = documentId;
    return data;
  }

/*==================================================LogOut Request Model==============================================*/
  static logOutRequestModel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  /*================================================== Get Profile Request Model==============================================*/
  static getProfileRequestModel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["language"] = "ENGLISH";
    return data;
  }

/*================================================== Get Location  Request Model==============================================*/

  static locationRequestModel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  /*================================================== Get services  Request Model==============================================*/

  static servicesRequestModel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

  /*================================================== Add Location  Request Model==============================================*/

  static addLocationRequestModel({
    String? cityId,
    List? areaId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["city_id"] = cityId;
    data["area_id"] = areaId;
    return data;
  }

  /*================================================== Add Services  Request Model==============================================*/

/*  static Map<String, dynamic> addServicesRequestModel({  List<String>? service}) {
    final Map<String, dynamic> data =<String, dynamic> {};
    data["services"]=service;
    return data;
  }*/

  static Map<String, dynamic> addServicesRequestModel(
      {List<Map<String, dynamic>>? service}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["services"] = service;
    return data;
  }

/*==================================================Forgot Password Request Model==============================================*/
  static forgotPasswordRequestModel({
    String? email,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["language"] = language;
    return data;
  }

/*==================================================Verify Otp Request Model==============================================*/
  static verifyOtpRequestModel({
    required String? otp,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["otp"] = otp;
    data["language"] = "ENGLISH";
    return data;
  }

  /*==================================================Resend Otp on email Request Model==============================================*/
  static resendOtpOnEmailRequestModel({
    required String? email,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["language"] = "ENGLISH";
    return data;
  }

  /*==================================================Resend Otp on Phone Request Model==============================================*/
  static resendOtpOnPhoneRequestModel({
    required String? code,
    required String? phoneNo,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country_code"] = code;
    data["phone_no"] = phoneNo;
    data["language"] = "ENGLISH";
    return data;
  }

  /*==================================================Delete Account Request Model==============================================*/
  static deleteAccountRequestModel({
    required String? deactivateReason,
    String? password,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["deactivate_reason"] = deactivateReason;
    data["password"] = password;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*==================================================Resend Otp on Forgot Password Request Model==============================================*/
  static resendOtpOnForgotPasswordRequestModel({
    required String? uniqueCode,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unique_code"] = uniqueCode;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*==================================================New Password Request Model==============================================*/
  static newPasswordRequestModel({
    required String? uniqueCode,
    required String? password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unique_code"] = uniqueCode;
    data["password"] = password;
    data["language"] = strLanguageEnglish;
    return data;
  }

/*==================================================Verify Forgot Otp Request Model==============================================*/
  static verifyForgotOtpRequestModel({
    String? uniqueCode,
    String? otp,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unique_code"] = uniqueCode;
    data["otp"] = otp;
    data["language"] = language;
    return data;
  }

  /*==================================================add Name Image Request Model==============================================*/
  static addNameImageRequestModel({
    String? image,
    String? name,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["image"] = image;
    data["name"] = name;
    return data;
  }

/*==================================================Resend Otp Request Model==============================================*/

  static resendOtpRequestModel() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data["User[country_code]"] = countryCode;
    return data;
  }

/*====================================================change password Request Model====================================*/

  static changePasswordRequestModel(
      {required String oldPassword, newPassword}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["old_password"] = oldPassword;
    data["new_password"] = newPassword;
    data["language"] = "ENGLISH";
    return data;
  }

  /*====================================================set password Request Model====================================*/

  static setPasswordRequestModel(
      {required String password}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["password"] = password;
    data["language"] = "ENGLISH";
    return data;
  }

  /*===================================================Profile creation Request Model==============================================*/

  static profileRequestModel({
    MultipartFile? profileFile,
    required String? firstName,
    required String? lastName,
    required String? address,
    required String? latitude,
    required String? longitude,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[profile_file]"] = profileFile;
    data["User[first_name]"] = firstName;
    data["User[last_name]"] = lastName;
    data["User[address]"] = address;
    data["User[latitude]"] = latitude;
    data["User[longitude]"] = longitude;

    return data;
  }

/*====================================================change password Request Model====================================*/

  static contactUsRequestModel({
    required String name,
    required String email,
    required String countryCode,
    required int phoneNumber,
    String? language,
    required String message,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email;
    data["country_code"] = countryCode;
    data["phone_no"] = phoneNumber;
    data["message"] = message;
    data["language"] = strLanguageEnglish;
    return data;
  }

  /*==================================================== Book Ride Request Model====================================*/

  static bookRideRequestModel({
    String? pickUp,
    var pickUpLat,
    var pickUpLong,
    String? destination,
    var destinationLong,
    var destinationLat,
    var carTypeId,
    var estimatedAmount,
    String? estimateTime,
    String? pickUpTime,
    var totalKm,
    var scheduleDuration,
    var paymentType,
    var addStops,
    var driverId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Ride[pickup]"] = pickUp;
    data["Ride[pickup_lat]"] = pickUpLat;
    data["Ride[pickup_long]"] = pickUpLong;
    data["Ride[destination]"] = destination;
    data["Ride[destination_long]"] = destinationLong;
    data["Ride[destination_lat]"] = destinationLat;
    data["Ride[car_type_id]"] = carTypeId;
    data["PriceDetail[estimated_amount]"] = estimatedAmount;
    data["Ride[estimate_time]"] = estimateTime;
    data["Ride[pickup_time]"] = pickUpTime;
    data["Ride[total_km]"] = totalKm;
    data["Ride[schedule_duration]"] = scheduleDuration;
    data["Ride[payment_type]"] = paymentType;
    data["Ride[stops]"] = addStops;
    data["Ride[driver_id]"] = driverId;
    return data;
  }

/*==================================================Social Login Request ==============================================*/

  static socialLoginRequestModel(
      {var userId,
      var email,
      var fullName,
      var username,
      var provider,
      var imgUrl,
      var deviceToken,
      var deviceType,
      var deviceName}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User[userId]'] = userId;
    data['User[email]'] = email;
    data['User[full_name]'] = fullName;
    data['LoginForm[username]'] = username;
    data['LoginForm[provider]'] = provider;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    data['img_url'] = imgUrl;

    return data;
  }

  static logCrashErrorReq({
    error,
    packageVersion,
    phoneModel,
    ip,
    stackTrace,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }

  /*====================================================Schedule Ride Request Model====================================*/

  static scheduleRideRequestModel({
    String? pickUpLocation,
    String? destination,
    var destinationLong,
    var destinationLat,
    var pickUpLat,
    var pickUpLong,
    var carTypeId,
    var estimatedAmount,
    var finalAmount,
    String? estimateTime,
    String? pickUpTime,
    var totalKm,
    String? scheduleDuration,
    var paymentType,
    var discount,
    var promoCodeId,
    var typeId,
    var driverId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Ride[pickup_location]"] = pickUpLocation;
    data["Ride[destination]"] = destination;
    data["Ride[destination_long]"] = destinationLong;
    data["Ride[destination_lat]"] = destinationLat;
    data["Ride[pickup_lat]"] = pickUpLat;
    data["Ride[pickup_long]"] = pickUpLong;
    data["Ride[car_type_id]"] = carTypeId;
    data["Ride[estimated_amount]"] = estimatedAmount;
    data["Ride[final_amount]"] = finalAmount;
    data["Ride[estimate_time]"] = estimateTime;
    data["Ride[pickup_time]"] = pickUpTime;
    data["Ride[total_km]"] = totalKm;
    data["Ride[schedule_duration]"] = scheduleDuration;
    data["Ride[payment_type]"] = paymentType;
    data["Ride[discount]"] = discount;
    data["Ride[promo_code_id]"] = promoCodeId;
    data["Ride[type_id]"] = typeId;
    data["Ride[driver_id]"] = driverId;
    return data;
  }

  /*====================================================Add Address Request Model====================================*/

  static addAddressRequestModel({
    String? name,
    var country,
    String? state,
    var zipCode,
    var addressOne,
    var latitudeOne,
    var longitudeOne,
    String? typeId,
    var anyOtherName,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["UserAddress[name]"] = name;
    data["UserAddress[country]"] = country;
    data["UserAddress[state]"] = state;
    data["UserAddress[zipcode]"] = zipCode;
    data["UserAddress[address_one]"] = addressOne;
    data["UserAddress[latitude_one]"] = latitudeOne;
    data["UserAddress[longitude_one]"] = longitudeOne;
    data["UserAddress[type_id]"] = typeId;
    data["UserAddress[other]"] = anyOtherName;
    return data;
  }

  /*====================================================Send Message Request Model====================================*/

  static sendMessageReq({
    String? message,
    int? toId,
    int? rideId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Chat[message]'] = message;
    data['Chat[to_id]'] = toId;
    data['Chat[ride_id]'] = rideId;
    return data;
  }

  /*====================================================Send Courier Request Model====================================*/

  static sendCourierReq({
    String? pickUp,
    String? destination,
    var destinationLong,
    var destinationLat,
    var pickUpLat,
    var pickUpLong,
    int? carTypeId,
    String? estimateTime,
    String? pickUpTime,
    var totalKm,
    var totalMin,
    int? deliveryTypeId,
    String? length,
    String? height,
    String? weight,
    String? width,
    String? quantity,
    String? description,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Ride[pickup]'] = pickUp;
    data['Ride[destination]'] = destination;
    data['Ride[destination_long]'] = destinationLong;
    data['Ride[destination_lat]'] = destinationLat;
    data['Ride[pickup_lat]'] = pickUpLat;
    data['Ride[pickup_long]'] = pickUpLong;
    data['Ride[car_type_id]'] = carTypeId;
    data['Ride[estimate_time]'] = estimateTime;
    data['Ride[pickup_time]'] = pickUpTime;
    data['Ride[total_km]'] = totalKm;
    data['Ride[total_min]'] = totalMin;
    data['CourierDetail[delivery_type_id]'] = deliveryTypeId;
    data['CourierDetail[length]'] = length;
    data['CourierDetail[height]'] = height;
    data['CourierDetail[weight]'] = weight;
    data['CourierDetail[width]'] = width;
    data['CourierDetail[quantity]'] = quantity;
    data['CourierDetail[description]'] = description;
    return data;
  }

  /*===================================================Add Rating Request Model==============================================*/

  static addRatingReq({
    required var rating,
    required var review,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Rating[rating] "] = rating;
    data["Rating[comment]"] = review;
    return data;
  }
  /*===================================================Social LogIn Request Model==============================================*/

  static socialLogInRequestModel({
    String? socialType,
    String? socialToken,
    String? email,
    String? countryCode,
    String? phoneNo,
    String? name,
    String? deviceType,
    String? fcmToken,
    String? language
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["social_type"] = socialType;
    data["social_token"] = socialToken;
    data["email"] = email;
    data["country_code"] = countryCode;
    data["phone_no"] = phoneNo;
    data["name"] = name;
    data["device_type"] = deviceType;
    data["fcm_token"] = fcmToken;
    data["language"] = strLanguageEnglish;
    return data;
  }
}
