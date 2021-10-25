import 'package:flutter/widgets.dart';
import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/config/apps.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';
import 'package:netzpolitik_mobile/logic/audio_player.dart';
import 'package:netzpolitik_mobile/logic/notification_manager.dart';
import 'package:netzpolitik_mobile/persistence/app_settings.dart';
import 'package:netzpolitik_mobile/persistence/article_dao.dart';
import 'package:netzpolitik_mobile/persistence/wp_database.dart';
import 'package:netzpolitik_mobile/rest/rest_client.dart';
import 'package:provider/provider.dart';

import 'logic/rating_manager.dart';


class Providers {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");


  static List<InheritedProvider<dynamic>> get all => [

    //app configurations
    Provider<App>(create: (context) => App.NETZPOLITIK),
    Provider<AppConfiguration>(create: (context) => context.read<App>().configuration, lazy: true),
    Provider<RestConfiguration>(create: (context) => context.read<AppConfiguration>().restConfiguration, lazy: true),

    //singletons
    Provider<RestClient>(create: (context) => RestClient( context.read<RestConfiguration>() ), lazy: true),
    Provider<RatingManager>(create: (context) => RatingManager(),),
    Provider<NotificationManager>(create: (context) => NotificationManager()),

    //logic
    ChangeNotifierProvider<AudioPlayer>(create: (context) => AudioPlayer()),

    //persistence
    Provider<WPDatabase>(create: (context) => WPDatabase()),
    Provider<ArticleDAO>(create: (context) => ArticleDAO(context.read<WPDatabase>()),),

    ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings(),),

  ];

}