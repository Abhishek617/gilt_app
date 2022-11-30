import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';

class GlobalStoreHandler {
  static UserStore userStore = userStore = UserStore(getIt<Repository>());
  static PostStore postStore = PostStore(getIt<Repository>());

  static initStores() {
    userStore = UserStore(getIt<Repository>());
    postStore = PostStore(getIt<Repository>());
  }
}
