import 'package:dio/dio.dart';
import 'model.dart';

Future<Welcome> getWallStreetNews() async {
  var dio = Dio();
  final result = await dio.get(
      "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=5602b8d1deb54610b7850b791f1300f9");
  if (result.statusCode == 200) {
    return Welcome.fromJson(result.data);
  } else {
    throw Exception("Failed to fetch the news");
  }
}

Future<Welcome> getTechNews() async {
  var dio = Dio();
  final result = await dio.get(
      "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5602b8d1deb54610b7850b791f1300f9");
  if (result.statusCode == 200) {
    return Welcome.fromJson(result.data);
  } else {
    throw Exception("Failed to get the news");
  }
}
