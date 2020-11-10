import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {

  int id;
  String name;
  String slag;
  String taxonomy;

  Tag();

  factory Tag.fromJson(Map json) =>_$TagFromJson(json);

  Map toJson() => _$TagToJson(this);

}