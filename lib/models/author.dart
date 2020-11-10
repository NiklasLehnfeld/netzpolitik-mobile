import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  int id;
  String name;
  String link;

  Author();

  factory Author.fromJson(Map json) => _$AuthorFromJson(json);

  Map toJson() => _$AuthorToJson(this);
}