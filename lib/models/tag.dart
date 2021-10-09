import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {

  late int? id;
  late String? name;
  late String? slag;
  late String? taxonomy;

  Tag();

  factory Tag.fromJson(Map<String, dynamic> json) =>_$TagFromJson(json);

  Map toJson() => _$TagToJson(this);

}