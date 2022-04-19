import 'dart:async';
import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';

import 'package:guilt_app/models/Auth/Update_Profile_Modal.dart';
import 'package:guilt_app/models/Auth/feedback_add_model.dart';
import 'package:guilt_app/models/Auth/changePasswordModal.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/oauth_modal.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/otpvalidatemodel.dart';

import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Auth/logoutModal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/Auth/valid_otp_model.dart';
import 'package:guilt_app/models/PageModals/setting_model.dart';

import '../../../../models/Event/upcoming_past_event_modal.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<GetProfileResponseModal> getProfile(token) async {
    try {
      final res = await _dioClient.post(Endpoints.getProfile,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}));
      return GetProfileResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// Login POST API
  Future<LoginModal> login(email, pass) async {
    try {
      final res = await _dioClient
          .post(Endpoints.login, data: {"username": email, "password": pass});
      return LoginModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

//google login Oauth Api
  Future<OauthModal> oauth(email, firstname, lastname) async {
    try {
      final res = await _dioClient.post(Endpoints.oauth,
          data: {"email": email, "firstName": firstname, "lastName": lastname});
      return OauthModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //get setting
  Future<SettingGetModal> settingGet(token) async {
    try {
      final res = await _dioClient.post(Endpoints.setting,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}));
      return SettingGetModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<SettingGetModal> settingpost(SettingPostModal UpdateSettingData) async {
    try {
      final res = await _dioClient.post(Endpoints.setting, data: {
        "is_push_notification": UpdateSettingData.isPushNotification,
        "is_email_notification": UpdateSettingData.isEmailNotification,
        "is_show_app_icon": UpdateSettingData.isShowAppIcon,
        "is_floating_notification": UpdateSettingData.isFloatingNotification,
        "is_lock_screen_notification": UpdateSettingData.isLockScreenNotification,
        "is_allow_sound": UpdateSettingData.isAllowSound,
        "is_allow_vibration":UpdateSettingData.isAllowVibration,
      });
      return SettingGetModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  // Common Content Get API
  Future getAppContent(type) async {
    try {
      var url = Endpoints.terms_and_conditions;
      switch (type) {
        case 'terms_and_conditions':
          {
            url = Endpoints.terms_and_conditions;
            break;
          }
        case 'faqs':
          {
            url = Endpoints.faqs;
            break;
          }
        case 'privacy_policy':
          {
            url = Endpoints.privacy_policy;
            break;
          }
        case 'app_version':
          {
            url = Endpoints.about_app_version;
            break;
          }
      }
      final res = await _dioClient.get(url);
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future getBusinessPlaces(token) async {
    try {
      return await _dioClient.get(
        Endpoints.getBusinessPlaces,
        queryParameters: {"page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //setting


  Future getBusinessSpaces(token) async {
    try {
      return await _dioClient.get(
        Endpoints.getBusinessSpaces,
        queryParameters: {"page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// Login POST API
  Future<LogOutModal> logout() async {
    try {
      final res = await _dioClient.post(Endpoints.logout);
      return LogOutModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Change Password POST API
  Future<ChangePasswordResponseModal> changePassword(
      oldPassword, newPassword, token) async {
    try {
      final res = await _dioClient.post(Endpoints.changePassword,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}),
          data: {"old_password": oldPassword, "new_password": newPassword});
      return ChangePasswordResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Send Otp

  Future<OtpSendModel> Send_Otp(email) async {
    try {
      final res = await _dioClient
          .post(Endpoints.sendOtp, data: {"email_phone": email});
      return OtpSendModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Valid Otp

  Future<ValidOtpModel> Valid_Otp(email, otp) async {
    try {
      final res = await _dioClient
          .post(Endpoints.validOtp, data: {"email_phone": email, "otp": otp});
      return ValidOtpModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
//otpvalidate
  Future<OtpValidateModel> OtpValidate(email, otp) async {
    try {
      final res = await _dioClient
          .post(Endpoints.OtpValidate, data: {"email_phone": email, "otp": otp});
      return OtpValidateModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  //feedback Add
  Future<Feedback_add_Model> Feedback_add(
      description, eventId, rate, token) async {
    try {
      final res = await _dioClient.post(Endpoints.feedbackadd,
          data: {"description": description, "eventId": eventId, "rate": rate});
      return Feedback_add_Model.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //feedback List

  Future<Feedback_add_Model> Feedback_list(
      description, eventId, rate, token) async {
    try {
      final res = await _dioClient.post(Endpoints.feedbacklist,
          data: {"description": description, "eventId": eventId, "rate": rate});
      return Feedback_add_Model.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //UpcomingPastEvent
  Future<UpcomingPastEventModal> getUpcomingPastEventList(
      filterby, page, size, token) async {
    try {
      final res = await _dioClient.post(Endpoints.upcomingPast,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}),
          data: {"Filterby": filterby, "page": page, "size": size});
      return UpcomingPastEventModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UpdateProfileResponseModal> updateprofile(UpdateProfileRequestModal UpdateProfileData) async {
    try {
      final res = await _dioClient.put(Endpoints.updateProfile, data: {
        "email": UpdateProfileData.email,
        "firstname": UpdateProfileData.firstname,
        "lastname": UpdateProfileData.lastname,
        "phone": UpdateProfileData.phone,
        "aboutme": UpdateProfileData.aboutme,
        "address": UpdateProfileData.address,
        "city": UpdateProfileData.city,
        "state": UpdateProfileData.state,
        "country": UpdateProfileData.country,
        "zip": UpdateProfileData.zip,
      });
      return UpdateProfileResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<SignUpResponseModal> signup(SignUpRequestModal signUpData) async {
    try {
      final res = await _dioClient.post(Endpoints.register, data: {
        "firstname": signUpData.firstname,
        "lastname": signUpData.lastname,
        "email": signUpData.email,
        "phone": signUpData.phone,
        "password": signUpData.password,
        "role_id": signUpData.roleId
      });
      return SignUpResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// guilt_app api call with default rest client
//  Future<PostsList> getProfile() {
//
//    return _restClient
//        .get(Endpoints.getProfile)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
