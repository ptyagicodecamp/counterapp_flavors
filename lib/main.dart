import 'package:counterapp_flavors/app.dart';
import 'package:counterapp_flavors/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig devAppConfig = AppConfig(appName: 'CounterApp Dev', flavor: 'dev');
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
/*
flutter run -t lib/main.dart  --flavor=dev
# Debug signing configuration + dev flavor
flutter run -t lib/main.dart  --debug --flavor=dev
flutter run -t lib/main.dart  --release --flavor=dev
flutter build appbundle -t lib/main.dart  --flavor=dev
flutter build apk -t lib/main.dart  --flavor=dev
*/
