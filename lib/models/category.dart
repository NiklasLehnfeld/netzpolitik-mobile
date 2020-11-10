import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {

  int id;
  String name;
  String slug;
  String taxonomy;

  Category();

  factory Category.fromJson(Map json) =>_$CategoryFromJson(json);

  Map toJson() => _$CategoryToJson(this);

}