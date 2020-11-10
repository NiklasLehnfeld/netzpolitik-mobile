import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_blog_app_template/models/author.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/models/reply.dart';
import 'package:wordpress_blog_app_template/models/tag.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {

  int id;
  String title;

  @JsonKey(name: 'wps_subtitle')
  String subTitle;

  List<Category> categories;
  List<Tag> tags;

  List<Author> authors;
  List<Reply> replies = [];

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

    try {
      json['imageUrl'] = json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']['source_url'];
    } catch(e) {
      // ignore: empty_catches
    }

    json['summary'] = HtmlUnescape().convert(json['excerpt']['rendered']);
    json['authors'] = json['_embedded']['author'];

    var replies = json['_embedded']['replies'];
    if (replies != null) {
      json['replies'] = replies[0];  //if replies exist - they are nested like: "replies": [[{...},{...}]] 🤦
    } else {
      json['replies'] = [];
    }

    var terms = json['_embedded']['wp:term'];
    var categoriesAndTags = List<List>.from(terms).reduce((value, element) {
      value.addAll(element);
      return value;
    });
    
    json['categories'] = categoriesAndTags.where((element) => element['taxonomy'] == 'category').toList();
    json['tags'] = categoriesAndTags.where((element) => element['taxonomy'] == 'post_tag').toList();

    return _$ArticleFromJson(json);
  }

  Map toJson() => _$ArticleToJson(this);

}