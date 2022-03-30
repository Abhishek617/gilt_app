import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Auth/logoutModal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/post/post_list.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;
  SharedPreferenceHelper? sharedPrefHelper;
  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<GetProfileResponseModal> getProfile() async {
    try {

      var token = await sharedPrefHelper?.authToken;
      final res = await _dioClient.post(
          Endpoints.getProfile, options: Options(headers: {
            'Authorization' : 'Bearer '+ token!
      })
    );
    return GetProfileResponseModal.fromJson(res);
    }

  catch

  (

  e

  ) {
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
    final res = await _dioClient
        .post(Endpoints.logout);
    return LogOutModal.fromJson(res);
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
