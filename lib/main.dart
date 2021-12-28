import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/localization/app_localizations.dart';
import 'package:netzpolitik_mobile/providers.dart';
import 'package:netzpolitik_mobile/theme/dark_theme.dart';
import 'package:netzpolitik_mobile/theme/light_theme.dart';
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

        return MaterialApp(
          title: appConfig.name,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context, fontSize),
          darkTheme: darkTheme(context, fontSize),
          themeMode: ThemeMode.system,
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
