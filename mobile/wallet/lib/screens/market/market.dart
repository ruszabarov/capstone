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
  List displayedList = [];

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    MarketList marketList = context.read<MarketList>();
    displayedList = marketList.markets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Coin Name",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                        fillColor: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      searchOperation(_controller.text);
                    },
                    child: Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
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
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: displayedList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new MarketCard(index, displayedList.length - 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchOperation(String searchText) {
    List<Market> searchResult = [];
    MarketList marketList = context.read<MarketList>();

    for (int i = 0; i < marketList.markets.length; i++) {
      Market data = marketList.markets[i];
      if (data.name.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult.add(data);
      }
    }

    setState(() {
      displayedList = searchResult;
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
