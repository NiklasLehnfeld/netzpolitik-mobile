import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netzpolitik_mobile/models/author.dart';
import 'package:netzpolitik_mobile/models/category.dart';
import 'package:netzpolitik_mobile/models/reply.dart';
import 'package:netzpolitik_mobile/models/tag.dart';
import 'package:netzpolitik_mobile/serialization/reply_deserializer.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {

  int id;
  String title;
  String subTitle;

  String link;

  List<Category> categories;
  List<Tag> tags;

  List<Author> authors;
  List<Reply> replies = [];

  String content;
  String summary;
  
  String date;
  String modified;

  String imageName;
  String imageCaption;
  String imageLicenceCaption;

  @JsonKey(ignore: true)
  DateTime get creationTime => DateTime.parse(date);

  @JsonKey(ignore: true)
  String get summaryWithoutTags => summary.replaceAll(RegExp('<\/?p>'), '');

  Article();

  factory Article.fromJson(Map json) {
    json['title'] = HtmlUnescape().convert(json['title']['rendered']);
    json['content'] = json['content']['rendered'];
    json['subTitle'] = HtmlUnescape().convert(json['wps_subtitle']);

    try {
      json['imageName'] = json['_embedded']['wp:featuredmedia'][0]['media_details']['file'];
      json['imageCaption'] = json['_embedded']['wp:featuredmedia'][0]['caption']['rendered'];
    } catch(e) {
      // ignore: empty_catches
    }

    json['summary'] = HtmlUnescape().convert(json['excerpt']['rendered']);
    json['authors'] = json['_embedded']['author'];

    var terms = json['_embedded']['wp:term'];
    var categoriesAndTags = List<List>.from(terms).reduce((value, element) {
      value.addAll(element);
      return value;
    });
    
    json['categories'] = categoriesAndTags.where((element) => element['taxonomy'] == 'category').toList();
    json['tags'] = categoriesAndTags.where((element) => element['taxonomy'] == 'post_tag').toList();

    var article = _$ArticleFromJson(json);

    var replies = json['_embedded']['replies'];
    if (replies != null) {
      var repliesJson = replies[0];  //if replies exist - they are nested like: "replies": [[{...},{...}]] 🤦
      article.replies = ReplyDeserializer.deserialize(repliesJson);
    } else {
      article.replies = [];
    }
    
    return article;
  }

  Map toJson() => _$ArticleToJson(this);

  factory Article.fromDatabase(Map map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) => result[key] = value);
    result['categories'] = json.decode(map['categories']);
    result['tags'] = json.decode(map['tags']);
    result['authors'] = json.decode(map['authors']);
    result['replies'] = json.decode(map['replies']);
    return _$ArticleFromJson(result);
  }

  Map toDatabaseMap(){
    final map = toJson();
    map['categories'] = json.encode(map['categories']);
    map['tags'] = json.encode(map['tags']);
    map['authors'] = json.encode(map['authors']);
    map['replies'] = json.encode(map['replies']);
    return map;
  }

}
