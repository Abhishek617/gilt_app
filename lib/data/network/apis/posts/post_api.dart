import 'dart:async';
import 'package:dio/dio.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/network/dio_client.dart';
import 'package:guilt_app/data/network/rest_client.dart';

import 'package:guilt_app/models/Auth/Update_Profile_Modal.dart';
import 'package:guilt_app/models/Auth/feedback_add_model.dart';
import 'package:guilt_app/models/Auth/commonModal.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/oauth_modal.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/otpvalidatemodel.dart';

import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Auth/logoutModal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/Auth/valid_otp_model.dart';
import 'package:guilt_app/models/Event/CreateEventResponseModel.dart';
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/PageModals/Event_View_Model.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/models/PageModals/setting_model.dart';

import '../../../../models/Event/upcoming_past_event_modal.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future getProfile(userId, token) async {
    try {
      var headersData = {'Authorization': 'Bearer ' + token!};
      var reqData = {};
      if (userId == 0) {
        reqData = {};
      } else {
        reqData = {"id": userId};
      }
      final res = await _dioClient.post(Endpoints.getProfile,
          options: Options(headers: headersData), data: reqData);
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// Login POST API
  Future<LoginModal> login(email, pass, fcmToken) async {
    try {
      final res = await _dioClient.post(Endpoints.login,
          data: {"username": email, "password": pass, "fcmToken": fcmToken});
      return LoginModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

//google login Oauth Api
  Future<OauthModal> oauth(email, firstname, lastname, fcmTkn) async {
    try {
      final res = await _dioClient.post(Endpoints.oauth, data: {
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "fcmToken": fcmTkn
      });
      return OauthModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //get setting
  Future<SettingGetModal> settingGet(token) async {
    try {
      final res = await _dioClient.post(Endpoints.setting,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}));
      return SettingGetModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //post setting
  Future<SettingGetModal> settingpost(
      SettingPostModal UpdateSettingData) async {
    try {
      final res = await _dioClient.post(Endpoints.setting, data: {
        "is_push_notification": UpdateSettingData.isPushNotification,
        "is_email_notification": UpdateSettingData.isEmailNotification,
        "is_show_app_icon": UpdateSettingData.isShowAppIcon,
        "is_floating_notification": UpdateSettingData.isFloatingNotification,
        "is_lock_screen_notification":
            UpdateSettingData.isLockScreenNotification,
        "is_allow_sound": UpdateSettingData.isAllowSound,
        "is_allow_vibration": UpdateSettingData.isAllowVibration,
      });
      return SettingGetModal.fromJson(res);
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

  // Get Business Places
  Future getBusinessPlaces(token) async {
    try {
      return await _dioClient.get(
        Endpoints.getBusinessPlaces,
        queryParameters: {"page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get Business Places
  Future uploadChatImage(file, token) async {
    try {
      String fileName = file.path.split('/').last;
      String? mimeType = mime(fileName);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType!.split('/')[1];

      FormData formData = new FormData.fromMap({
        'files': await MultipartFile.fromFile(file.path,
            filename: fileName, contentType: MediaType(mimee, type))
      });
      // FormData data = FormData.fromMap({
      //   "files": await MultipartFile.fromFile(
      //     file.path,
      //     filename: fileName,
      //   ),
      // });
      // var imageData = await MultipartFile.fromFile(image.path,
      //     contentType: new MediaType('image', type));
      // // MultipartFile.fromBytes(image.bytes!, filename: fileName);
      // FormData formData = FormData();
      // formData.files.add(MapEntry('files', imageData));
      return await _dioClient.post(
        Endpoints.uploadChatImage,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'multipart/form-data'
        }),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get Search Event
  Future getSearchEvent(searchQuery, token) async {
    try {
      return await _dioClient.get(
        Endpoints.searchEvent,
        queryParameters: {"search": searchQuery, "page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get Search Event
  Future getMyBookedEvents(token, {page = 0, pageSize = 20}) async {
    try {
      return await _dioClient.get(
        Endpoints.myBookedEvent,
        queryParameters: {"page": page, "size": pageSize},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get Business Spaces
  Future getBusinessSpaces(token) async {
    try {
      return await _dioClient.get(
        Endpoints.getBusinessSpaces,
        queryParameters: {"page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Check Registered Users from Contacts
  Future checkContacts(contacts, token) async {
    try {
      return await _dioClient.post(
        Endpoints.checkContacts,
        data: {"contact": contacts},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

// Login POST API
  Future logout(token) async {
    try {
      return await _dioClient.post(Endpoints.logout,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Change Password POST API
  Future<CommonResponseModal> changePassword(
      oldPassword, newPassword, token) async {
    try {
      final res = await _dioClient.post(Endpoints.changePassword,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}),
          data: {"old_password": oldPassword, "new_password": newPassword});
      return CommonResponseModal.fromJson(res);
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

//otpvalidate
  Future<OtpValidateModel> OtpValidate(email, otp) async {
    try {
      final res = await _dioClient.post(Endpoints.OtpValidate,
          data: {"email_phone": email, "otp": otp});
      return OtpValidateModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //feedback Add
  Future<Feedback_add_Model> Feedback_add(
      description, eventId, rate, token) async {
    try {
      final res = await _dioClient.post(Endpoints.feedbackadd,
          data: {"description": description, "eventId": eventId, "rate": rate});
      return Feedback_add_Model.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

//get event details
  Future getEventDetail(eventId, token) async {
    try {
      return await _dioClient.get(
        Endpoints.eventDetail + '/${eventId}',
        options: Options(headers: {'Authorization': 'Bearer ' + token!}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //notification_list
  Future<NotificationListModal> Notification_list(token) async {
    try {
      final res = await _dioClient.get(
        Endpoints.notificationlist,
        options: Options(headers: {'Authorization': 'Bearer ' + token!}),
      );

      return NotificationListModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //feedback List

  Future<FeedbackListModel> Feedback_list(eventId, token) async {
    try {
      final res = await _dioClient.get(
        Endpoints.feedbacklist,
        queryParameters: {
          "eventId": eventId,
        },
        options: Options(headers: {'Authorization': 'Bearer ' + token!}),
      );

      return FeedbackListModel.fromJson(res);
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
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
          }),
          data: {"Filterby": filterby, "page": page, "size": size});
      return UpcomingPastEventModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UpdateProfileResponseModal> updateprofile(
      UpdateProfileRequestModal UpdateProfileData, token) async {
    try {
      FormData formData = FormData();
      String fileName = UpdateProfileData.files.path.split('/').last;
      String? mimeType = mime(fileName);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType!.split('/')[1];
      UpdateProfileData.files = await MultipartFile.fromFile(UpdateProfileData.files.path,
          filename: fileName, contentType: MediaType(mimee, type));
      //FormData forData = new FormData.fromMap(UpdateProfileData.toJson());

      var form = FormData.fromMap({
        "email": UpdateProfileData.email.toString(),
        "firstname": UpdateProfileData.firstname.toString(),
        "lastname": UpdateProfileData.lastname.toString(),
        "phone": UpdateProfileData.phone.toString(),
        "aboutme": UpdateProfileData.aboutme.toString(),
        "address": UpdateProfileData.address.toString(),
        "city": UpdateProfileData.city.toString(),
        "state": UpdateProfileData.state.toString(),
        "country": UpdateProfileData.country.toString(),
        "zip": UpdateProfileData.zip.toString(),

      });
      formData.fields.addAll(form.fields);

      final res = await _dioClient.put(
        Endpoints.updateProfile,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer ' + token!,
                                 'Content-Type': 'multipart/form-data'
        }),
      );
      return UpdateProfileResponseModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  getEventImages(imageArray, callback) {
    var newImageArray = [];
    imageArray.forEach((imgFile) async{
      String fileName = imgFile.path.split('/').last;
      String? mimeType = mime(fileName);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType!.split('/')[1];
      newImageArray.add(await MultipartFile.fromFile(imgFile.path,
          filename: fileName, contentType: MediaType(mimee, type)));

      if (imageArray.indexOf(imgFile) == (imageArray.length - 1)) {
        callback(newImageArray);
      }
    });
  }

//create event
  Future createEvent(CreateEventRequestModal eventData, token) async {
    try {
      await getEventImages(eventData.files, (newFilesArray) async {
        eventData.files = newFilesArray;
        FormData formData = await new FormData.fromMap(eventData.toJson());
        final res = await _dioClient.post(
          Endpoints.addEvent,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'multipart/form-data'
          }),
        );
        return CreateEventResponseModel.fromJson(res);
      });
    }
       catch (e) {
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
