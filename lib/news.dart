import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<Article> news =[];

  Future<void> getNews() async{
    String apikey = "109358310bf14ce5b0ec3cf60aa41a61";
    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apikey}";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsCategory {
  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async {

    String apikey = "109358310bf14ce5b0ec3cf60aa41a61";
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apikey}";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class Article {

  Article({this.title, this.author, this.description, this.urlToImage, this.publishedAt, this.content, this.articleUrl});

  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publishedAt;
  String content;
  String articleUrl;
}