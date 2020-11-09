import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {

  int id;
  String title;
  String content;

  @JsonKey(name: 'author')
  int authorId;
  
  String date;
  String modified;

  Post();

  factory Post.fromJson(Map json) {
    json['title'] = json['title']['rendered'];
    json['content'] = json['content']['rendered'];

    return _$PostFromJson(json);
  }

}