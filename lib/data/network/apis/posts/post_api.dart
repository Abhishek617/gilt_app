import 'dart:async';

import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
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

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<GetProfileResponseModal> getProfile() async {
    try {
      var res = await _dioClient.post(Endpoints.getProfile);
      res = {
        "success": true,
        "user": {
          "id": 2,
          "firstname": "Nadeem",
          "lastname": "Shaikh",
          "email": "nadeem@phpdots1.com",
          "password": "2a10cCY.fZtsOGh4Hnb3VA9kzu3tN1vpSBuwcVMbE20nQ44LoOju1nGYK",
          "phone": "9558107351",
          "profile": "https://guiltapp.s3.amazonaws.com/profile/1648029611171bird-thumbnail.jpg",
          "aboutme": "about",
          "address": "add",
          "city": "ci",
          "state": "st",
          "country": "c",
          "zip": 12222,
          "role_id": 2,
          "deleted_at": null,
          "isEmailVerified": false,
          "isPhoneVerified": false,
          "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyLCJlbWFpbCI6Im5hZGVlbUBwaHBkb3RzMS5jb20ifSwiaWF0IjoxNjQ4NjIxMDIxLCJleHAiOjE2NDg2MjgyMjF9.oeG4EiZ_D7Q9y08bw35rKt8KrinbcuHgKuhqq5V76u4"
        }
      };
      return GetProfileResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      var res = {
        "success": true,
        "user": {
          "id": 2,
          "firstname": "Nadeem",
          "lastname": "Shaikh",
          "email": "nadeem@phpdots1.com",
          "password": "2a10cCY.fZtsOGh4Hnb3VA9kzu3tN1vpSBuwcVMbE20nQ44LoOju1nGYK",
          "phone": "9558107351",
          "profile": "https://guiltapp.s3.amazonaws.com/profile/1648029611171bird-thumbnail.jpg",
          "aboutme": "about",
          "address": "add",
          "city": "ci",
          "state": "st",
          "country": "c",
          "zip": 12222,
          "role_id": 2,
          "deleted_at": null,
          "isEmailVerified": false,
          "isPhoneVerified": false,
          "auth_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyLCJlbWFpbCI6Im5hZGVlbUBwaHBkb3RzMS5jb20ifSwiaWF0IjoxNjQ4NjIxMDIxLCJleHAiOjE2NDg2MjgyMjF9.oeG4EiZ_D7Q9y08bw35rKt8KrinbcuHgKuhqq5V76u4"
        }
      };
      return GetProfileResponseModal.fromJson(res);
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
