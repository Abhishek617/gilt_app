import 'dart:async';
import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
import 'package:guilt_app/models/Auth/changePasswordModal.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Auth/logoutModal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/Auth/valid_otp_model.dart';

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
          options: Options(headers: {'Authorization': 'Bearer ' + token!}),data: {
        "old_password": oldPassword,
        "new_password": newPassword
      });
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
