import 'package:wordpress_blog_app_template/config/rest_configuration.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RestClient {

  final RestConfiguration configuration;

  String get baseUrl => configuration.baseUrl;

  RestClient(this.configuration);

  Future<List<Article>> fetchArticles() async {
    var url = '$baseUrl/wp-json/wp/v2/posts?_embed';
    var response = await http.get(url);

    assert (response.statusCode == 200, 'Error while fetching posts from $url, http code: ${response.statusCode}, error: ${response.body}');

    var decoded = json.decode(response.body);

    assert (decoded is List<dynamic>, 'Error while fetching posts from $url, unexpected response format: $decoded');
    var articles = (decoded as List<dynamic>).map((e) => Article.fromJson(e)).toList();

    return articles;
  }

}