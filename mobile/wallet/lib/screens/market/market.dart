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

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    MarketList marketList = context.read<MarketList>();
    displayedList = marketList.markets.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Expanded(
                  child: Text(
                    "Markets",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                isSearchActive == false
                    ? GestureDetector(
                        onTap: () {
                          print("hello");
                          setState(() {
                            isSearchActive = !isSearchActive;
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
          Container(
            height: isSearchActive == true ? 100 : 0,
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: Colors.white,
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             controller: _controller,
          //             decoration: InputDecoration(
          //               border: InputBorder.none,
          //               hintText: "Enter Coin Name",
          //               hintStyle: TextStyle(color: Colors.black, fontSize: 16),
          //               fillColor: Colors.blue,
          //             ),
          //           ),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             searchOperation(_controller.text);
          //           },
          //           child: Icon(
          //             Icons.search,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15,
                );
              },
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
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

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
