
import 'package:flutter/material.dart';
import 'package:news_app_flutter/news.dart';
import 'package:news_app_flutter/news_tile.dart';


class Category_News extends StatefulWidget {
  Category_News({this.newsCategory});
  final String newsCategory;

  @override
  _Category_NewsState createState() => _Category_NewsState();
}

class _Category_NewsState extends State<Category_News> {

  List<Article> articles = new List<Article>();
  var newslist;
  bool _loading = true;


  @override
  void initState() {
    getCategoryNews();
    // TODO: implement initState
    super.initState();
  }

  void getCategoryNews() async {
    NewsCategory news = NewsCategory();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Indian",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "Times",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share, color: Colors.black87)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newslist.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsTile(
                    imgUrl: newslist[index].urlToImage ?? "",
                    title: newslist[index].title ?? "",
                    desc: newslist[index].description ?? "",
                    content: newslist[index].content ?? "",
                    posturl: newslist[index].articleUrl ?? "",
                  );
                }),
          ),
        ),
      ),
    );
  }
}
