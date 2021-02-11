import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/config/apps.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';
import 'package:netzpolitik_mobile/logic/audio_player.dart';
import 'package:netzpolitik_mobile/rest/rest_client.dart';
import 'package:netzpolitik_mobile/utils/push_notifications.dart';
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

    //push-notifications
    Provider<PushNotificationsManager>(create: (context) => PushNotificationsManager())

  ];

}