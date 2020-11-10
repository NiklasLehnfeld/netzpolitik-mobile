import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  String description;

  String slug;
  String taxonomy;

  int count;

  Category();

  factory Category.fromJson(Map json) {
    if (json['description'] != null) {
      json['description'] = HtmlUnescape().convert(json['description']);
    }
    return _$CategoryFromJson(json);
  }

  Map toJson() => _$CategoryToJson(this);
}
