import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../model/Article.dart';

class HomePageService {
  //function to get the sport news from the api
  Future<Response> getTopRatedMovies() async {
    final DateTime now = DateTime.now();
    int today = int.parse(now.toString().split(' ')[0].split('-')[2]);
    String pastMonth = '';
    if (today < 10) {
      pastMonth = '0${(today - 1).toString()}';
    } else {
      pastMonth = (today - 1).toString();
    }
    final res = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=sports&from=2024-$pastMonth-30&sortBy=publishedAt&apiKey=5d36ffa0041c4ad484ccfa4a8f70b2c1"),
    );

    return res;
  }

  List<Article> parseArticles(String responseBody) {
  print(responseBody);
  final parsed = json.decode(responseBody);
  return (parsed['articles'] as List)
      .map<Article>((json) => Article.fromJson(json))
      .where((article) => article.urlToImage != null && article.urlToImage!.isNotEmpty)
      .toList();
}
}
