import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'api.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);
  final InAppBrowser browser = new InAppBrowser();

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isActive = false;

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
              return NewsItem(newsList[index]);
            }),
          );
  }

  void _loadNewsData() async {
    newsList = [];

    dynamic result = await getMarketNews('ETH');
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

class NewsItem extends StatefulWidget {
  final NewsArticle article;
  const NewsItem(this.article);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isActive = false;

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
        setState(() {
          isActive = !isActive;
        });
        // widget.browser.openUrlRequest(
        //     urlRequest:
        //         URLRequest(url: Uri.parse(newsList[index].url)),
        //     options: options);
      },
      padding: EdgeInsets.all(15),
      child: AnimatedContainer(
        height: isActive ? 118 : 80,
        duration: Duration(milliseconds: 300),
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
            SizedBox(
              height: 15,
            ),
            isActive
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Open in Browser",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Discuss on CryptoPanic",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
