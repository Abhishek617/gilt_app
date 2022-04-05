import 'dart:async';

import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/post/post_list.dart';
import 'package:guilt_app/ui/login/login.dart';

class EventApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  EventApi(this._dioClient, this._restClient);

  Future<Object> signup(Map<String, String> signUpData) async {
    try {
      final res = await _dioClient.post(Endpoints.register, data: {
          'files': {
            'value': "fs.createReadStream('/C:/Users/Asus/Downloads/phpdots/th.jpg')",
            'options': {
              'filename': '',
              'contentType': null
            }
          },
          'name': 'engagement',
          'category': 'celebration',
          'location': '36 Guild Street London, UK',
          'startDate': '2022-03-30 06:50:00',
          'endDate': '2022-03-30 09:50:00',
          'description': 'WELCOME ALL',
          'attendees[0][phone]': '86541230',
          'attendees[1][phone]': '1234555552',
          'attendees[0][expense]': '50',
          'attendees[1][expense]': '50',
          'expenseDescription': 'expenseDescription data',
          'lat': '-44.277',
          'long': '73.59'
      });
      return SignUpResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}
