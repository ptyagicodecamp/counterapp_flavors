Title: Flavoring Flutter Applications (Android & iOS)
Date: 02/21/2021
Authors: ptyagi
Category: publishing-apps
Tags: flavors, publishing, cross-platform, Flutter, code-recipes, Android, Android Studio, iOS, development
Summary: This article describes the process of publishing Flutter applications on Android and iOS platforms in development and production environments.

![TODO]({attach}../../images/flutter/TODO.jpg)

**Target Audience:** Beginner

**Recipe:** Publish Flutter application on Android and iOS platforms for development(dev) and production (prod) environments.

---

**Checkout the companion video tutorial:**
<iframe width="560" height="315" src="https://www.youtube.com/embed/TODO" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

--
In this article, I will give overview of the process of publishing Flutter applications on Android and iOS platforms in multiple environments. In real-world applications development process, there are multiple environments and/or stages an applications is released in. During development stage, you may want to share your app to internal testers with a backend configured for development but not ready for production purpose. If you want to distribute your app to internal testers, you need a `dev` variant for the application.

When you are ready to roll-out the application for public release and have production backend ready, you need a variant of same app which is connected to the production backend. Let's call this variant of app as `prod` flavor.

# Pre-requisites

In this article, I will use default `CounterApp` in two variants or flavors: `dev` for development, and `prod` for production. Let's assume this app uses Firebase for backend. The `dev` flavor/variant of app uses one instance of Firebase project, and `prod` flavor uses different instance of Firebase project.


--
# Android

# Firebase Configuration Files
Firebase configuration files go under in their flavor folders under `android/app/src/`.
* dev flavor: `android/app/src/dev/google-services.json`
* prod flavor: `android/app/src/prod/google-services.json`

# Flavors

Define flavors in `app/build.gradle`.

```
android {


    defaultConfig {
        applicationId "com.pcc.counterapp"
        minSdkVersion 16
        targetSdkVersion 29
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    ...

    flavorDimensions "counterapp"

    productFlavors {
        dev {
            dimension "counterapp"
            applicationIdSuffix ".dev"
            resValue "string", "app_name", "Counter App Dev"
            versionNameSuffix ".dev"
        }
        prod {
            dimension "counterapp"
            applicationIdSuffix ".prod"
            resValue "string", "app_name", "Counter App Prod"
            versionNameSuffix ".prod"
        }
    }
}
```

---
 # iOS

 We need to setup custom schemes at iOS side.

 # Firebase Configuration Files


 # Custom Schemes

[TODO: Add recording of creating dev scheme]

At this point, if you run `flutter run --flavor dev` in CLI, you will see information to complete the custom scheme.
```
The Xcode project defines build configurations: Debug, Release, Profile
Flutter expects a build configuration named Debug-dev or similar.
Open Xcode to fix the problem:
  open ios/Runner.xcworkspace
1. Click on "Runner" in the project navigator.
2. Ensure the Runner PROJECT is selected, not the Runner TARGET.
3. Click the Editor->Add Configuration->Duplicate "Debug" Configuration.

   If this option is disabled, it is likely you have the target selected instead
   of the project; see:
   https://stackoverflow.com/questions/19842746/adding-a-build-configuration-in-xcode

   If you have created a completely custom set of build configurations,
   you can set the FLUTTER_BUILD_MODE=debug
   in the .xcconfig file for that configuration and run from Xcode.

4. If you are not using completely custom build configurations, name the newly created configuration debug.
Could not build the precompiled application for the device.
```




---

# Source Code Repo

* Recipe source code for `TODO` class is available [here]()



# References
1.

Happy cooking with Flutter :)

_Liked the article?Liked the article? Let me know with 👏👏👏

Couldn't find a topic of interest? Please leave comments or [email me](mailto:ptyagicodecamp@gmail.com) about topics you would like me to write !
[BTW I love cupcakes and coffee both :)](https://www.paypal.me/pritya)_

Follow me at [Medium](https://medium.com/@ptyagicodecamp)
Follow me at [twitter](https://twitter.com/ptyagi13)
