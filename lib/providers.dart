import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/config/app_configuration.dart';
import 'package:wordpress_blog_app_template/config/apps.dart';
import 'package:wordpress_blog_app_template/config/rest_configuration.dart';
import 'package:wordpress_blog_app_template/logic/AudioPlayer.dart';
import 'package:wordpress_blog_app_template/rest/RestClient.dart';


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

  ];

}