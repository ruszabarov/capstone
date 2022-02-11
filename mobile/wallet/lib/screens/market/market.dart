import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    _scrollController = ScrollController();
    setState(() {
      displayedList = marketList.markets.keys.toList();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
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
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
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
                          width: 250,
                          child: Text(
                            "Markets",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          key: Key("asdads"),
                          width: 250,
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
                NeumorphicButton(
                  onPressed: () {
                    setState(() {
                      isSearchActive = !isSearchActive;
                    });
                  },
                  style: NeumorphicStyle(
                    color: Colors.grey[200],
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                    depth: isSearchActive ? -4 : 8,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
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
  }
}

/*
child: isSearchActive
                        ? TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: "Search...",
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
                          )
                        : Text(
                            "Markets",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
 */

/*
Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(-1, 0), end: Offset(0, 0))
                            .animate(animation),
                        child: child,
                      );
                    },
                    child: Text(
                      "Markets",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(animation),
                      child: child,
                    );
                  },
                  child: isSearchActive
                      ? GestureDetector(
                          key: Key("asd"),
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
                            Icons.chevron_right_rounded,
                            size: 45,
                          ),
                        )
                      : GestureDetector(
                          key: Key("dsa"),
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
                            size: 45,
                          ),
                        ),
                ),
              ],
            ),
          ),
 */
