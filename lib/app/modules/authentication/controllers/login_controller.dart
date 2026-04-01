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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantity_savers/app/core/values/route_arguments.dart';
import 'package:quantity_savers/app/modules/authentication/models/response_model/social_login_response_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../export.dart';

class LoginController extends GetxController {
  bool viewPassword = true;
  bool enableRemember = false;

  RememberMeModel? _rememberMeModel;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _apiRepository = Get.find<APIRepository>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  SocialLogInResponseModel socialLogInResponseModel =
      SocialLogInResponseModel();
  LoginDataModel? loginDataModel = LoginDataModel();
  var deviceToken;
  @override
  void onInit() {
    getRememberMeData();
    super.onInit();
  }

  @override
  void onReady() {
    //TODO Remove this while making build
    emailTextController.text = '';
    passwordTextController.text = '';
    super.onReady();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  /*===================================================================== Login API Call  ==========================================================*/

  hitLoginApiCall() async {
      Map<String, dynamic> requestModel = AuthRequestModel.loginRequestModel(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
          deviceType: _apiRepository.deviceName.toString().toUpperCase(),
          fcmToken: fcmToken == null ? "string" : fcmToken.toString(),
          language: strLanguageEnglish);
      _apiRepository.loginApiCall(dataBody: requestModel).then((value) async {
        if (value != null) {
          loginResponseModel = value;
          showToast(message: "You are logged In!");
          saveDataToLocalStorage(loginResponseModel.data);
          if(loginResponseModel.data?.emailVerified==true)
            {
              Get.offAllNamed(AppRoutes.mainScreenRoute);
            }
          else
            {
              Get.toNamed(AppRoutes.otpVerificationRoute, arguments: {
                argEmail: loginResponseModel.data?.email ?? "",
                argFromForgot: false,
                argLogIn: true,
                argPhoneNo: loginResponseModel.data?.phoneNo.toString() ?? "",
                argCountryCode: "+${loginResponseModel.data?.countryCode.toString() ?? ""}",
                argIsForEmail: true
              });
            }

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


  getRememberMeData() {
    _localStorage.getSaveRememberData().then((value) {
      if (value != null) {
        _rememberMeModel = value;
        emailTextController.text = _rememberMeModel?.email ?? "";
        passwordTextController.text = _rememberMeModel?.password ?? "";
        enableRemember = true;
      }
      update();
    });
  }

/* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginDataModel? loginResponseModel) {
    _localStorage.saveRegisterData(loginResponseModel);
    _localStorage.saveAuthToken(loginResponseModel?.accessToken ?? "");
    _localStorage.saveType(loginResponseModel?.socialType);
    _rememberMeModel = RememberMeModel(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim());
    if (enableRemember == true) {
      _localStorage.saveRememberMeData(_rememberMeModel);
    } else {
      _localStorage.clearRememberMeData();
    }
  }

  loginAsGuest() {
    // showToast(message: "Logged in as Guest!");
/*    _localStorage.clearLoginData();
    _localStorage.clearRememberMeData();*/
    Get.offAllNamed(AppRoutes.mainScreenRoute, arguments: {argSkip: true});
  }

  Future<void> google() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isAndroid
          ? '285337494679-bk275k8tkfqe288qufe4d14vuvpsi2eu.apps.googleusercontent.com'
          : null,
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
                deviceType: _apiRepository.deviceName.toString().toUpperCase(),
                fcmToken: fcmToken == null ? "string" : fcmToken.toString());

        hitGoogleLogIn(requestModel);
      } catch (e) {
        showToast(message: e.toString());
      }
    } else {
      debugPrint("nullll----");
    }
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

      Map<String, dynamic>? requestModel =
          AuthRequestModel.socialLogInRequestModel(
              socialType: "APPLE",
              socialToken: credential.identityToken,
              countryCode: "",
              name: credential.givenName,
              email: credential.email,
              deviceType: _apiRepository.deviceName.toString().toUpperCase(),
              fcmToken: fcmToken == null ? "string" : fcmToken.toString());

      hitGoogleLogIn(requestModel);
    } catch (e) {
      print("Error during Apple sign-in: $e");
    }
  }

  hitGoogleLogIn(Map<String, dynamic>? requestModel) {
    _apiRepository
        .socialLogInApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        socialLogInResponseModel = value;
        loginDataModel = socialLogInResponseModel.data;
        await saveDataToLocalStorage(loginDataModel);
        Get.offAllNamed(AppRoutes.mainScreenRoute);
      }
    }).onError((error, stackTrace) => showToast(message: error.toString()));
  }
}
