# wordpress_blog_app_template

📚 A generic flutter app template for wordpress apps using [Wordpress Rest API](https://developer.wordpress.org/rest-api/)

## Serialization

The model serialization is done by the [json_serializable](https://pub.dev/packages/json_serializable) plugin, which uses [json_annotation](https://pub.dev/packages/json_annotation) to generate `{file_name}.g.dart` files, which contains the generated json serialization code.
A detailed how-to for this can be found [here](https://flutter.dev/docs/development/data-and-backend/json)

For a one-time generation of the serialization code run:
```
flutter pub run build_runner build --delete-conflicting-outputs
```

For starting a `watcher` who automatically regenerates the code after saving changes run:
```
flutter pub run build_runner watch --delete-conflicting-outputs
```
