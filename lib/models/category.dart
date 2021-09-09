import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  late int? id;
  late String? name;
  late String? description;

  late String? slug;
  late String? taxonomy;

  late int? count;

  Category();

  factory Category.fromJson(Map<String, dynamic> json) {
    if (json['description'] != null) {
      json['description'] = HtmlUnescape().convert(json['description']);
    }
    return _$CategoryFromJson(json);
  }

  Map toJson() => _$CategoryToJson(this);
}
