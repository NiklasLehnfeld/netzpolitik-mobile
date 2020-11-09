
import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/config/rest_configuration.dart';

class AppConfiguration {
  final String name;
  final RestConfiguration restConfiguration ;

  const AppConfiguration({@required this.name, @required this.restConfiguration});
}