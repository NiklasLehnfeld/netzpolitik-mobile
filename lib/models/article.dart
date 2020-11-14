import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_blog_app_template/models/author.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/models/reply.dart';
import 'package:wordpress_blog_app_template/models/tag.dart';
import 'package:wordpress_blog_app_template/serialization/reply_deserializer.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {

  int id;
  String title;
  String subTitle;

  List<Category> categories;
  List<Tag> tags;

  List<Author> authors;
  List<Reply> replies = [];

  String content;
  String summary;
  
  String date;
  String modified;

  String imageName;

  @JsonKey(ignore: true)
  DateTime get creationTime => DateTime.parse(date);

  Article();

  factory Article.fromJson(Map json) {
    json['title'] = HtmlUnescape().convert(json['title']['rendered']);
    json['content'] = json['content']['rendered'];
    json['subTitle'] = HtmlUnescape().convert(json['wps_subtitle']);

    try {
      json['imageName'] = json['_embedded']['wp:featuredmedia'][0]['media_details']['file'];
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

}
