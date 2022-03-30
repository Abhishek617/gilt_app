import 'dart:io';

import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:guilt_app/stores/user/user_store.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            options.headers['Content-Type']= 'application/json; charset=utf-8';
                 // getting token
            var token = await sharedPrefHelper.authToken;
            print('interceptor_token ' + token.toString());
            if (token != null) {
             await options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }
            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}
