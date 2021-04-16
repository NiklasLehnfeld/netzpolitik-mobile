<p>
<a href="https://play.google.com/store/apps/details?id=net.lehnfeld.netzpolitik">
    <img src="https://img.shields.io/badge/GooglePlay-live-blue">
</a>

<a href="https://www.apple.com/de/app-store">
    <img src="https://img.shields.io/badge/AppStore-rejected-red">
</a>

<a href="https://github.com/NiklasLehnfeld/netzpolitik-mobile/actions?query=workflow%3A%22Build+Debug%22">
    <img src="https://github.com/NiklasLehnfeld/netzpolitik-mobile/workflows/Build%20Debug/badge.svg?branch=main">
</a>

<a href="https://github.com/NiklasLehnfeld/netzpolitik-mobile/actions?query=workflow%3A%22Analyze+and+Test%22">
    <img src="https://github.com/NiklasLehnfeld/netzpolitik-mobile/workflows/Analyze%20and%20Test/badge.svg?branch=main">
</a>

<a href="http://hits.dwyl.com/NiklasLehnfeld/netzpolitik-mobile">
    <img src="http://hits.dwyl.com/NiklasLehnfeld/netzpolitik-mobile.svg">
</a>

</p>

# 📚 Netzpolitik Mobile App

This is an unofficial cross-plattform flutter mobile app for reading [Netzpolitik.org](https://netzpolitik.org/) articles.
It is using the open [Wordpress Rest API](https://developer.wordpress.org/rest-api/) of the netzpolitik website.

<br>

## ⭐️ Features

- [x] Reading articles
- [x] Reading comments of an article
- [x] Getting information about the author of an article
- [x] Hearing podcasts

## 📱 Screenshots

Here are some screenshots made on an iPad Pro (9.7 inch). Please note the embedded Audio-Player in the first screenshot.
It is only visible when a podcast is currently playing.

<table>
    <tr>
        <td> <img src="docs/images/screenshot_overview.png" alt="drawing" width="300"/> </td>
        <td> <img src="docs/images/screenshot_article.png" alt="drawing" width="300"/> </td>
        <td> <img src="docs/images/screenshot_replies.png" alt="drawing" width="300"/> </td>
    </tr>
</table>
<br><br>


## 📗 Development Guide

Here you can find all relevant information to configure this project for your own wordpress app.

### 🛠 AppConfiguration

To start configuring your own app just add a new field to the `Apps` enum and to the `_APP_CONFIGS` field in [apps.dart](lib/config/apps.dart).
Fill in all required information, like name and base url.
After that put your just created enum field into the `Provider<App>` in [providers.dart](lib/providers.dart).

### 💾 Serialization

The model serialization is done by the [json_serializable](https://pub.dev/packages/json_serializable) plugin, which uses [json_annotation](https://pub.dev/packages/json_annotation) to generate `{file_name}.g.dart` files, which contains the generated json serialization code.
A detailed how-to for this can be found [here](https://flutter.dev/docs/development/data-and-backend/json)

For a one-time generation of the serialization code run:
```
flutter pub run build_runner build --delete-conflicting-outputs
```

For starting a `watcher` who automatically regenerates the code after saving changes run:
```
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 🇷🇺 Localization

The localization logic is implemented in [app_localizations.dart](lib/localization/app_localizations.dart). 
All the translation are placed in `localizations/{locale-code}.json` files. 

On app start the app will read the file matching the locale of the device (and `de.json` as fallback). To get a translated string for a specific key use:
```
AppLocalizations.of(context).translate('my_awesome_key')
```
or import the [context extensions](lib/extensions/context_ext.dart) and use it like you would in android:
```
context.getString('my_awesome_key')
```

### 🏞 Generate App Icon

The native app icon generation is done by the [flutter_launcher_icons package](https://pub.dev/packages/flutter_launcher_icons) package.
It very simple - Just configure which image to use as the icon in the [pubspec.yaml](pubspec.yaml) under the tag `flutter_icons` and then run:
```
flutter pub get
flutter pub run flutter_launcher_icons:main
```
That's it.

### 👨🏻 Generate App Name

The native display name gneration is done by the [flutter_launcher_name](https://pub.dev/packages/flutter_launcher_name) package.
It is as easy as chaning the icon - Just configure the name in the [pubspec.yaml](pubspec.yaml) under the tag `flutter_launcher_name` and then run:
```
flutter pub get
flutter pub run flutter_launcher_name:main
```
That's it.

### 🚀 CI / CD

The CI is currently realized using [GitHub Actions](https://github.com/features/actions). 
All jobs are defined in [test.yml](.github/workflows/test.yml) and [build_debug.yml](.github/workflows/build_debug.yml).
It is configured like:
    - Static code analysis and all tests are running on each push
    - Android & iOS Debug builds are running on each push on every branch except main 
    
 
