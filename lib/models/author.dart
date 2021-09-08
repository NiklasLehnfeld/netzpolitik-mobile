import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  late int? id;
  late String? name;
  late String? link;
  late String? description;

  Author();

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map toJson() => _$AuthorToJson(this);
}