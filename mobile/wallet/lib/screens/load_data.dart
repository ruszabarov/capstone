import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/logic.dart';
import 'package:wallet/screens/wrapper.dart';
import 'package:web3dart/web3dart.dart';
import 'home/test_data.dart';

class LoadDataPage extends StatefulWidget {
  LoadDataPage({Key? key}) : super(key: key);

  @override
  State<LoadDataPage> createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  Future<String> loadData() async {
    await Future.delayed(Duration(seconds: 1));

    return "Data Loaded";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadData(),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: snapshot.hasData
              ? Wrapper()
              : Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Loading data"),
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
