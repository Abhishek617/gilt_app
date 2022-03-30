import 'dart:async';

import 'package:guilt_app/data/local/datasources/post/post_datasource.dart';
import 'package:guilt_app/data/network/apis/Auth/auth.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/otp_send.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/models/post/post.dart';
import 'package:guilt_app/models/post/post_list.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
import 'package:sembast/sembast.dart';

import '../models/Auth/otp_send.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource);

  // Post: ---------------------------------------------------------------------
  Future<PostList> getProfile() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getProfile().then((postsList) {
      postsList.posts?.forEach((post) {
        _postDataSource.insert(post);
      });

      return postsList;
    }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<void> saveIsFirst(bool value) => _sharedPrefsHelper.saveIsFirst(value);

  Future<bool> get isFirst => _sharedPrefsHelper.isFirst;

  // Login:---------------------------------------------------------------------
  Future<LoginModal> login(String email, String password) async {
    return await _postApi
        .login(email, password)
        .then((loginData) => loginData)
        .catchError((error) => throw error);
  }


  // OtpSend:---------------------------------------------------------------------

  Future<OtpSendModel> Send_Otp() async {
    return await _postApi
        .Reset_password()
        .then((otpSendData) => otpSendData)
        .catchError((error) => throw error);
  }




// SignUp:---------------------------------------------------------------------
  Future<SignUpResponseModal> signUp(SignUpRequestModal signUpData) async {
    return await _postApi
        .signup(signUpData)
        .then((registerData) => registerData)
        .catchError((error) => throw error);
  }
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  Future<void> saveAuthToken(String? value) =>
      _sharedPrefsHelper.saveAuthToken(value!);

  Future<String?> get authToken => _sharedPrefsHelper.authToken;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
