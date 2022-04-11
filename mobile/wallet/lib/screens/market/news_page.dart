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
              return NewsItem(newsList[index], widget.browser);
            }),
          );
  }

  void _loadNewsData() async {
    newsList = [];

    dynamic result = await getMarketNews(widget.query);
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

class NewsItem extends StatefulWidget {
  final NewsArticle article;
  final InAppBrowser browser;
  const NewsItem(this.article, this.browser);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        color: Colors.grey[200],
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
      ),
      onPressed: () async {
        widget.browser.openUrlRequest(
            urlRequest: URLRequest(url: Uri.parse(widget.article.url)),
            options: options);
      },
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.article.source),
              Text(DateFormat('MMM d, yyyy').format(widget.article.date)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(widget.article.title),
        ],
      ),
    );
  }
}
