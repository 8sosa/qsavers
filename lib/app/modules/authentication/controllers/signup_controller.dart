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

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantity_savers/app/export.dart';
import 'package:quantity_savers/app/modules/authentication/models/dataModel/social_login_data_model.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/social_login_response_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';


class SignUpController extends GetxController {
  RxBool viewPassword = true.obs;
  RxBool confirmViewPassword = true.obs;
  bool isTermsAccepted = false;
  final Uri _termUrl =
      Uri.parse('https://quantitysavers.com/pages/terms-and-conditions');
  final Uri _privacyUrl =
      Uri.parse('https://quantitysavers.com/pages/privacy-policy');

  var selectedCountry = const Country(
    name: "United Kingdom",
    flag: "🇬🇧",
    code: "GB",
    dialCode: "44",
    minLength: 8,
    maxLength: 15,
    nameTranslations: {},
  );

  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _repository = Get.find<APIRepository>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  LoginDataModel? loginDataModel = LoginDataModel();
  SocialLogInResponseModel socialLogInResponseModel =SocialLogInResponseModel();
  SocialLogInDataModel socialLogInDataModel = SocialLogInDataModel();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void onInit() {
    _localStorage.saveFirstLaunch(true);
    getDataFromLocalStorage();
    super.onInit();
  }

  @override
  void dispose() {
    mobileNumberTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  getDataFromLocalStorage() async {
    loginDataModel = await _localStorage.getSavedLoginData();
  }

  validateData() {
    if (isTermsAccepted) {
      hitSignUpApiCall();
    } else {
      showToast(message: "Accept");
    }
  }

  hitSignUpApiCall() {
    Map<String, dynamic> requestModel = AuthRequestModel.signupRequestModel(
      email: emailTextController.text.trim(),
      contactNumber: int.parse(mobileNumberTextController.text.trim()),
      countryCode: "+${selectedCountry.dialCode}",
      countryName: selectedCountry.name,
      password: passwordTextController.text.trim(),
      name: nameTextController.text.trim(),
      deviceType: _repository.deviceName.toString().toUpperCase(),
      fcmToken:fcmToken==null?"string":fcmToken.toString(),
    );
    _repository.signUpApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {

        loginResponseModel = value;
        await saveDataToLocalStorage(loginResponseModel?.data);
        Get.toNamed(AppRoutes.otpVerificationRoute, arguments: {
          argFromSignUp: true,
          argEmail: emailTextController.text ?? "",
          argFromForgot: false,
          argPhoneNo: mobileNumberTextController.text.trim() ?? "",
          argCountryCode: "+${selectedCountry.dialCode ?? ""}",
          argIsForEmail: true
        });
        update();
      }
    }).onError((error, stackTrace) {
      debugPrint("Error is $error");
      if(error == "This email address already exists. Please try again with gmail login")
        {
          google();
          // showToast(message: error.toString());
        }
      else if(error == "This email address already exists. Please try again with apple login")
        {
          apple();
          // showToast(message: error.toString());
        }
      else
        {
          showToast(message: error.toString());
        }


    });
  }

  saveDataToLocalStorage(LoginDataModel? loginData) async {
    _localStorage.saveRegisterData(loginData);
    _localStorage.saveAuthToken(loginData?.accessToken);
    _localStorage.saveFirstLaunch(false);
    _localStorage.saveType(loginData?.socialType);
  }

  loginAsGuest() {
    // showToast(message: "Logged in as Guest!");
    _localStorage.clearLoginData();
    _localStorage.clearRememberMeData();
    _localStorage.saveFirstLaunch(false);
    Get.offAllNamed(AppRoutes.mainScreenRoute,arguments: {argSkip:true});
  }

  Future<void> launchUrlE(forTerm) async {
    var uri = forTerm ? _termUrl : _privacyUrl;
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> google() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
        Platform.isAndroid?  '285337494679-bk275k8tkfqe288qufe4d14vuvpsi2eu.apps.googleusercontent.com':null,
      scopes: [
        'email',
      ],
    );

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        debugPrint("socialtoken is ${googleSignInAuthentication.idToken}");
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        UserCredential result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        User? user = result.user;
        Map<String, dynamic>? requestModel =
            AuthRequestModel.socialLogInRequestModel(
                socialType: "GOOGLE",
                socialToken: googleSignInAuthentication.idToken,
                countryCode: "",
                name: user?.displayName,
                phoneNo: user!.phoneNumber,
                email: user.email.toString(),
                deviceType: _repository.deviceName.toString().toUpperCase(),
                fcmToken: fcmToken==null?"string":fcmToken.toString());

        hitGoogleLogIn(requestModel);

      } catch (e) {
        showToast(message: e.toString());
      }
    } else {
      debugPrint("nullll----");
    }
  }

  String generateNonce([int length = 32]) {
    final random = Random.secure();
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  void apple() async {
    // final nonce = generateNonce();
    // final hashedNonce = sha256.convert(utf8.encode(nonce)).toString();

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: hashedNonce,
      );

      // debugPrint("credential: $credential");
      //
      // if (credential == null) {
      //   print("Error: Apple ID credential is null");
      //   return;
      // }

      // final oauthCredential = OAuthProvider("apple.com").credential(
      //   idToken: credential.identityToken,
      //   // rawNonce: nonce,
      // );
      //
      // debugPrint("oauthCredential: $oauthCredential");
      //
      // if (oauthCredential == null) {
      //   debugPrint("Error: OAuth credential is null");
      //   return;
      // }
      //
      // final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      //
      // print("userCredential: $userCredential");
      //
      // if (userCredential == null || userCredential.user == null) {
      //   print("Error: User credential is null");
      //   return;
      // }

      // final User user = userCredential.user!;

      Map<String, dynamic>? requestModel = AuthRequestModel.socialLogInRequestModel(
          socialType: "APPLE",
          socialToken: credential.identityToken,
          countryCode: "",
          name:credential.givenName,
          email: credential.email,
          deviceType: _repository.deviceName.toString().toUpperCase(),
          fcmToken: fcmToken==null?"string":fcmToken.toString()
      );

      hitGoogleLogIn(requestModel);

    } catch (e) {
      print("Error during Apple sign-in: $e");
    }
  }


  hitGoogleLogIn(Map<String, dynamic>? requestModel)  {
    _repository.socialLogInApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        socialLogInResponseModel=value;
        loginDataModel=socialLogInResponseModel.data;
        await saveDataToLocalStorage(loginDataModel);
         Get.offAllNamed(AppRoutes.mainScreenRoute);
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
