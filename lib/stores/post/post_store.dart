import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/models/post/post_list.dart';
import 'package:guilt_app/stores/error/error_store.dart';
import 'package:guilt_app/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<PostList?> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<PostList?> fetchPostsFuture =
      ObservableFuture<PostList?>(emptyPostResponse);

  @observable
  PostList? postList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getProfile() async {
    // final future = _repository.getProfile();
    // fetchPostsFuture = ObservableFuture(future);
    //
    // future.then((postList) {
    //   this.postList = postList;
    // }).catchError((error) {
    //   errorStore.errorMessage = DioErrorUtil.handleError(error);
    // });
  }
  @action
  Future getBusinessPlaces() async {
    return await _repository
        .getBusinessPlaces()
        .then((placeData) => placeData)
        .catchError((error) => throw error);
  }
  @action
  Future getBusinessSpaces() async {
    return await _repository
        .getBusinessSpaces()
        .then((placeData) => placeData)
        .catchError((error) => throw error);
  }

  @action
  Future checkContacts(contacts) async {
    return await _repository
        .checkContacts(contacts)
        .then((contactList) => CheckContactResponse.fromJson(contactList))
        .catchError((error) => throw error);
  }
}
