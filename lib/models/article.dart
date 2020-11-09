import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {

  int id;
  String title;
  @JsonKey(name: 'wps_subtitle')
  String subTitle;
  String content;

  @JsonKey(name: 'author')
  int authorId;
  
  String date;
  String modified;

  String imageUrl;

  Article();

  factory Article.fromJson(Map json) {
    json['title'] = HtmlUnescape().convert(json['title']['rendered']);
    json['content'] = json['content']['rendered'];
    json['imageUrl'] = json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']['source_url'];

    return _$ArticleFromJson(json);
  }

}