import 'package:json_annotation/json_annotation.dart';

part 'reply.g.dart';

@JsonSerializable()
class Reply {
  int id;
  int parent;

  @JsonKey(name: 'author_name')
  String authorName;

  String date;

  String content;

  Reply();

  factory Reply.fromJson(Map json) {
    json['content'] = json['content']['rendered'];
    return _$ReplyFromJson(json);
  }

  Map toJson() => _$ReplyToJson(this);
}