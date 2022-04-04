import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/screens/load_data.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      color: Colors.grey[200],
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15)),
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
                  Text(
                    "Use Password",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  depth: -4,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    style: TextStyle(
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Password",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: NeumorphicCard(
                      Center(
                        child: Text("Log in"),
                      ),
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoadDataPage(),
                          ),
                        );
                      },
                    )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
