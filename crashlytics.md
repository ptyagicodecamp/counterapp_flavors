Title: Integrating Crashlytics in Flutter Apps (Android & iOS)
Date: 03/24/2021
Authors: Priyanka Tyagi
Category: Firebase-Crashlytics
Tags: firebase-crashlytics, cross-platform, Flutter, code-recipes, Android, Android Studio, iOS, development
Summary: Learn to integrate crashlytics from Flutter apps to report crashes in real-time.

![TODO]({attach}../../images/flutter/TODO.jpg)

**Target Audience:** Beginner

**Recipe:** Integrate Firebase Crashlytics from Flutter apps to report crashes in real-time.

---

**Checkout the companion video tutorial:**
<iframe width="560" height="315" src="https://www.youtube.com/embed/TODO" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---

Firebase Crashlytics collects and reports crashes and errors that occured in apps. When app is Crashlytics enabled, it keeps a log of events occurred alongside Dart stacktraces to be reported with crash report. The carsh report is sent when the app opens next time.

# Set-up

## `pubspec.yaml` dependency

Add `TODO` plugin dependency as below:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: "^0.7.0"
  firebase_crashlytics: "^0.4.0+1"

```

Run `flutter pub get` to refresh Flutter packages.

Refer [Flutter Fire](https://firebase.flutter.dev/docs/crashlytics/overview#1-add-dependency) for incorporating null-safety.

--

## Android

`android/build.gradle`
```
dependencies {
  ...
  classpath 'com.google.firebase:firebase-crashlytics-gradle:2.2.0'
}

```

`android/app/build.gradle`
```
apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'

# Crashlytics plugin
apply plugin: 'com.google.firebase.crashlytics'
```

## iOS

1. Open Xcode
2. Targets-> Runner-> Build Settings -> Debug Information Format -> DWARF with dSYM File.
3. Select 'Runner' under 'Targets' and open 'Build Phases' tab.
4. Click on '+' and Choose 'New Run Script Phase'. Add `${PODS_ROOT}/FirebaseCrashlytics/run` in the script box.
5. Add `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}` in 'Input Files' to provide dSYMs files location. 
6. Add `$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)` in 'Input Files' to provide `Info.plist` location.
7. Add one more script by clicking on '+' and choosing 'New Run Script Phase' to upload dSYMs files.
8. Type this in the script box: `${PODS_ROOT}/FirebaseCrashlytics/upload-symbols -gsp ${PROJECT_DIR}/Your_path/GoogleService-Info.plist -p ios ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}`

---

# Integrating Firebase Craslytics 

The crashlytics reports are sent when app is restarted after a crash.

## Importing Pacakge
```
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
```

## Initializing
In day to day development, you may not want to report all crashes to Crashlytics. You can choose to disable reporting to Firebase Crashlytics when your app is in debug mode.

```
import 'package:flutter/foundation.dart' show kDebugMode;

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  //Disable Crashlytics reporting in debug mode.
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  return MyApp(appConfig);
}
```

When testing integrating, you may want to enable the crashlytics reporting like this:
```
await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
```
The above will report crashes during development.

## Forcing a crash
If you don't want to wait for a crash to happen during integration, you can force a crash like this:
```
FirebaseCrashlytics.instance.crash();
```
---

## Reporting User identifiers in Crash Reports
You may want to track down which user is experiecing the crash. An user identifiers  can be reported in the crash reports like this:
```
  FirebaseCrashlytics.instance.setUserIdentifier("counterappDevUser12345");
```

## Handling Flutter Framework Uncaught Errors

You can pass all the uncaught Flutter framework errors to Crashlytics to be included in the crash reports.
```
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
```
Read more about using Firebase Crashlytics [here](https://firebase.flutter.dev/docs/crashlytics/usage).

---

# Viewing Crash Reports

Go to Firebase project console. Expand 'Release and monitor' section in the left navigation panel. Click on 'Crashlytics'.

# Source Code Repo

* Recipe source code for `TODO` class is available [here](https://github.com/ptyagicodecamp/flutter_cookbook/blob/widgets-code/flutter_widgets/lib/todo.dart)


# References
1. [Firebase Crashlytics](https://firebase.flutter.dev/docs/crashlytics/overview)

Happy cooking with Flutter :)

_Liked the article?Liked the article? Let me know with 👏👏👏

Couldn't find a topic of interest? Please leave comments or [email me](mailto:ptyagicodecamp@gmail.com) about topics you would like me to write !
[BTW I love cupcakes and coffee both :)](https://www.paypal.me/pritya)_

Follow me at [Medium](https://medium.com/@ptyagicodecamp)
Follow me at [twitter](https://twitter.com/ptyagi13)
