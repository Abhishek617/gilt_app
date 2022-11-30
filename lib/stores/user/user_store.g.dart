// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$isLoggedInAtom = Atom(name: '_UserStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isFirstAtom = Atom(name: '_UserStore.isFirst');

  @override
  bool get isFirst {
    _$isFirstAtom.reportRead();
    return super.isFirst;
  }

  @override
  set isFirst(bool value) {
    _$isFirstAtom.reportWrite(value, super.isFirst, () {
      super.isFirst = value;
    });
  }

  final _$authTokenAtom = Atom(name: '_UserStore.authToken');

  @override
  String? get authToken {
    _$authTokenAtom.reportRead();
    return super.authToken;
  }

  @override
  set authToken(String? value) {
    _$authTokenAtom.reportWrite(value, super.authToken, () {
      super.authToken = value;
    });
  }

  final _$refreshTokenAtom = Atom(name: '_UserStore.refreshToken');

  @override
  String? get refreshToken {
    _$refreshTokenAtom.reportRead();
    return super.refreshToken;
  }

  @override
  set refreshToken(String? value) {
    _$refreshTokenAtom.reportWrite(value, super.refreshToken, () {
      super.refreshToken = value;
    });
  }

  final _$Profile_dataAtom = Atom(name: '_UserStore.Profile_data');

  @override
  GetProfileResponseModal? get Profile_data {
    _$Profile_dataAtom.reportRead();
    return super.Profile_data;
  }

  @override
  set Profile_data(GetProfileResponseModal? value) {
    _$Profile_dataAtom.reportWrite(value, super.Profile_data, () {
      super.Profile_data = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getAppContentAsyncAction = AsyncAction('_UserStore.getAppContent');

  @override
  Future<dynamic> getAppContent(dynamic type) {
    return _$getAppContentAsyncAction.run(() => super.getAppContent(type));
  }

  final _$settingGetAsyncAction = AsyncAction('_UserStore.settingGet');

  @override
  Future<dynamic> settingGet() {
    return _$settingGetAsyncAction.run(() => super.settingGet());
  }

  final _$changePasswordAsyncAction = AsyncAction('_UserStore.changePassword');

  @override
  Future<dynamic> changePassword(dynamic oldPassword, dynamic newPassword) {
    return _$changePasswordAsyncAction
        .run(() => super.changePassword(oldPassword, newPassword));
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password, dynamic successCallback,
      dynamic errorCallback) {
    return _$loginAsyncAction.run(
        () => super.login(email, password, successCallback, errorCallback));
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<dynamic> logout(dynamic successCallback, dynamic errorCallback) {
    return _$logoutAsyncAction
        .run(() => super.logout(successCallback, errorCallback));
  }

  final _$settingpostAsyncAction = AsyncAction('_UserStore.settingpost');

  @override
  Future<dynamic> settingpost(SettingPostModal UpdateSettingData,
      dynamic successCallback, dynamic errorCallback) {
    return _$settingpostAsyncAction.run(() =>
        super.settingpost(UpdateSettingData, successCallback, errorCallback));
  }

  final _$updateprofileAsyncAction = AsyncAction('_UserStore.updateprofile');

  @override
  Future<dynamic> updateprofile(UpdateProfileRequestModal UpdateProfileData,
      dynamic successCallback, dynamic errorCallback) {
    return _$updateprofileAsyncAction.run(() =>
        super.updateprofile(UpdateProfileData, successCallback, errorCallback));
  }

  final _$signUpAsyncAction = AsyncAction('_UserStore.signUp');

  @override
  Future<dynamic> signUp(SignUpRequestModal signUpData, dynamic successCallback,
      dynamic errorCallback) {
    return _$signUpAsyncAction
        .run(() => super.signUp(signUpData, successCallback, errorCallback));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  Future<dynamic> getProfile() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.getProfile');
    try {
      return super.getProfile();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isFirst: ${isFirst},
authToken: ${authToken},
refreshToken: ${refreshToken},
Profile_data: ${Profile_data},
success: ${success}
    ''';
  }
}
