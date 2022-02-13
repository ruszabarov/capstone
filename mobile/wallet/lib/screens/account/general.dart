import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                    "General",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Local Currency",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: "USD",
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      underline: Container(
                        height: 0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: Colors.grey[300],
                      onChanged: (String? newValue) {
                        setState(() {});
                      },
                      items: <String>['USD', 'EUR', 'RUB', 'YEN']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Local Timezone",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: "UTC-5",
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      underline: Container(
                        height: 0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: Colors.grey[300],
                      onChanged: (String? newValue) {
                        setState(() {});
                      },
                      items: <String>['UTC-5', 'UTC-4', 'UTC-3', 'UTC-2']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: "English",
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      underline: Container(
                        height: 0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      dropdownColor: Colors.grey[300],
                      onChanged: (String? newValue) {
                        setState(() {});
                      },
                      items: <String>['English', 'Spanish', 'Russian']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
