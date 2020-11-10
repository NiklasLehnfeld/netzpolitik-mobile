import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_blog_app_template/models/author.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {

  int id;
  String title;

  @JsonKey(name: 'wps_subtitle')
  String subTitle;

  List<Author> author;

  String content;
  String summary;
  
  String date;
  String modified;

  String imageUrl;

  @JsonKey(ignore: true)
  DateTime get creationTime => DateTime.parse(date);

  Article();

  factory Article.fromJson(Map json) {
    json['title'] = HtmlUnescape().convert(json['title']['rendered']);
    json['content'] = json['content']['rendered'];
    json['imageUrl'] = json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']['source_url'];
    json['summary'] = HtmlUnescape().convert(json['excerpt']['rendered']);
    json['author'] = json['_embedded']['author'];

    return _$ArticleFromJson(json);
  }

  Map toJson() => _$ArticleToJson(this);

}