// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_UserStore.loading'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;

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

  final _$loginFutureAtom = Atom(name: '_UserStore.loginFuture');

  @override
  ObservableFuture<LoginModal> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<LoginModal> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$fetchPostsFutureAtom = Atom(name: '_UserStore.fetchPostsFuture');

  @override
  ObservableFuture<GetProfileResponseModal?> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<GetProfileResponseModal?> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  final _$getAppContentAsyncAction = AsyncAction('_UserStore.getAppContent');

  @override
  Future<dynamic> getAppContent(dynamic type) {
    return _$getAppContentAsyncAction.run(() => super.getAppContent(type));
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

  final _$getProfileAsyncAction = AsyncAction('_UserStore.getProfile');

  @override
  Future<dynamic> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<dynamic> logout(dynamic successCallback, dynamic errorCallback) {
    return _$logoutAsyncAction
        .run(() => super.logout(successCallback, errorCallback));
  }

  final _$signUpAsyncAction = AsyncAction('_UserStore.signUp');

  @override
  Future<dynamic> signUp(SignUpRequestModal signUpData, dynamic successCallback,
      dynamic errorCallback) {
    return _$signUpAsyncAction
        .run(() => super.signUp(signUpData, successCallback, errorCallback));
  }

  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
fetchPostsFuture: ${fetchPostsFuture},
loading: ${loading},
isLoading: ${isLoading}
    ''';
  }
}
