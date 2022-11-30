import 'dart:async';

import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/post/post_list.dart';
import 'package:guilt_app/ui/login/login.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AuthApi(this._dioClient, this._restClient);

  /// Returns list of post in response
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

  /// guilt_app api call with default rest client
//  Future<PostsList> getProfile() {
//
//    return _restClient
//        .get(Endpoints.getProfile)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
