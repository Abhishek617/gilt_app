import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();
    var aToken = sharedPrefHelper.authToken.then((value) => value);

    Future<void> refreshToken() async {
      var refreshToken = await sharedPrefHelper.refreshToken;
      final response =
      await dio.post(Endpoints.refreshToken, data: {'refreshToken': refreshToken});

      if (response.statusCode == 200) {
        aToken = response.data['authToken'];
      }
    }

    Future _retry(RequestOptions requestOptions) async {
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
                return _retry(error.requestOptions);
              print('Unauthenticated, Need to refresh token');
            }
            return errorInterceptorHandler.next(error);
          },
        ),
      );


    return dio;
  }
}
