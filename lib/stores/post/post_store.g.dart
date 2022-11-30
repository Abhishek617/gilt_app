// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PostStore.loading'))
      .value;

  final _$fetchPostsFutureAtom = Atom(name: '_PostStore.fetchPostsFuture');

  @override
  ObservableFuture<PostList?> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<PostList?> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  final _$postListAtom = Atom(name: '_PostStore.postList');

  @override
  PostList? get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }

  @override
  set postList(PostList? value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }

  final _$successAtom = Atom(name: '_PostStore.success');

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

  final _$getBusinessPlacesAsyncAction =
      AsyncAction('_PostStore.getBusinessPlaces');

  @override
  Future<dynamic> getBusinessPlaces() {
    return _$getBusinessPlacesAsyncAction.run(() => super.getBusinessPlaces());
  }

  final _$getBusinessSpacesAsyncAction =
      AsyncAction('_PostStore.getBusinessSpaces');

  @override
  Future<dynamic> getBusinessSpaces() {
    return _$getBusinessSpacesAsyncAction.run(() => super.getBusinessSpaces());
  }

  final _$getSearchEventAsyncAction = AsyncAction('_PostStore.getSearchEvent');

  @override
  Future<dynamic> getSearchEvent(dynamic searchQuery) {
    return _$getSearchEventAsyncAction
        .run(() => super.getSearchEvent(searchQuery));
  }

  final _$getMyBusinessListAsyncAction =
      AsyncAction('_PostStore.getMyBusinessList');

  @override
  Future<dynamic> getMyBusinessList(dynamic searchQuery) {
    return _$getMyBusinessListAsyncAction
        .run(() => super.getMyBusinessList(searchQuery));
  }

  final _$getAllBusinessListAsyncAction =
      AsyncAction('_PostStore.getAllBusinessList');

  @override
  Future<dynamic> getAllBusinessList(dynamic searchQuery) {
    return _$getAllBusinessListAsyncAction
        .run(() => super.getAllBusinessList(searchQuery));
  }

  final _$getBusinessByNameListAsyncAction =
      AsyncAction('_PostStore.getBusinessByNameList');

  @override
  Future<dynamic> getBusinessByNameList(dynamic searchQuery) {
    return _$getBusinessByNameListAsyncAction
        .run(() => super.getBusinessByNameList(searchQuery));
  }

  final _$getAllUserListAsyncAction = AsyncAction('_PostStore.getAllUserList');

  @override
  Future<dynamic> getAllUserList(dynamic searchQuery) {
    return _$getAllUserListAsyncAction
        .run(() => super.getAllUserList(searchQuery));
  }

  final _$getBusinessDetailAsyncAction =
      AsyncAction('_PostStore.getBusinessDetail');

  @override
  Future<dynamic> getBusinessDetail(dynamic businessId) {
    return _$getBusinessDetailAsyncAction
        .run(() => super.getBusinessDetail(businessId));
  }

  final _$updateBusinessDetailsAsyncAction =
      AsyncAction('_PostStore.updateBusinessDetails');

  @override
  Future<dynamic> updateBusinessDetails(dynamic searchQuery, dynamic userID) {
    return _$updateBusinessDetailsAsyncAction
        .run(() => super.updateBusinessDetails(searchQuery, userID));
  }

  final _$getAllBusinessByUserListAsyncAction =
      AsyncAction('_PostStore.getAllBusinessByUserList');

  @override
  Future<dynamic> getAllBusinessByUserList(
      dynamic searchQuery, dynamic userID) {
    return _$getAllBusinessByUserListAsyncAction
        .run(() => super.getAllBusinessByUserList(searchQuery, userID));
  }

  final _$payForBusinessAsyncAction = AsyncAction('_PostStore.payForBusiness');

  @override
  Future<dynamic> payForBusiness(dynamic searchQuery) {
    return _$payForBusinessAsyncAction
        .run(() => super.payForBusiness(searchQuery));
  }

  final _$requestForBusinessAsyncAction =
      AsyncAction('_PostStore.requestForBusiness');

  @override
  Future<dynamic> requestForBusiness(dynamic searchQuery) {
    return _$requestForBusinessAsyncAction
        .run(() => super.requestForBusiness(searchQuery));
  }

  final _$deleteBusinessAsyncAction = AsyncAction('_PostStore.deleteBusiness');

  @override
  Future<dynamic> deleteBusiness(dynamic businessId) {
    return _$deleteBusinessAsyncAction
        .run(() => super.deleteBusiness(businessId));
  }

  final _$getUserEventAsyncAction = AsyncAction('_PostStore.getUserEvent');

  @override
  Future<dynamic> getUserEvent(dynamic userID) {
    return _$getUserEventAsyncAction.run(() => super.getUserEvent(userID));
  }

  final _$getMyBookedEventsAsyncAction =
      AsyncAction('_PostStore.getMyBookedEvents');

  @override
  Future<dynamic> getMyBookedEvents() {
    return _$getMyBookedEventsAsyncAction.run(() => super.getMyBookedEvents());
  }

  final _$checkContactsAsyncAction = AsyncAction('_PostStore.checkContacts');

  @override
  Future<dynamic> checkContacts(dynamic contacts) {
    return _$checkContactsAsyncAction.run(() => super.checkContacts(contacts));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
postList: ${postList},
success: ${success},
loading: ${loading}
    ''';
  }
}
