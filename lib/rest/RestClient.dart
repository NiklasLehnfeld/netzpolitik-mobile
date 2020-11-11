import 'package:wordpress_blog_app_template/config/rest_configuration.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wordpress_blog_app_template/models/category.dart';

const PAGE_SIZE = 10;

class RestClient {

  final RestConfiguration configuration;

  String get baseUrl => '${configuration.baseUrl}/wp-json/wp/v2';
  int get pageSize => PAGE_SIZE;

  RestClient(this.configuration);

  Future<List<Article>> fetchArticles({int page = 1, Category category, String searchTerm}) async {
    var url = '$baseUrl/posts?_embed&page_size=$PAGE_SIZE&page=$page';

    if (category != null) {
      url = '$url&categories=${category.id}';
    }

    if (searchTerm != null) {
      url = '$url&search=$searchTerm';
    }

    var response = await _get(url);

    assert (response is List<dynamic>, 'Error while fetching posts from $url, unexpected response format: $response');
    var articles = (response as List<dynamic>).map((e) => Article.fromJson(e)).toList();

    return articles;
  }

  Future<List<Category>> fetchCategories({int page = 1}) async {
    var url = '$baseUrl/categories?page_size=$PAGE_SIZE&page=$page';
    var response = await _get(url);

    assert (response is List<dynamic>, 'Error while fetching categories from $url, unexpected response format: $response');
    var categories = (response as List<dynamic>).map((e) => Category.fromJson(e)).toList();

    return categories.where((element) => element.count > 0).toList();
  }


  Future<dynamic> _get(String url) async {
    var response = await http.get(url);

    assert (response.statusCode == 200, 'Error while fetching from $url, http code: ${response.statusCode}, error: ${response.body}');

    return json.decode(response.body);
  }



}