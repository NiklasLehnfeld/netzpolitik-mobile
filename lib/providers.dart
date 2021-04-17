import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/config/apps.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';
import 'package:netzpolitik_mobile/logic/audio_player.dart';
import 'package:netzpolitik_mobile/persistence/app_settings.dart';
import 'package:netzpolitik_mobile/persistence/article_dao.dart';
import 'package:netzpolitik_mobile/persistence/wp_database.dart';
import 'package:netzpolitik_mobile/rest/rest_client.dart';
import 'package:provider/provider.dart';


class Providers {

  static List<InheritedProvider<dynamic>> get all => [

    //app configurations
    Provider<App>(create: (context) => App.NETZPOLITIK),
    Provider<AppConfiguration>(create: (context) => context.read<App>().configuration, lazy: true),
    Provider<RestConfiguration>(create: (context) => context.read<AppConfiguration>().restConfiguration, lazy: true),

    //singletons
    Provider<RestClient>(create: (context) => RestClient( context.read<RestConfiguration>() ), lazy: true),

    //logic
    ChangeNotifierProvider<AudioPlayer>(create: (context) => AudioPlayer()),

    //persistence
    Provider<WPDatabase>(create: (context) => WPDatabase()),
    Provider<ArticleDAO>(create: (context) => ArticleDAO(context.read<WPDatabase>()),),

    ChangeNotifierProvider<AppSettings>(create: (context) => AppSettings(),)

  ];

}