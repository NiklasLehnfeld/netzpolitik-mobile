
import 'package:flutter/cupertino.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';

class AppConfiguration {
  final String name;
  final RestConfiguration restConfiguration ;
  final Widget title;

  const AppConfiguration({@required this.name, @required this.restConfiguration, this.title});
}
