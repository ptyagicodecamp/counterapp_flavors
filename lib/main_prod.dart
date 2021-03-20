import 'package:counterapp_flavors/app.dart';
import 'package:counterapp_flavors/app_config.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig devAppConfig =
      AppConfig(appName: 'CounterApp Prod', flavor: 'prod');
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}

/*
flutter run -t lib/main_prod.dart  --release --flavor=prod
flutter build appbundle -t lib/main_prod.dart  --flavor=prod
flutter build apk -t lib/main_prod.dart  --flavor=prod
*/
