import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'api.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsArticle> newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return newsList.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemCount: newsList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15,
              );
            },
            itemBuilder: ((context, index) {
              return NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  depth: 4,
                ),
                onPressed: () async {
                  if (!await launch(newsList[index].url,
                      forceWebView: true,
                      enableJavaScript: true)) throw 'Could not launch url';
                },
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(newsList[index].title),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(newsList[index].source),
                        Text(DateFormat('MMM d, yyyy')
                            .format(newsList[index].date)),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
  }

  void _loadNewsData() async {
    newsList = [];

    dynamic result = await getMarketNews('ETH');
    for (int i = 0; i < result['results'].length; i++) {
      newsList.add(NewsArticle(
          result['results'][i]['title'],
          DateTime.parse(result['results'][i]['published_at']),
          result['results'][i]['url'],
          result['results'][i]['source']['title']));
    }

    setState(() {});
  }
}

class NewsArticle {
  final String title;
  final DateTime date;
  final String url;
  final String source;

  NewsArticle(this.title, this.date, this.url, this.source);
}
