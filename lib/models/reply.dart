import 'package:json_annotation/json_annotation.dart';

part 'reply.g.dart';

@JsonSerializable()
class Reply {
  int? id;
  int? parent;

  @JsonKey(name: 'author_name')
  String? authorName;

  String date = '';

  String content = '';

  @JsonKey(ignore: true) //handled on our own
  List<Reply> replies = [];

  Reply();

  factory Reply.fromJson(Map<String, dynamic> json) {
    var isUnwrapped = json['content'] is String;
    if (!isUnwrapped ) {
      json['content'] = json['content']['rendered'];
    } else {
      json['content'] = json['content'];
    }

    return _$ReplyFromJson(json);
  }

  Map toJson() => _$ReplyToJson(this);
}