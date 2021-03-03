import 'package:counterapp_flavors/app.dart';
import 'package:counterapp_flavors/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig devAppConfig = AppConfig(appName: 'CounterApp Dev', flavor: 'dev');
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
/*
flutter run -t lib/main_dev.dart  --flavor=dev
flutter run —release -t lib/main_dev.dart  --flavor=dev
flutter build appbundle -t lib/main_dev.dart  --flavor=dev
flutter build apk -t lib/main_dev.dart  --flavor=dev
*/
