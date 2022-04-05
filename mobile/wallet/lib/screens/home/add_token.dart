import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/configuration_service.dart';
import 'package:wallet/providers/Account.dart';
import 'package:wallet/screens/shared/shared.dart';
import 'package:provider/provider.dart';

class AddTokenPage extends StatefulWidget {
  const AddTokenPage();

  @override
  State<AddTokenPage> createState() => _AddTokenPageState();
}

class _AddTokenPageState extends State<AddTokenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
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
                      "Add Token",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                "Token name",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Neumorphic(
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
                      hintText: "Ethereum",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Token address",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Neumorphic(
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
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0xC02aaA39b223FE8D0A...",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Number of decimals",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Neumorphic(
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
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "10",
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: NeumorphicCard(
                        Center(
                          child: Text("ADD TOKEN"),
                        ), () async {
                      ConfigurationService configurationService =
                          ConfigurationService(
                              await SharedPreferences.getInstance());

                      await configurationService
                          .getTokens()
                          .then((value) => {print(value[1])});
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
