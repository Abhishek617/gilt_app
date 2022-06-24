import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
import 'package:guilt_app/models/Business/AddBusinessRequestModel.dart';
import 'package:guilt_app/models/Business/AddBusinessResponseModel.dart';
import 'package:guilt_app/models/Event/CreateEventResponseModel.dart';
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
import 'package:guilt_app/models/Event/accept_reject_event.dart';
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/PageModals/Event_View_Model.dart';
import 'package:guilt_app/models/PageModals/notification_list_model.dart';
import 'package:guilt_app/models/PageModals/push_sub_settings_modal.dart';
import 'package:guilt_app/models/help_support/help_support_master.dart';
import 'package:guilt_app/models/payment/add_card_master.dart';
import 'package:guilt_app/models/payment/add_money_wallet_request.dart';
import 'package:guilt_app/models/payment/pay_to_user_request.dart';
import 'package:guilt_app/models/payment/payment_history_master.dart';
import 'package:guilt_app/models/payment/payment_request.dart';
import 'package:guilt_app/models/payment/wallet_balance_master.dart';
import 'package:guilt_app/ui/feedback/feedback_list_model.dart';
import 'package:guilt_app/models/PageModals/setting_model.dart';
import 'package:guilt_app/utils/encryption/card_encryption.dart';

import '../../../../models/Auth/resend_otp_response.dart';
import '../../../../models/Event/upcoming_past_event_modal.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../../../../models/payment/payment_card_master.dart';
import '../../../../models/success_master.dart';
import 'dart:developer' as de;

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

  //get pushsettings
  Future<PushSettingsModal> pushsettingGet(token) async {
    try {
      final res = await _dioClient.post(Endpoints.pushsubsetting,
          options: Options(headers: {'Authorization': 'Bearer ' + token!}));
      return PushSettingsModal.fromJson(res);
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

  // Get My Business List
  Future getMyBusinessList(searchQuery, token) async {
    try {
      return await _dioClient.get(
        Endpoints.myBusinessList,
        queryParameters: {"search": searchQuery ?? '', "page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get All Business List
  Future getAllBusinessList(searchQuery, token) async {
    try {
      return await _dioClient.get(
        Endpoints.allBusinessList,
        queryParameters: {"search": searchQuery ?? '', "page": 0, "size": 20},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get Business List By Name
  // Get All Business List
  Future getBusinessByNameList(searchQuery, token) async {
    try {
      print("Search query: $searchQuery");
      return await _dioClient.get(
        Endpoints.searchByNameBusinessList,
        queryParameters: {
          "search": searchQuery ?? '',
        },
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future getOwnBusinessList(searchQuery, token) async {
    try {
      print("Search query: $searchQuery");
      return await _dioClient.get(
        Endpoints.searchOwnBusinessList,
        queryParameters: {
          "search": searchQuery ?? '',
        },
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Get All User List
  Future getAllUserList(searchQuery, token) async {
    try {
      return await _dioClient.get(
        Endpoints.searchUser,
        queryParameters: {"search": searchQuery ?? ''},
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //get Business details
  Future getBusinessDetail(businessId, token) async {
    try {
      return await _dioClient.get(
        Endpoints.businessDetail + '/${businessId}',
        options: Options(headers: {'Authorization': 'Bearer ' + token!}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Delete Business
  Future deleteBusiness(bID, token) async {
    try {
      return await _dioClient.delete(
        Endpoints.deleteBusiness + '/${bID}',
        options: Options(headers: {'Authorization': 'Bearer ' + token}),
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Delete Business
  Future deleteEvent(bID, token) async {
    try {
      return await _dioClient
          .put(
        "${Endpoints.cancelEvent}/$bID",
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        print("Cancel event response: ${value.toString()}");
        value = AcceptRejectEvent.fromJson(value);
      });
    } catch (e) {
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

  // Get User Event
  Future getUserEvent(userID, token, {page = 0, pageSize = 20}) async {
    try {
      return await _dioClient.get(
        Endpoints.userEvents,
        queryParameters: {"id": userID, "page": page, "size": pageSize},
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

  // Get Search Event
  Future getMyEvents(token, userId, {page = 0, pageSize = 20}) async {
    try {
      return await _dioClient.get(
        Endpoints.userEvents,
        queryParameters: {"id": userId, "page": page, "size": pageSize},
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

  // Resend Otp

  Future<GetResendOtpaResponse> ReSend_Otp(email, phone) async {
    try {
      final res = await _dioClient
          .post(Endpoints.resendOtp, data: {"email": email, "phone": phone});
      return GetResendOtpaResponse.fromJson(res);
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
    String getParams() {
      var map = new Map<String, dynamic>();
      map['description'] = description;
      map['eventId'] = eventId;
      map['rate'] = rate;
      return json.encode(map);
    }

    try {
      final res = await _dioClient.post(
        Endpoints.feedbackadd,
        data: getParams(),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      );
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
    print("Explore: getUpcomingPastEventList");
    print("filterby: $filterby");

    var params = {
      "filterBy": filterby,
      "page": "0",
      "size": "5",
    };
    try {
      final res = await _dioClient.post(
        Endpoints.upcomingPast,
        data: params,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json; charset=UTF-8'
        }),

        // data: {"filterBy": filterby, "page": page, "size": size}
      );
      print("Response $res");
      print("params: $params");
      return UpcomingPastEventModal.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UpdateProfileResponseModal> updateprofile(
      UpdateProfileRequestModal UpdateProfileData, token) async {
    try {
      if (UpdateProfileData.profile != null) {
        String fileName = UpdateProfileData.profile.path.split('/').last;
        String? mimeType = mime(fileName);
        String mimee = mimeType!.split('/')[0];
        String type = mimeType!.split('/')[1];
        UpdateProfileData.profile = (await MultipartFile.fromFile(
            UpdateProfileData.profile.path,
            filename: fileName,
            contentType: MediaType(mimee, type)));
        //FormData forData = new FormData.fromMap(UpdateProfileData.toJson());
      }

      var form = FormData.fromMap(UpdateProfileData.toJson());
      final res = await _dioClient.put(
        Endpoints.updateProfile,
        data: form,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'multipart/form-data'
        }),
      );
      de.log("Full response: ${jsonEncode(res)}");
      return UpdateProfileResponseModal.fromJson(res);
    } catch (e) {
      print("Error of update profile: ${e.toString()}");
      throw e;
    }
  }

  getEventImages(imageArray, callback) {
    var newImageArray = [];
    imageArray.forEach((imgFile) async {
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
  Future createEvent(
      CreateEventRequestModal eventData, token, successCB, errorCB) async {
    try {
      await getEventImages(eventData.files, (newFilesArray) async {
        eventData.files = newFilesArray;
        FormData formData = await new FormData.fromMap(eventData.toJson());
        await _dioClient
            .post(
          Endpoints.addEvent,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'multipart/form-data'
          }),
        )
            .then((value) {
          value = CreateEventResponseModel.fromJson(value);
          successCB(value);
        });
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

//update event
  Future updateEvent(CreateEventRequestModal eventData, int id, token,
      successCB, errorCB) async {
    try {
      await getEventImages(eventData.files, (newFilesArray) async {
        eventData.files = newFilesArray;
        FormData formData = await new FormData.fromMap(eventData.toJson());
        await _dioClient
            .put(
          "${Endpoints.updateEvent}/$id",
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'multipart/form-data'
          }),
        )
            .then((value) {
          value = CreateEventResponseModel.fromJson(value);
          successCB(value);
        });
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Accept Reject Event
  Future acceptRejectEvent(id, status, token, successCB, errorCB) async {
    String getParams() {
      var map = new Map<String, dynamic>();
      map['status'] = status;
      return json.encode(map);
    }

    try {
      await _dioClient
          .put(
        "${Endpoints.acceptRejectEvent}/$id",
        data: getParams(),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = AcceptRejectEvent.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Cancel Event
  Future cancelEvent(id, token, successCB, errorCB) async {
    try {
      await _dioClient
          .put(
        "${Endpoints.cancelEvent}/$id",
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        print("Cancel event response: ${value.toString()}");
        value = AcceptRejectEvent.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      throw e;
    }
  }

//Add Business
  Future addBusiness(
      AddBusinessRequestModel businessData, token, successCB, errorCB) async {
    try {
      await getEventImages(businessData.files, (newFilesArray) async {
        businessData.files = newFilesArray;
        FormData formData = await new FormData.fromMap(businessData.toJson());
        await _dioClient
            .post(
          Endpoints.addBusiness,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'multipart/form-data'
          }),
        )
            .then((value) {
          value = AddBusinessResponseModel.fromJson(value);
          successCB(value);
        });
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

//Add Business
  Future updateBusiness(AddBusinessRequestModel businessData, int id, token,
      successCB, errorCB) async {
    try {
      await getEventImages(businessData.files, (newFilesArray) async {
        businessData.files = newFilesArray;
        FormData formData = await new FormData.fromMap(businessData.toJson());
        await _dioClient
            .put(
          "${Endpoints.updateBusiness}/$id",
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ' + token!,
            'Content-Type': 'multipart/form-data'
          }),
        )
            .then((value) {
          value = AddBusinessResponseModel.fromJson(value);
          successCB(value);
        });
      });
    } catch (e) {
      errorCB(e);
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

  //Add Payment Request
  Future requestUserForPayment(
      toUserId, businessId, amount, remarks, token, successCB, errorCB) async {
    String getParams() {
      var map = new Map<String, dynamic>();
      map['toUser'] = toUserId;
      map['businessId'] = businessId;
      map['amount'] = amount;
      map['remarks'] = remarks;
      return json.encode(map);
    }

    try {
      await _dioClient
          .post(
        Endpoints.requestPaymentBusiness,
        data: getParams(),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = PaymentMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Pay to user
  Future payToUser(PayToUserRequest payModel, token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        Endpoints.payToUser,
        data: json.encode(payModel.toJson()),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = SuccessMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Pay to event
  Future payToEvent(
      PayToUserRequest payModel, token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        Endpoints.padToEvent,
        data: json.encode(payModel.toJson()),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = SuccessMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Add money to wallet
  Future addMoneyToWallet(
      AddMoneyToWalletRequest payModel, token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        Endpoints.addMoneyToWallet,
        data: json.encode(payModel.toJson()),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = SuccessMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //My wallet balance
  Future myWalletBalance(token, successCB, errorCB) async {
    try {
      await _dioClient
          .get(
        Endpoints.myWalletBalance,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = WalletBalanceMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Credit bank account
  Future creditBankAccount(data, token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        Endpoints.creditBankAccount,
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = SuccessMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Add Payment Request
  Future getSavedCards(token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        Endpoints.savedCardList,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = PaymentCardMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Add Card or Bank account
  Future addCardOrBankAccount(data, token, successCB, errorCB) async {
    String getParams() {
      var map = new Map<String, dynamic>();
      var paymentToken = Map<String, dynamic>();
      paymentToken['iv'] = EncryptionUtils.iv.base16;
      paymentToken['encryptedData'] = EncryptionUtils.encryptData(data);
      map['paymentToken'] = paymentToken;
      // print("Decrypted: ${EncryptionUtils.decryptData(paymentToken['encryptedData'])}");
      return json.encode(map);
    }

    try {
      await _dioClient
          .post(
        Endpoints.addCardOrBank,
        data: getParams(),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = AddPaymentMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Edit Card or Bank account
  Future editCardOrBankAccount(id, data, token, successCB, errorCB) async {
    try {
      await _dioClient
          .put(
        "${Endpoints.editCardOrBank}/$id",
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = AddPaymentMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Payment History
  Future getPaymentHistory(
      int page, int size, token, successCB, errorCB) async {
    try {
      await _dioClient
          .post(
        "${Endpoints.paymentHistory}?page=$page&size=$size",
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = PaymentHistoryResponseModel.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Payment History
  Future removePaymentMethod(id, token, successCB, errorCB) async {
    try {
      await _dioClient
          .delete(
        "${Endpoints.removePaymentMethod}/$id",
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = AddPaymentMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
      print(e.toString());
      throw e;
    }
  }

  //Payment History
  Future helpAndSupport(name, email, message, token, successCB, errorCB) async {
    String getParams() {
      var map = new Map<String, dynamic>();
      map['name'] = name;
      map['email'] = email;
      map['message'] = message;
      return json.encode(map);
    }

    try {
      await _dioClient
          .post(
        "${Endpoints.helpAndSupport}",
        data: getParams(),
        options: Options(headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        }),
      )
          .then((value) {
        value = HelpSupportMaster.fromJson(value);
        successCB(value);
      });
    } catch (e) {
      errorCB(e);
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
