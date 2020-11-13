import 'package:flutter/cupertino.dart';

class RestConfiguration {

  final String baseUrl;

  const RestConfiguration({@required this.baseUrl});

  String get imageBaseUrl => '$baseUrl/wp-upload';

}