import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/config/app_configuration.dart';
import 'package:wordpress_blog_app_template/localization/app_localizations.dart';
import 'package:wordpress_blog_app_template/providers.dart';
import 'package:wordpress_blog_app_template/widgets/home.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';


void main() => runApp(WPApp());

const FONT_SIZE_DEFAULT = 16.0;

class WPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.all,
      builder: (context, child) {
        var appConfig = context.watch<AppConfiguration>();

        return MaterialApp(
          title: appConfig.name,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                headline1: TextStyle(fontSize: FONT_SIZE_DEFAULT + 6, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline2: TextStyle(fontSize: FONT_SIZE_DEFAULT + 5, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline3: TextStyle(fontSize: FONT_SIZE_DEFAULT + 4, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline4: TextStyle(fontSize: FONT_SIZE_DEFAULT + 3, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline5: TextStyle(fontSize: FONT_SIZE_DEFAULT + 2, color: context.primaryColor, fontWeight: FontWeight.bold),
                headline6: TextStyle(fontSize: FONT_SIZE_DEFAULT + 1, color: context.primaryColor, fontWeight: FontWeight.bold),
                bodyText1: TextStyle(fontSize: FONT_SIZE_DEFAULT),
                bodyText2: TextStyle(fontSize: FONT_SIZE_DEFAULT - 3),
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
