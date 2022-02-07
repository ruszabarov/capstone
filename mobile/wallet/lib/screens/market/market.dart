import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wallet/providers/Market.dart';
import 'package:wallet/screens/market/api.dart';
import 'market_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<String> displayedList = [];
  bool isSearchActive = false;
  late ScrollController _scrollController;

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    MarketList marketList = context.read<MarketList>();
    displayedList = marketList.markets.keys.toList();
    _scrollController = ScrollController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                              .animate(animation),
                      child: child,
                    );
                  },
                  child: isSearchActive == false
                      ? Container(
                          key: Key("asd"),
                          width: 300,
                          height: 40,
                          child: Text(
                            "Markets",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          key: Key("dsa"),
                          width: 300,
                          height: 40,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: "Search Markets",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.blue,
                            ),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            autofocus: true,
                            onChanged: (text) {
                              searchOperation(text);
                            },
                          ),
                        ),
                ),
                isSearchActive == false
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearchActive = !isSearchActive;
                            //!This is a bug
                            _scrollController.animateTo(1,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.easeOutCubic);
                            _scrollController.animateTo(0,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.easeOutCubic);
                          });
                        },
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearchActive = !isSearchActive;
                            //!This is a bug
                            _scrollController.animateTo(1,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.easeOutCubic);
                            _scrollController.animateTo(0,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.easeOutCubic);
                          });
                        },
                        child: Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      )
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15,
                );
              },
              shrinkWrap: true,
              //Next line doesnt save to git?
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: displayedList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return MarketCard(
                    index, displayedList.length - 1, displayedList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchOperation(String searchText) {
    List<String> searchResult = [];
    MarketList marketList = context.read<MarketList>();

    marketList.markets.keys.forEach((key) {
      if (key.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult.add(key);
      }
    });

    setState(() {
      displayedList = searchResult;
    });

    // FocusManager.instance.primaryFocus?.unfocus();
  }
}
