import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/localization/app_localizations.dart';
import 'package:netzpolitik_mobile/providers.dart';
import 'package:netzpolitik_mobile/widgets/home.dart';
import 'package:provider/provider.dart';

import 'persistence/app_settings.dart';


void main() => runApp(WPApp());


class WPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.all,
      builder: (context, child) {

        var appConfig = context.watch<AppConfiguration>();
        var appSettings = context.watch<AppSettings>();
        var fontSize = appSettings.fontSize.toDouble();

        var baseTextStyle = TextStyle();

        return MaterialApp(
          title: appConfig.name,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              hintColor: Colors.grey,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.blue
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                headline1: baseTextStyle.copyWith(fontSize: fontSize + 6, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline2: baseTextStyle.copyWith(fontSize: fontSize + 5, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline3: baseTextStyle.copyWith(fontSize: fontSize + 4, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline4: baseTextStyle.copyWith(fontSize: fontSize + 3, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline5: baseTextStyle.copyWith(fontSize: fontSize + 2, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline6: baseTextStyle.copyWith(fontSize: fontSize + 1, color: context.primaryColor, fontWeight: FontWeight.bold),
                bodyText1: baseTextStyle.copyWith(fontSize: fontSize),
                bodyText2: baseTextStyle.copyWith(fontSize: fontSize - 3),
              )),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Home(),
        );
      },
    );
  }


}
