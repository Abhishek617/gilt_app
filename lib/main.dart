import 'dart:async';
import 'dart:io';
import 'package:guilt_app/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/components/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();


  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
