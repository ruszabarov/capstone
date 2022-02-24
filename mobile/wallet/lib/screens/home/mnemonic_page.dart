import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';

class MnemonicPage extends StatefulWidget {
  const MnemonicPage({Key? key}) : super(key: key);

  @override
  _MnemonicPageState createState() => _MnemonicPageState();
}

class _MnemonicPageState extends State<MnemonicPage> {
  late PageController pageController;
  late PageView pageView;

  final words = [
    "sweet",
    "payment",
    "roof",
    "swap",
    "answer",
    "safe",
    "cheap",
    "ketchup",
    "cancel",
    "okay",
    "settle",
    "grocery",
    "require",
    "lucky",
    "valve",
  ];

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: 0,
    );

    pageView = PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        PageOne(
          () {
            pageController.animateToPage(1,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOutCubic);
          },
        ),
        PageTwo(
          () {
            pageController.animateToPage(2,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOutCubic);
          },
          () {
            pageController.animateToPage(0,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOutCubic);
          },
        ),
        Text("Page 3"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: pageView,
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  final Function proceedFunction;
  final words = [
    "sweet",
    "payment",
    "roof",
    "swap",
    "answer",
    "safe",
    "cheap",
    "ketchup",
    "cancel",
    "okay",
    "settle",
    "grocery",
    "require",
    "lucky",
    "valve",
    "rude",
    "unhappy",
    "assault",
    "ongoing",
    "question",
    "please",
    "link",
  ];

  PageOne(this.proceedFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  depth: 4,
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  "Here is your recovery phrase",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("Write it down on paper. Do not store it online."),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: Neumorphic(
              style: NeumorphicStyle(
                color: Colors.grey[200],
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                depth: -4,
              ),
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 5,
                ),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return Text(
                    words[index],
                    style: TextStyle(fontSize: 18),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: NeumorphicCard(
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("I wrote it down"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Proceed"),
                    ],
                  ),
                  () {
                    proceedFunction();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  final Function proceedFunction;
  final Function returnFunction;

  final words = [
    "sweet",
    "payment",
    "roof",
    "swap",
    "answer",
    "safe",
    "cheap",
    "ketchup",
    "cancel",
    "okay",
    "settle",
    "grocery",
    "require",
    "lucky",
    "valve",
    "rude",
    "unhappy",
    "assault",
    "ongoing",
    "question",
    "please",
    "link",
  ];

  PageTwo(this.proceedFunction, this.returnFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NeumorphicButton(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  depth: 4,
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  returnFunction;
                },
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  "Enter your recovery phrase",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: Neumorphic(
              style: NeumorphicStyle(
                color: Colors.grey[200],
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                depth: -4,
              ),
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                expands: true,
                maxLines: null,
                minLines: null,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: NeumorphicCard(
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Continue"),
                    ],
                  ),
                  () {
                    proceedFunction();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
