import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Auth/logoutModal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/Auth/valid_otp.dart';
import 'package:guilt_app/models/post/post_list.dart';
import 'package:guilt_app/stores/user/user_store.dart';

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
  Future login(email, pass) async {
    try {
      final res = await _dioClient
          .post(Endpoints.login, data: {"username": email, "password": pass});
      return LoginModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// Login POST API
  Future logout() async {
    try {
      final res = await _dioClient.post(Endpoints.logout);
      return LogOutModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


  // Send Otp

  Future Send_Otp(email) async {
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


  Future Valid_Otp(email, otp) async {
    try {
      final res = await _dioClient
          .post(Endpoints.validOtp, data: {"email_phone": email, "otp": otp});
      return Valid_Otp_Model.fromJson(res);
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
