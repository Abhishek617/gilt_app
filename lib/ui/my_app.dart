import 'package:get/get.dart';
import 'package:guilt_app/constants/app_theme.dart';
import 'package:guilt_app/constants/strings.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/ui/Business/business_list.dart';
import 'package:guilt_app/ui/Intro_screens/intro_screen.dart';
import 'package:guilt_app/ui/Profile/full_profile.dart';
import 'package:guilt_app/ui/Profile/main_profile.dart';
import 'package:guilt_app/ui/common/about_screen.dart';
import 'package:guilt_app/ui/common/before_login_Screen.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/common/privacy_policy.dart';
import 'package:guilt_app/ui/common/success_message.dart';
import 'package:guilt_app/ui/common/terms_conditions.dart';
import 'package:guilt_app/ui/forgot_reset_password/change_password.dart';
import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
import 'package:guilt_app/ui/login/welcome_login.dart';
import 'package:guilt_app/ui/signUp/signUp.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/stores/language/language_store.dart';
import 'package:guilt_app/stores/post/post_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/ui/home/home.dart';
import 'package:guilt_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'Business/add_business.dart';
import 'login/login.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: _themeStore.darkMode ? themeDataDark : themeData,
              routes: Routes.routes,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                  .map((language) => Locale(language.locale!, language.code))
                  .toList(),
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
              ],
              home:(_userStore.isFirst ? OnBoardingPage(): (_userStore.isLoggedIn ? MainProfile() : WelcomeLogin())),
              // home:(_userStore.isFirst ? Login() : (_userStore.isLoggedIn ? SignUp() : WelcomeLogin())),
            ),
          );
        },
      ),
    );
  }
}