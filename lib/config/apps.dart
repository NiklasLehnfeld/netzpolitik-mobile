import 'package:netzpolitik_mobile/widgets/custom_views/netzpolitik_title.dart';
import 'package:netzpolitik_mobile/config/app_configuration.dart';
import 'package:netzpolitik_mobile/config/rest_configuration.dart';

enum App { NETZPOLITIK }

extension AppConfigurations on App {
  AppConfiguration get configuration => AppConfiguration(
      name: 'NETZPOLITIK.ORG',
      restConfiguration: RestConfiguration(baseUrl: 'https://netzpolitik.org'),
      title: NetzpolitikTitle()
  );
}