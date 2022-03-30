import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/stores/error/error_store.dart';
import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../../models/Auth/profile_modal.dart';
import '../../utils/dio/dio_error_util.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;
  bool isFirst = true;
  GetProfileResponseModal? Profile_data;

  static ObservableFuture<GetProfileResponseModal?> emptyPostResponse =
  ObservableFuture.value(null);

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value;
    });
    // checking if user uses app first time
    repository.isFirst.then((value) {
      this.isFirst = value;
    });
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }
  // store variables:-----------------------------------------------------------



  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  late ObservableFuture<LoginModal> loginFuture;

  @observable
  ObservableFuture<GetProfileResponseModal?> fetchPostsFuture =
  ObservableFuture<GetProfileResponseModal?>(emptyPostResponse);

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(
      String email, String password, successCallback, errorCallback) async {
    // final future = _repository.login(email, password);
    //
    // loginFuture = ObservableFuture(future);
    _repository.login(email, password).then((value) async {
      if (value != null) {
        print('isFirst : false');
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        _repository.saveIsFirst(false);
        if (value.user?.authToken != null) {
          print(value.user?.authToken!);
          _repository.saveAuthToken(value.user?.authToken!);
        }
        this.isFirst = false;
        this.success = true;
        successCallback(value);
      } else {
        print('failed to login');
      }
    }, onError: (error) {
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }
  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;
  @action
  Future getProfile() async {
    final future = _repository.getProfile();
    fetchPostsFuture = ObservableFuture(future);

    future.then((profileData) {
      this.Profile_data = profileData;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future logout(successCallback, errorCallback) async {
    // final future = _repository.login(email, password);
    //
    // loginFuture = ObservableFuture(future);
    _repository.logout().then((value) async {
      if (value != null) {
        print('isFirst : false');
        this.isLoggedIn = false;
        this.isFirst = true;
        _repository.saveIsFirst(true);
        _repository.saveIsLoggedIn(false);
        successCallback(value);
      } else {
        this.isLoggedIn = false;
        this.isFirst = true;
        _repository.saveIsFirst(true);
        _repository.saveIsLoggedIn(false);
        print('failed to login');
      }
    }, onError: (error) {
      print(error.toString());
      this.isLoggedIn = false;
      this.isFirst = true;
      _repository.saveIsFirst(true);
      _repository.saveIsLoggedIn(false);
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }






  @action
  Future signUp(
      SignUpRequestModal signUpData, successCallback, errorCallback) async {
    _repository.signUp(signUpData).then(
      (value) async {
        if (value != null) {
          print('isFirst : false');
          _repository.saveIsLoggedIn(true);
          this.isLoggedIn = true;
          _repository.saveIsFirst(false);
          if (value.data?.user?.authToken != null) {
            _repository.saveAuthToken(value.data?.user?.authToken!);
          }
          this.isFirst = false;
          this.success = true;
          successCallback(value);
        } else {
          print('failed to login');
        }
      },
      onError: (exception) {
        print('onError : exception');
        errorCallback(exception.response);
        //Handle exception message
        if (exception.message != null) {
          print(exception
              .message); // Here you get : "Connection  Timeout Exception" or even handled 500 errors on your backend.
        }
      },
    ).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      return e;
    });
  }











  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}
