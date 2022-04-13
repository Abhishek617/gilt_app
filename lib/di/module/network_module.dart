import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';

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
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
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
            // getting token
            var token = await sharedPrefHelper.authToken;

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
              options.headers.putIfAbsent(
                  'Cookies', () => 'authorization=Bearer%20$token; Path=/;');
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
          onError: (error, errorInterceptorHandler) {
            print('Interceptor onError:');
            print(error.message);
            if (error.response?.statusCode == 401) {
              print('Unauthenticated, Need to refresh token');
            }
            return errorInterceptorHandler.next(error);
          },
        ),
      );

    return dio;
  }
}
