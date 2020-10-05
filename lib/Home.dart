import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/Category_News.dart';
import 'package:news_app_flutter/category_data.dart';
import 'package:news_app_flutter/news.dart';
import 'package:news_app_flutter/news_tile.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news_List;

  List<CategorieModel> categories = List<CategorieModel>();
  bool _loading = true;

  void getNews() async {
    News news = News();
    await news.getNews();
    news_List = news.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Indian',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('Times',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,color: Colors.black87)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[

                //Category
                Container(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index){
                      return CategoryCard(
                        imageUrl: categories [index].imageUrl,
                        categoryName: categories [index].categoryName,
                      );
                    },
                  ),
                ),


                //NewsArtical

                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    itemCount: news_List.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(

                    ),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl: news_List[index].urlToImage ?? "",
                        title: news_List[index].title ?? "",
                        desc: news_List[index].description ?? "",
                        content: news_List[index].content ?? "",
                        posturl: news_List[index].articleUrl ?? "",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategorieModel {
  String imageUrl;
  String categoryName;
}

class CategoryCard extends StatelessWidget {

  CategoryCard({this.imageUrl, this.categoryName});

  final String imageUrl, categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Category_News(
          newsCategory: categoryName.toLowerCase(),
        )));
      },      child: Container(
      margin: EdgeInsets.only(right: 14),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26
            ),
            child: Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

