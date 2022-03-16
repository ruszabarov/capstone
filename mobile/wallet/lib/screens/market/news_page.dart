import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'api.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsPage extends StatefulWidget {
  final String query;

  NewsPage(this.query);
  final InAppBrowser browser = new InAppBrowser();

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsArticle> newsList = [];
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

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
                  widget.browser.openUrlRequest(
                      urlRequest:
                          URLRequest(url: Uri.parse(newsList[index].url)),
                      options: options);
                },
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(newsList[index].source),
                        Text(DateFormat('MMM d, yyyy')
                            .format(newsList[index].date)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(newsList[index].title),
                  ],
                ),
              );
            }),
          );
  }

  void _loadNewsData() async {
    newsList = [];

    dynamic result = await getMarketNews(widget.query);
    for (int i = 0; i < result['results'].length; i++) {
      newsList.add(NewsArticle(
          result['results'][i]['title'],
          DateTime.parse(result['results'][i]['pubDate']),
          result['results'][i]['link'],
          result['results'][i]['source_id']));
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
