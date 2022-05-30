import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbrowser/model/news.dart';
import 'package:sbrowser/services/api_exception.dart';

class ApiService {
  final client = http.Client();

  Future<NewsModel?> getNews() async {
    final url = Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=e4c70101c3774248b4406d695d1680ff');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        return NewsModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      ApiException.fetchApiException(e);
    }
    return null;
  }
}
