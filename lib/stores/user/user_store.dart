import 'package:guilt_app/models/Auth/Update_Profile_Modal.dart';
import 'package:guilt_app/models/Auth/login_modal.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/stores/error/error_store.dart';
import 'package:guilt_app/ui/notification/notification.dart';
import 'package:mobx/mobx.dart';
import '../../data/repository.dart';
import '../../models/Auth/profile_modal.dart';
import '../../models/PageModals/setting_model.dart';
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
  String? authToken;
  String? refreshToken;

  @observable
  GetProfileResponseModal? Profile_data;


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

  handleError(error) async {
    if(error.response.statusCode == 401){
      _repository.saveIsLoggedIn(false);
      this.isLoggedIn = false;
      return error;
    }else{
      return error;
    }
  }

  getUserRole() async{
    print(await _repository.userRole);
    return await _repository.userRole;
  }
  getProfileDetails(){
    print(Profile_data);
    return Profile_data;
  }

  @action
  Future getAppContent(type) async {
    return await _repository
        .getAppContent(type)
        .then((contentData) => contentData)
        .catchError((error) => throw error);
  }

  @action
  Future settingGet() async {
    return await _repository
        .settingGet()
        .then((settingData) => settingData)
        .catchError((error) => throw error);
  }
  @action
  Future changePassword(oldPassword,newPassword) async {
    return await _repository
        .changePassword(oldPassword, newPassword)
        .then((contentData) => contentData)
        .catchError((error) => throw error);
  }

  // actions:-------------------------------------------------------------------
  @action
  Future login(
      String email, String password, successCallback, errorCallback) async {
    // final future = _repository.login(email, password);
    //
    // loginFuture = ObservableFuture(future);
    _repository.login(email, password).then((value) async {
      if (value.success == true && value.user != null) {
        print('isFirst : false');
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        _repository.saveIsFirst(false);
        if (value.user?.authToken != null) {
          print(value.user?.authToken!);
          _repository.saveAuthToken(value.user?.authToken!);
          authToken = value.user?.authToken;
        }
        if (value.refreshToken != null) {
          print(value.refreshToken);
          _repository.saveRefreshToken(value.refreshToken);
          refreshToken = value.refreshToken;
        }
        if (value.user?.roleId != null) {
          var role = value.user!.roleId.toString();
          print('roleID : '+ role);
          _repository.saveUserRole(role);
        }
        this.isFirst = false;
        this.success = true;
        getProfile();
        successCallback(value);
      } else {
        successCallback(value);
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

  //SETTING

  Future Feedback_add(
      String description, int eventId, String rate, successCallback, errorCallback) async{
    _repository.Feedback_add(description, eventId, rate).then((value)async{
      if(value != null){
        successCallback(value);
      }else{
        print('failed to Feedback Add');
      }
    }, onError: (error){
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      throw e;
    });

  }

  Future Notification_list(successCallback, errorCallback)
  async{
    _repository.Notification_list().then((value)async{
      if(value != null){
        successCallback(value);
      }else{
        print("Faild to Feedback List");
      }
    }, onError: (error){
      print(error.toString());
      errorCallback(error.respone);
    }).catchError((e){
      print(e);
      throw e;
    });
  }

  Future Feedback_list(int eventId,successCallback, errorCallback) async{
    _repository.Feedback_list(eventId).then((value)async{
      if(value != null){
        successCallback(value);
      }else{
        print("Faild to Feedback List");
      }
    }, onError: (error){
      print(error.toString());
      errorCallback(error.respone);
    }).catchError((e){
      print(e);
      throw e;
    });
  }





  Future Send_Otp(
      String email, successCallback, errorCallback) async {
    // final future = _repository.login(email, password);

    // loginFuture = ObservableFuture(future);
    _repository.Send_Otp(email).then((value) async {
      if (value != null) {
        successCallback(value);
      } else {
        print('failed to Reset Password');
      }
    }, onError: (error) {
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      throw e;
    });
  }
  Future oauth(
      String email, String firstname, String lastname,successCallback, errorCallback) async {
    // final future = _repository.login(email, password);

    // loginFuture = ObservableFuture(future);
    _repository.oauth(email, lastname, firstname ).then((value) async {
      if (value != null) {
        print('isFirst : false');
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        _repository.saveIsFirst(false);
        if (value.data?.user?.authToken != null) {
          print(value.data?.user?.authToken!);
          _repository.saveAuthToken(value.data?.user?.authToken!);
          authToken = value.data?.user?.authToken;
        }
        this.isFirst = false;
        this.success = true;
        getProfile();
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

  Future Valid_Otp(
      String email, String otp,successCallback, errorCallback) async {
    // final future = _repository.login(email, password);

    // loginFuture = ObservableFuture(future);
    _repository.Valid_Otp(email,otp).then((value) async {
      if (value != null) {
        successCallback(value);
      } else {
        print('failed to Reset Password');
      }
    }, onError: (error) {
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  //after signup login
  Future OtpValidate(
      String email, String otp,successCallback, errorCallback) async {
    // final future = _repository.login(email, password);

    // loginFuture = ObservableFuture(future);
    _repository.OtpValidate(email,otp).then((value) async {
      if (value.success == true && value.data.user != null) {
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        _repository.saveIsFirst(false);
        if (value.data?.user?.authToken != null) {
          print(value.data?.user?.authToken!);
          _repository.saveAuthToken(value.data?.user?.authToken!);
          authToken = value.data?.user?.authToken;
        }
        this.isFirst = false;
        this.success = true;
        getProfile();
        successCallback(value);
      } else {
        print('failed to Reset Password');
      }
    }, onError: (error) {
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      throw e;
    });
  }
  @action
  Future getProfile() {
    return _repository.getProfile().then((profileData) {
      Profile_data = GetProfileResponseModal.fromJson(profileData);
      _repository.saveProfileData(Profile_data!);
    }).catchError((error) {
      print(error.toString());
      // errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  Future getUpcomingPastEventList(
      String filterby,int page, int size, successCallback, errorCallback) async {
    // final future = _repository.login(email, password);

    // loginFuture = ObservableFuture(future);
    _repository.getUpcomingPastEventList(filterby, page, size).then((value) async {
      if (value != null) {
        successCallback(value);
      } else {
        print('failed to Reset Password');
      }
    }, onError: (error) {
      print(error.toString());
      errorCallback(error.response);
    }).catchError((e) {
      print(e);
      throw e;
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
  //update setting
  @action
  Future settingpost(
      SettingPostModal UpdateSettingData, successCallback, errorCallback) async {
    _repository.settingpost(UpdateSettingData).then(
          (value) async {
        successCallback(value);
      }
      ,onError: (exception) {
      print('onError : exception');
      errorCallback(exception.response);
      //Handle exception message
      if (exception.message != null) {
        print(exception
            .message); // Here you get : "Connection  Timeout Exception" or even handled 500 errors on your backend.
      }
    },
    );
  }

  @action
  Future updateprofile(
    UpdateProfileRequestModal UpdateProfileData, successCallback, errorCallback) async {
    _repository.updateprofile(UpdateProfileData).then(
            (value) async {
              successCallback(value);

            }
        ,onError: (exception) {
      print('onError : exception');
      errorCallback(exception.response);
      //Handle exception message
      if (exception.message != null) {
        print(exception
            .message); // Here you get : "Connection  Timeout Exception" or even handled 500 errors on your backend.
      }
    },
            );
  }
  @action
  Future signUp(
      SignUpRequestModal signUpData, successCallback, errorCallback) async {
    _repository.signUp(signUpData).then(
      (value) async {
        if (value.success == true && value.data!.user != null) {
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
