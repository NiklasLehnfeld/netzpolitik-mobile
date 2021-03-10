const ENABLED_FEATURES = <Feature>[];

enum Feature {
  PUSH_NOTIFICATIONS
}

extension FeatureExt on Feature {

  bool isEnabled() => ENABLED_FEATURES.contains(this);

}
