import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/models/Auth/refresh_token_modal.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    final globalStore = GlobalStoreHandler();
    String? newToken = '';
    var aToken = sharedPrefHelper.authToken.then((value) => value);

    Future<void> refreshToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var refreshToken = prefs.getString(Preferences.refresh_token);
      var fcmToken = prefs.getString(Preferences.fcm_token);
      print('refreshToken');
      print(refreshToken);
      final response = await dio.post(Endpoints.refreshToken,
          data: {'refreshToken': refreshToken, 'fcmToken': fcmToken});
      var refreshResponse = await RefreshTokenModal.fromJson(response.data);
      if (response.statusCode == 200) {
        newToken = refreshResponse.accessToken;
        sharedPrefHelper.saveAuthToken(newToken!);
        sharedPrefHelper.saveRefreshToken(refreshResponse.refreshToken!);
      }else  if (response.statusCode == 400) {


      }
    }

    Future _retry(RequestOptions requestOptions) async {
      requestOptions.headers['Authorization'] = 'Bearer ' + newToken!;
      final options = new Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      );
      return dio.request<dynamic>(requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options);
    }

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
            var refreshToken = await sharedPrefHelper.refreshToken;
            print('refreshToken');
            print(refreshToken);
            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
          onError: (error, errorInterceptorHandler) async {
            print('Interceptor onError:');
            print(error.message);
            RequestOptions origin = error.requestOptions;
            if (error.response?.statusCode == 401) {
              await refreshToken();
              return await _retry(error.requestOptions);
              print('Unauthenticated, Need to refresh token');
            }
    if (error.response?.statusCode == 400) {

    }
            return errorInterceptorHandler.next(error);
          },
        ),
      );

    return dio;
  }
}
