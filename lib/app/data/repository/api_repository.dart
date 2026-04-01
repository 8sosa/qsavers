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

import 'package:http_parser/http_parser.dart';
import 'package:quantity_savers/app/data/models/common_message_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/add_to_cart_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/campaign_members_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/can_add_review_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/can_review_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/delete_campaign_request_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/delivery_check_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/download_invoice_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/edit_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/exit_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/faq_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/join_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/order_place_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_campaigns_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_details_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_faq_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_media_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/product_review_like_and_dislike_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/related_product_response_model.dart';
import 'package:quantity_savers/app/modules/Details/models/response_model/start_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/dataModel/location_data_module.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/logout_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/new_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/resend_otp_response_module.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/save_data_update_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/service_daa_module.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/set_password_response_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/social_login_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/add_bank_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/country_details_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/country_selection_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/default_bank_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/delete_bank_response_model.dart';
import 'package:quantity_savers/app/modules/bank/models/response_model/flwPayPalContactAdminResponseModel.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_completed_order_response_model.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_creator_response_model.dart';
import 'package:quantity_savers/app/modules/campaigns/models/response_model/campaign_customer_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/add_member_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/create_group_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/exit_delete_group_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/forum_media_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/forum_sent_request_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/forums_request_members_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_campaign_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_info_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_list_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/group_members_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/join_public_group_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/manage_request_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/chat_history_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/message_received_notification_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/report_member_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/request_status_response_model.dart';
import 'package:quantity_savers/app/modules/forums/models/response_model/search_group_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/categories_details_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/bottom_banner_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/brandListResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/campaign_data_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/campaign_filter_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/corresponding_products_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/deal_of_day_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/get_schedule_live_broad_cast_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/main_search_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/mark_all_read_notifications.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/middle_banner_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_sub_sub_categoryResponseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/product_subcategory_responseModel.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/schedule_live_broadcast_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/top_banner_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/user_notifications_response_model.dart';
import 'package:quantity_savers/app/modules/home/models/response_model/vendor_search_response_model.dart';
import 'package:quantity_savers/app/modules/live_streaming/agora_token_request_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/responce_models/addAddress_responce_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/responce_models/defaultAddress_response_model.dart';
import 'package:quantity_savers/app/modules/manage_address/models/responce_models/delete_address_response_model.dart';
import 'package:quantity_savers/app/modules/my_orders/response_Model/cancel_order_response_model.dart';
import 'package:quantity_savers/app/modules/my_orders/response_Model/order_response_model.dart';
import 'package:quantity_savers/app/modules/payment/models/add_card_stripe_model.dart';
import 'package:quantity_savers/app/modules/payment/models/responce_models/add_payment_method_response_model.dart';
import 'package:quantity_savers/app/modules/payment/models/responce_models/apply_coupon_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/data_models/campaign_request_data_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/available_coupon_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/campaign_earning_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/campaign_request_list_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/campaign_request_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/campaign_request_details_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/expired_coupon_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/list_content_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/payout_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/delete_review_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/edit_review_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/product_review_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/review_rating_response_model.dart';
import 'package:quantity_savers/app/modules/reviews_and_ratings/response_Model/user_product_review_response_model.dart';
import 'package:quantity_savers/app/modules/profile/models/response_model/profile_faq_response_model.dart';
import '../../export.dart';
import '../../modules/Details/models/response_model/add_to_wishlist_response_model.dart';
import '../../modules/Details/models/response_model/remove_from_wishlist.dart';
import '../../modules/home/models/response_model/order_cancellation_response_model.dart';
import '../../modules/home/models/response_model/read_single_notifications_response_model.dart';
import '../../modules/profile/models/response_model/card_delete_response_model.dart';
import '../../modules/wishlist/models/response_model/wishlist_response_model.dart';

class APIRepository {
  static late DioClient? dioClient;
  var deviceName, deviceType, deviceID, deviceVersion;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = "ANDROID"; /* androidDeviceInfo.model;*/
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.systemName;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  /*===================================================================== Register API Call  ==========================================================*/

  Future signUpApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(signUpEndPoint, data: jsonEncode(dataBody!));
      print(response);
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Second Contact API Call  ==========================================================*/

  Future secondContactApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(secondContactEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return LoginDataModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Location API Call  ==========================================================*/

  Future<List<Area>> locationApiCall() async {
    try {
      final response = await dioClient!.get(
        locationEndPoint,
        skipAuth: false,
      );
      // print("8374374837${response['data']}");
      List<Area> detail = [];
      //  print("8374374837$response");

      final areas = response['data'];
      for (var area in areas) {
        detail.add(Area.fromJson(area));
      }
      return detail;
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================  Add Location API Call  ==========================================================*/

  Future addLocationApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(addLocationEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      print("8374374837$response");
      return LoginDataModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================  Add Service API Call  ==========================================================*/

  Future addServiceApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(adServicesEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return response;
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Services ============================================*/

  Future getServicesList() async {
    try {
      final response =
          await dioClient!.get(getVendorServicesEndPoint, skipAuth: false);
      return AddServices.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get the other document list  ============================================*/

  Future getOtherDocsList() async {
    try {
      final response =
          await dioClient!.get(getOtherDocListEndPoint, skipAuth: false);
      return Getotherdoclist.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*===================================================================== Login API Call  ==========================================================*/
  Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(loginEndPoint, data: jsonEncode(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {

      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Get Profile API Call  ==========================================================*/

  Future getProfileApiCall() async {
    try {
      final response = await dioClient!.get(
        getProfileEndPoint,
        skipAuth: false,
      );
      print("data: ");
      print(jsonEncode(LoginResponseModel.fromJson(response)));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== ProfileCompletion  API Call  ==========================================================*/

  Future profileCompletionApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(profileCompletionEndPoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return ProfieCompeletionModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Forgot password API Call  ==========================================================*/
  Future forgotPasswordApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient?.post(forgotEndPoint, data: jsonEncode(dataBody!));
      return ForgotPasswordResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================LogOut API Call  ==========================================================*/
  Future logOutApiCall() async {
    try {
      final response = await dioClient?.put(logoutEndPoint, skipAuth: false);
      return LogoutResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================Delete Account API Call  ==========================================================*/
  Future deleteAccountApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(deleteAccountEndPoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return LogoutResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================  change Number API Call  ==========================================================*/
  Future changeNumberApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(changePhoneNumberEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return LoginDataModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=====================================================================  change Image & Name API Call  ==========================================================*/
  Future changeNameImageApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(changeNameImageEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return LoginDataModel.fromJson(response["data"]);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*===================================================================== Verify OTP API Call  ==========================================================*/
  Future verifyEmailOtpApiCall(
      {required Map<String, dynamic>? dataBody, type}) async {
    try {
      final response = await dioClient!.post(emailVerification,
          skipAuth: false,
          /*queryParameters: {typeKey: type},*/ data: jsonEncode(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Verify OTP phone after login API Call  ==========================================================*/
  Future verifyOtpPhoneApiCall(
      {required Map<String, dynamic>? dataBody, type}) async {
    try {
      final response = await dioClient?.post(pgoneOtpVerifyEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Verify Forgot OTP API Call  ==========================================================*/
  Future verifyForgotOtpApiCall(
      {required Map<String, dynamic>? dataBody, type}) async {
    try {
      final response = await dioClient?.post(
          skipAuth: true, verifyForgotOtpEndPoint, data: jsonEncode(dataBody!));
      return ForgotPasswordResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*===================================================================== NewPassword API Call  ==========================================================*/
  Future newPasswordApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient?.post(newPasswordOtpEndPoint,
          data: jsonEncode(dataBody!));
      return SetPasswordResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*===================================================================== Resend OTP API Call  ==========================================================*/
  Future resendEmailOtpApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(resendOtpEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return OtpResendModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  Future resendPhoneOtpApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(resendOtpOnPhoneEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return OtpResendModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  Future resendForgotPasswordOtpApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(resendOtpOnForgotPasswordEndPoint,
          skipAuth: true, data: jsonEncode(dataBody!));
      return ForgotPasswordResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== change Password  ============================================*/

  Future changePasswordApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(changePasswordEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return CommonMessageResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== set Password  ============================================*/

  Future setPasswordApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(setPasswordEndPoint,
          skipAuth: false, data: jsonEncode(dataBody!));
      return SetPasswordResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  // /*====================================================================== update Profile  ============================================*/

  Future updateProfileApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(editProfileEndPoint,
          skipAuth: false, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  //*====================================================================== update files to the server  Profile - completion  ============================================*/

  Future uploadImageApi(file, String mediaType) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: file.path.toString().split("/").last,
            contentType: MediaType(mediaType, getFileExtension(file)))
      });
      var response = await dioClient!.post(
        uploadImage,
        data: formData,
      );
      print(
          "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++$response");
      return ImageResposemodel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  getFileExtension(file) {
    debugPrint("file extension ${file.path.toString().split(".").last}");
    return file.path.toString().split(".").last;
  }

  //*====================================================================== update files to the server  Profile - completion  ============================================*/

  Future uploadImageAndVideoApi(String filepath, String mediaType) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filepath,
          filename: filepath.toString().split("/").last,
          contentType: MediaType(mediaType, getFileExtensionFromPath(filepath)),
        )
      });

      var response = await dioClient!.post(
        uploadImage,
        data: formData,
      );
      return ImageResposemodel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint("exception upload file $stackTrace");
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  getFileExtensionFromPath(filepath) {
    debugPrint("file extension ${filepath.toString().split(".").last}");
    return filepath.toString().split(".").last;
  }


  //*====================================================================== update files to the server  Profile - completion  ============================================*/

  Future uploadImageAndVideoApiWithOutLoader(String filepath, String mediaType,Function(int, int) onProgress) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filepath,
          filename: filepath.toString().split("/").last,
          contentType: MediaType(mediaType, getFileExtensionFromPathWithOutLoader(filepath)),
        ),
      });

      var response = await dioClient!.post(
        uploadImage,
        data: formData,
         isLoading: false,
        onSendProgress: onProgress,
      );
      return ImageResposemodel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint("exception upload file $stackTrace");
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  getFileExtensionFromPathWithOutLoader(filepath) {
    debugPrint("file extension ${filepath.toString().split(".").last}");
    return filepath.toString().split(".").last;
  }


  //*====================================================================== update files to the server  Profile - completion  ============================================*/

  Future uploadVideoApiWithOutLoader(String filepath, String mediaType,String messageId, Function(int, int) onProgress) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filepath,
          filename: filepath.toString().split("/").last,
          contentType: MediaType(mediaType, getVideoFileExtensionFromPathWithOutLoader(filepath)),
        ),
        "message_id": messageId,
      });

      var response = await dioClient!.post(
        uploadImage,
        data: formData,
        isLoading: false,
        onSendProgress: onProgress,
      );
      return ImageResposemodel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint("exception upload file $stackTrace");
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  getVideoFileExtensionFromPathWithOutLoader(filepath) {
    debugPrint("file extension ${filepath.toString().split(".").last}");
    return filepath.toString().split(".").last;
  }

  /*====================================================================== Get Banner Data  ============================================*/

  Future getBannerProductsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        HomePageBannerEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return TopBannerResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Middle Banner Data  ============================================*/

  Future getMiddleBannerProductsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        HomePageBannerEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return MiddleBannerResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Bottom Banner Data  ============================================*/

  Future getBottomBannerProductsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        HomePageBannerEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return BottomBannerResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Product Categories Data  ============================================*/

  Future getProductCategoriesApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        productCategoriesEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return ProductCategoriesResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Deals of the Day Data  ============================================*/

  Future getDealsOfTheDayApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        dealsOfTheDayEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Deals of the Day Timer Data  ============================================*/

  Future getDealsOfTheDayTimerApiCall() async {
    try {
      final response = await dioClient?.get(
        dealsOfTheDayTimerEndpoint,
        skipAuth: true,
      );
      return DealOfDayTimerResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Top Deals Data  ============================================*/

  Future getTopDealsApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        topDealsEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Top Deals Data  ============================================*/

  Future getFashionDealsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        fashionDealsEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Feature Categories Data  ============================================*/

  Future getFeaturedCategoriesApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        featuredCategoriesEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Shop With Us Data  ============================================*/

  Future getShopWithUsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        shopWithUsEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Vendors Data  ============================================*/

  Future getVendorsApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        vendorsEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return VendorsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Vendors Data  ============================================*/

  Future getBestOnEcommerceApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        bestOnEcommerceEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return DealsOfTheDayResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Main Search Data  ============================================*/

  Future getMainSearchApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        mainSearchEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return MainSearchResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Corresponding Products Data  ============================================*/

  Future getVendorsProductsDetailsApiCall(
      {required Map<String, dynamic>? queryBody,
      required bool canSkipAuth}) async {
    try {
      final response = await dioClient?.get(
        vendorsProductDetailsEndpoint,
        queryParameters: queryBody,
        skipAuth: canSkipAuth,
      );
      debugPrint("Res is $response");
      return VendorsProductsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }


  /*====================================================================== Get Sub Sub Products Data  ============================================*/

  Future getSubSubProductsDetailsApiCall(
      {required Map<String, dynamic>? queryBody
      }) async {
    try {
      final response = await dioClient?.get(
        vendorsProductDetailsEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      debugPrint("Res is $response");
      return VendorsProductsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Details Data  ============================================*/

  Future getProductDetailsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        productDetailsEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return ProductDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Details Data  ============================================*/

  Future getOrderDetailsApiCall(
      {required Map<String, dynamic>? queryBody, String? id}) async {
    try {
      final response = await dioClient?.get(
        "$ordersEndPoint/$id",
        queryParameters: queryBody,
        skipAuth: false,
      );
      return OrderDetailsResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Details Data  ============================================*/

  Future getCompletedCampaignOrderDetailsApiCall(
      {required Map<String, dynamic>? queryBody, String? id}) async {
    try {
      final response = await dioClient?.get(
        "$ordersDetailsEndPoint/$id",
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CampaignCompletedOrderResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Campaign Details Data  ============================================*/

  Future getCampaignCartData({String? id}) async {
    try {
      final response = await dioClient?.get(
        "$userCampaign/$id/join_details",
        skipAuth: false,
      );
      return JoinedCampaignDetailResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add to Cart  ============================================*/

  Future addProductToCartApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        addToCartEndpoint,
        data: queryBody,
        skipAuth: false,
      );
      return AddToCartResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Update Cart value ============================================*/

  Future updateProductToCartApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.put(
        addToCartEndpoint,
        data: queryBody,
        skipAuth: false,
      );
      return AddToCartResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add Address ============================================*/

  Future addAddressApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        addressEndPoint,
        data: queryBody,
        skipAuth: false,
      );
      return AddAddressResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Addresses ============================================*/

  Future getAddressesApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        addressEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return ManageAddressResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Vendors Products Data  ============================================*/

  Future getVendorsProductsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        productEndpoint,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return VendorsProductsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Cart Data  ============================================*/

  Future getCartDataApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        addToCartEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CartDataResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Price Details Data  ============================================*/

  Future getPriceDetailsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        priceDetailsEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return PriceDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product FAQ Data  ============================================*/

  Future getProductFaqApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        productFaqEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return ProductFaqResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Can Review Data  ============================================*/

  Future canReviewApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        canReviewEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CanReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Related Products Data  ============================================*/

  Future relatedProductsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        relatedProductsEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return RelatedProductResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Product Campaigns Data  ============================================*/

  Future getProductCampaignApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        productCampaigns,
        queryParameters: queryBody,
        skipAuth: true,
      );
      return ProductCampaignsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Product Campaigns Data  ============================================*/

  Future getUserGroupList({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        groupUserList,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return UserGroupListResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== generate Payment method  ============================================*/

  Future generatePaymentMethod(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      // Encode your Stripe API key in Base64
      /* String apiKey = 'pk_test_51NbIjfBmBtgwadGT2yXwgz12EOfwyPnLgt4JVn4aRCVSEcNgyzZziUOBDucwNCjl6filvSFqglG2AYgiUAcGUImO009xLcX8xC';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$apiKey:'));*/

      String username =
          'pk_test_51POJERKcuNqJ56F1gXypQBuNlpruDhLHnQQFtgiutyK1Xh2wNmjWM1ivjPz4EvLnkYtZXrFvkOSmZVWNRUCxZ0jI00WEiNcVom';
      String password = username;
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));
      print(basicAuth);

      final response = await dioClient!.post(
        "https://api.stripe.com/v1/payment_methods",
        data: queryBody,
        options: Options(
          headers: {
            'Authorization': basicAuth,
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      return PaymentReasponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add Bank Account  ============================================*/

  Future addPaymentMethodApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        stripeCards,
        data: queryBody,
        skipAuth: false,
      );
      return AddPaymentMethodResponce.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add Bank Account  ============================================*/

  Future addBankApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(addBankEndpoint, data: jsonEncode(dataBody!), skipAuth: false);
      return AddBankResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add Flw-PayPal-ContactAdmin Bank Account  ============================================*/

  Future addFlwPayPalContactAdminBankApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(flwPayPalContactAdminEndPoint, data: jsonEncode(dataBody!), skipAuth: false);
      return FlwPayPalConatctAdminBankResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== List Bank Accounts  ============================================*/

  Future listBankAccountsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(addBankEndpoint, queryParameters: queryBody, skipAuth: false);
      return AddBankResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Create Campaign  ============================================*/

  Future createCampaignApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(createCampaignEndpoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return StartCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== List Cards Accounts  ============================================*/

  Future listCardsApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(stripeCards, queryParameters: queryBody, skipAuth: false);
      return CardsListResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Checkout  ============================================*/

  Future checkOutApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        ordersEndPoint,
        data: queryBody,
        skipAuth: false,
      );
      return CheckOutResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Join Campaign  ============================================*/

  Future joinCampaignApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!.post(
          "User/campaign/${dataBody?["_id"]}/join",
          data: jsonEncode(dataBody!),
          skipAuth: false);
      return JoinCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== update Campaign  ============================================*/

  Future updateCampaignApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!.put(
          "User/campaign/${dataBody?["_id"]}/join",
          data: jsonEncode(dataBody!),
          skipAuth: false);
      return JoinCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Members ============================================*/

  Future getGroupMembersApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(getGroupMembersEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return GroupMembersResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Create Group ============================================*/

  Future createGroupApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!
          .post(createGroupEndpoint, data: dataBody, skipAuth: false);
      return CreateGroupResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Groups list ============================================*/

  Future getGroupListApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(getGroupListEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return GroupListResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Group Details  ============================================*/

  Future getGroupInfoApiCall({
    required String groupId,
  }) async {
    try {
      final response =
          await dioClient!.get("Group/group_details/$groupId", skipAuth: false);
      return GroupInfoResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Checkout  ============================================*/
  Future checkOutForCampaignApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        userCampaignOrder,
        data: queryBody,
        skipAuth: false,
      );
      return CheckOutResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Group Search  ============================================*/

  Future groupSearchApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(groupSearchEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return SearchGroupResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Campaigns Data  ============================================*/

  Future getProductCampaignsApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(getProductCampaignsEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return ProductCampaignsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Campaign Details Data  ============================================*/

  Future getCampaignDetailsApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(
          "User/campaign/${queryBody?["_id"]}",
          queryParameters: queryBody,
          skipAuth: false);
      return CampaignDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Campaign Members Data  ============================================*/

  Future getCampaignMembersApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(
          "User/campaign/${queryBody?["_id"]}/members",
          queryParameters: queryBody,
          skipAuth: false);
      return CampaignGroupMembersResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Exit Campaign Data  ============================================*/

  Future exitCampaignApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!.put(
          "User/campaign/${dataBody?["_id"]}/exit",
          data: dataBody,
          skipAuth: false);
      debugPrint('response is $response');
      return ExitCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint('error is $e');
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Delete Campaign Request ============================================*/

  Future deleteCampaignRequestApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!.put(
          "User/campaign/${dataBody?["_id"]}/delete_request",
          data: dataBody,
          skipAuth: false);
      return DeleteCampaignRequestResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Join Campaign Request ============================================*/

  Future joinCampaignRequestApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!.put(
          "User/campaign/${dataBody?["_id"]}/join",
          data: dataBody,
          skipAuth: false);
      return JoinCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================CreatorCampaignList======================================================*/

  Future getCreatorCampaignApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getCreatorCampaignList,
          skipAuth: false, queryParameters: queryBody);
      debugPrint('response is $response');
      return CampaignCreatorResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================CustomerCampaignList======================================================*/

  Future getCustomerCampaignApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getCustomerCampaignList,
          skipAuth: false, queryParameters: queryBody);
      return CampaignCustomerResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get Campaign Data======================================================*/

  Future getAllCampaignsData({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(getAllCampaigns, skipAuth: false, queryParameters: queryBody);
      return CampaignDataResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Edit Campaign  ============================================*/

  Future editCampaignApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(
          "$editCampaignEndpoint/${dataBody?["_id"]}",
          data: jsonEncode(dataBody!),
          skipAuth: false);

      return EditCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*======================================================================= Get Forum Sent Request Data ======================================================*/

  Future getForumRequestDataCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getForumRequestEndpoint,
          skipAuth: false, queryParameters: queryBody);
      return ForumRequestResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*======================================================================= Get Forum Request Members Data ======================================================*/

  Future getForumRequestMembersDataCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get("Group/${queryBody?["_id"]}/request_list", skipAuth: false);
      return ForumRequestMembersResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*======================================================================= Manage Forum Request ======================================================*/

  Future manageForumRequestCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .put(manageForumRequestEndpoint, data: dataBody, skipAuth: false);
      return ManageRequestResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*======================================================================= Get Forum Request Status ======================================================*/

  Future getForumRequestStatusApiCall({required String requestId}) async {
    try {
      final response = await dioClient!
          .get("$getRequestStatusEndpoint/$requestId", skipAuth: false);
      return RequestStatusResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Products in Wishlist  ============================================*/

  Future productsInWishlistApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        wishlistEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return WishlistResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Add to Wishlist  ============================================*/

  Future addProductToWishlistApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        wishlistEndPoint,
        data: queryBody,
        skipAuth: false,
      );
      return AddToWishlistResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Remove from Wishlist  ============================================*/
  Future removeProductFromWishlistApiCall({
    required String productId,
  }) async {
    try {
      final response = await dioClient!
          .delete('$deleteFromWishlistEndPoint/$productId', skipAuth: false);
      return RemoveFromWishlistResponse.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Product Details Data  ============================================*/

  //Terms and Conditions, About Us, Privacy Policy
  Future getListContent({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        listContent,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return ListContentResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Filter Products  ============================================*/

  Future getProductFiltersApi(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        vendorsProductDetailsEndpoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return VendorsProductsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Request Chat History  ============================================*/

  Future getRequestChatHistoryApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getRequestChatHistoryEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return ChatHistoryResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Group Chat History  ============================================*/
  Future getGroupChatHistoryApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getGroupChatHistoryEndpoint,
          queryParameters: queryBody, skipAuth: false);
      return ChatHistoryResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Group Campaign  ============================================*/

  Future getGroupCampaignApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(
          "Group/${queryBody?["_id"]}/campaign",
          queryParameters: queryBody,
          skipAuth: false);
      return GroupCampaignResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Delete Group  ============================================*/

  Future deleteGroupApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .delete("$groupSearchEndpoint${queryBody?["_id"]}", skipAuth: false);
      return ExitDeleteGroupResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Exit Group  ============================================*/

  Future exitGroupApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .patch("$exitGroupEndpoint/${queryBody?["_id"]}", skipAuth: false);
      return ExitDeleteGroupResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Manage Member API Call  ==========================================================*/
  Future manageMemberApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(manageMemberEndpoint,
          data: jsonEncode(dataBody!), skipAuth: false);

      return GroupInfoResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Join Group API Call  ==========================================================*/

  Future joinGroupApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post("$groupJoinEndpoint/${dataBody?["_id"]}", skipAuth: false);
      return JoinPublicGroupResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Update Group API Call  ==========================================================*/
  Future updateGroupApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(updateGroupEndpoint,
          data: jsonEncode(dataBody!), skipAuth: false);

      return GroupInfoResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Report Member API Call  ==========================================================*/

  Future reportMemberApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(ReportUserEndpoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return ReportMemberResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get Order List======================================================*/

  Future getOrderListApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(getOrderListEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return OrderResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Cancel Order Api============================================*/

  Future cancelOrderApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!
          .put(cancelOrder, data: jsonEncode(dataBody!), skipAuth: false);
      return CancelOrderResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== User Review Data  ============================================*/

  Future userReviewApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(userReviewEndPoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return ProductReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== User Product Review ============================================*/

  Future userProductReviewApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        userProductReviewEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return UserProductReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*===================================================================== Contact Us API Call  ==========================================================*/
  Future contactUsApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(contactUsEndpoint, data: jsonEncode(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Profile Faq data ============================================*/

  Future getProfileFaqData() async {
    try {
      final response =
          await dioClient!.get(profileFAQEndpoint, skipAuth: false);
      return ProfileFaqResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Send Campaign Request  ============================================*/

  Future sendCampaignRequestApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient?.post(
        campaignRequestEndpoint,
        data: dataBody,
        skipAuth: false,
      );
      return CampaignRequestDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Campaign Request list  ============================================*/

  Future getCampaignRequestListApiCall() async {
    try {
      final response = await dioClient?.get(
        campaignRequestEndpoint,
        skipAuth: false,
      );
      return CampaignRequestListResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Default  Address ============================================*/

  Future defaultAddressApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .put(addressEndPoint, queryParameters: queryBody, skipAuth: false);

      return DefaultAddressResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Edit Address ============================================*/

  Future editAddressApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.post(
        addressEndPoint,
        data: queryBody,
        skipAuth: false,
      );
      return AddAddressResponceModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Delete Campaign Request ============================================*/

  Future deleteAddressRequestApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!
          .delete("$deleteAddressEndPoint${dataBody?["_id"]}", skipAuth: false);

      return DeleteAddressResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

/*====================================================================== Delete Bank Accounts  ============================================*/

  Future deleteBankAccountsApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.delete(
          "$deleteBankAccountEndPoint${dataBody?["_id"]}",
          skipAuth: false);
      return DeleteBankResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Default Bank Accounts  ============================================*/

  Future defaultBankAccountsApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(
          "$deleteBankAccountEndPoint${dataBody?["_id"]}/default",
          skipAuth: false);

      return DefaultBankResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Edit Campaign Request  ============================================*/

  Future editCampaignRequestApiCall(
      {required Map<String, dynamic>? dataBody, required String? id}) async {
    try {
      final response = await dioClient?.put(
        "$campaignRequestEndpoint/$id",
        data: dataBody,
        skipAuth: false,
      );
      return CampaignRequestDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Delete Campaign Request  ============================================*/
  Future deletePrivateCampaignRequestApiCall({
    required String id,
  }) async {
    try {
      final response = await dioClient!
          .delete('$campaignRequestEndpoint/$id', skipAuth: false);
      return CampaignRequestListResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Get Campaign Request Details ============================================*/

  Future getCampaignRequestDetailsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        "$campaignRequestEndpoint/${queryBody?["_id"]}",
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CampaignRequestDetailsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Delete Card  ============================================*/
  Future deleteCardApiCall({
    required String id,
  }) async {
    try {
      final response =
          await dioClient!.delete('$stripeCards/$id', skipAuth: false);
      return CardDeleteResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Available Coupons  ============================================*/

  Future availableCouponsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(availableCoupons, queryParameters: queryBody, skipAuth: false);
      return AvailableCouponResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
/*====================================================================== Expired Coupons  ============================================*/

  Future expiredCouponsApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(expiredCoupons, queryParameters: queryBody, skipAuth: false);
      return ExpiredCouponResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Apply Coupons  ============================================*/

  Future applyCouponsApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .post(applyCoupons, data: queryBody, skipAuth: false);
      return ApplyCouponResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Can Add Review  ============================================*/

  Future canAddReviewApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        canAddReviewEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CanAddReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== List User Review & Rating ============================================*/

  Future userReviewListApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        userReviewListEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return ReviewRatingResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
  /*====================================================================== Delete Review & Rating ============================================*/

  Future deleteReviewApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient?.delete(
          '$userReviewDeleteEndPoint${dataBody?["_id"]}',
          skipAuth: false);
      return DeleteReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Edit Review & Rating ============================================*/

  Future editReviewApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.put(
          editReviewEndPoint,
          data: queryBody,
          skipAuth: false);
      return EditReviewResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*===================================================================== Social LogIn API Call  ==========================================================*/

  Future socialLogInApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(socialLogInEndPoint, data: jsonEncode(dataBody!));
      print(response);
      return SocialLogInResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
/*====================================================================== Filter Campaign  ============================================*/

  Future getCampaignFiltersApi(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        campaignFilterEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return CampaignFilterResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
  /*====================================================================== Delivery Check request Model ============================================*/

  Future getDeliveryCheckApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient?.get(
        deliveryCheckEndPoint,
        queryParameters: queryBody,
        skipAuth: false,
      );
      return DeliveryCheckResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Can Add Review  ============================================*/

  Future downloadInvoiceApiCall({String? id}) async {
    try {
      final response = await dioClient?.get(
        "$downloadInvoiceEndPoint$id",
        skipAuth: false,
      );
      return DownloadInvoiceResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================getNotificationList======================================================*/

  Future getNotificationApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(usernotificationsEndPoint,
          skipAuth: false, queryParameters: queryBody);
      debugPrint('response is $response');
      return UserNotificationResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================all Read Notification ======================================================*/

  Future allReadNotificationApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.put("$usernotificationsEndPoint",
          skipAuth: false,queryParameters: queryBody);
      debugPrint('response is $response');
      return ReadNotificationResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================all Read Notification ======================================================*/

  Future readSingleNotificationApiCall(String? id) async {
    try {
      final response = await dioClient!.put("$usernotificationsEndPoint/$id",
          skipAuth: false,);
      debugPrint('response is $response');
      return ReadSingleNotificationResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
/*=======================================================================Get Agora Token APi ======================================================*/

  Future getAgoraTokenApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(agoraLiveTokenEndPoint,
        skipAuth: false , queryParameters:queryBody);
      debugPrint('response is $response');
      return AgoraTokenRequestModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Vendor Search  ============================================*/

  Future vendorSearchApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(VendorSearchEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return VendorSearchResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Add Member ============================================*/

  Future addMemberApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(addMemberEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return AddMemberResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get SubCategory List======================================================*/

  Future getSubCategoryApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(productSubCategoriesEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return ProductSubCategoryResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get SubSubCategory List======================================================*/

  Future getSubSubCategoryApiCall({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!.get(productSubSubCategoriesEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return ProductSubSubCategoryResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Post ScheduleLiveBroadCast Data======================================================*/

  Future scheduleLiveBroadCastApiCall({
    required Map<String, dynamic>? dataBody,required String? id,
  }) async {
    try {
      final response = await dioClient!.post(
          "$scheduleCampaignLiveBroadCastEndPoint$id/live",
          data: jsonEncode(dataBody!),
          skipAuth: false);
      return ScheduleLiveBroadCastResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get ScheduleLivebroadCast List======================================================*/

  Future getscheduleLiveApiCall() async {
    try {
      final response = await dioClient!.get(getScheduleLiveBroadCastEndPoint,
          skipAuth: false);
      return GetScheduleLiveBroadCastResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }
/*=======================================================================Edit ScheduleLiveBroadCast Data======================================================*/

  Future editScheduleLiveBroadCastApiCall({
    required Map<String, dynamic>? dataBody,required String? id,
  }) async {
    try {
      final response = await dioClient!.post(
          "$scheduleCampaignLiveBroadCastEndPoint$id/live",
          data: jsonEncode(dataBody!),
          skipAuth: false);
      debugPrint("Response is $response");
      return ScheduleLiveBroadCastResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get Campaign Earning Data======================================================*/

  Future getCampaignsEarningData({required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(userEarningEndPoint, skipAuth: false, queryParameters: queryBody);
      return CampaignEarningResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Get Campaign Earning Data======================================================*/

  Future payOutApi() async {
    try {
      final response = await dioClient!
          .post(payOutEndPoint, skipAuth: false);
      return PayoutResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Message Delievered======================================================*/

  Future messageDelieveredNotificationApi(String id) async {
    try {
      final response = await dioClient!
          .put("$messageDelieverdEndPoint$id/delivered", skipAuth: false);
      return MessageDelieverdNotificationResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Product FAQ Like APi======================================================*/

  Future productFaqLikeApi({required Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(likeProductFaq, data: jsonEncode(dataBody!),skipAuth: false);
      return FAQResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Brand List Details  ============================================*/

  Future getBrandListApiCall() async {
    try {
      final response =
      await dioClient!.get(brandListEndPoint, skipAuth: false);
      return BrandListResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Campaigns Data  ============================================*/

  Future getProductMediaApiCall({
    required Map<String, dynamic>? queryBody,
  }) async {
    try {
      final response = await dioClient!.get(mediaReviewsEndPoint,
          queryParameters: queryBody, skipAuth: false);
      return ProductMediaResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== Product Order CANCEL Api Data  ============================================*/

  Future productCancelOrderApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient?.put(orderCancellationRequestEndPoint,
          data: jsonEncode(dataBody!), skipAuth: false);
      return OrderCancellationRequestResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }


  /*=======================================================================Product Related Review Like and Dislike APi======================================================*/

  Future productReviewLikeApi({required Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(productReviewEndPoint, data: jsonEncode(dataBody!),skipAuth: false);
      return ProductReviewLikeAndDislikeResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================All Categories Data Api======================================================*/

  Future getAllCategoriesDataApiCall() async {
    try {
      final response = await dioClient!.get(allCategoriesEndPoint,
     skipAuth: false);
      return CategoriesDetailResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*=======================================================================Forum Media Api======================================================*/

  Future forumMediaApiCall({
    required Map<String, dynamic>? queryBody,var id
  }) async {
    try {
      final response = await dioClient!.get("Group/${id}/media_link",
          skipAuth: false,queryParameters: queryBody);
      return ForumMediaResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      print('erroorrrr-------->$e');
      print(stackTrace);
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== List Countries ============================================*/

  Future listCountriesApiCall(
      {required Map<String, dynamic>? queryBody}) async {
    try {
      final response = await dioClient!
          .get(getCountriesEndPoint, queryParameters: queryBody, skipAuth: false);
      return CountrySelectionResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

  /*====================================================================== List Countries ============================================*/

  Future getCountryDetailsApiCall(
      {required Map<String, dynamic>? queryBody,required String? id}) async {
    try {
      final response = await dioClient!
          .get("User/country/$id/detail", queryParameters: queryBody, skipAuth: false);
      return CountryDetailResponseModel.fromJson(response) ;
    } catch (e, stackTrace) {
      return Future.error(NetworkExceptions.getDioException(e, stackTrace));
    }
  }

}
