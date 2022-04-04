import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  int selectedNetwork = 0;

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
                    "Network",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            selectedColor: Colors.grey[200],
                            unselectedColor: Colors.grey[200],
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                          ),
                          value: 0,
                          groupValue: selectedNetwork,
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            "Main Net",
                            style: TextStyle(fontSize: 16),
                          ),
                          onChanged: (int? value) {
                            setState(() {
                              selectedNetwork = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            selectedColor: Colors.grey[200],
                            unselectedColor: Colors.grey[200],
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                          ),
                          value: 1,
                          groupValue: selectedNetwork,
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            "Ropsten",
                            style: TextStyle(fontSize: 16),
                          ),
                          onChanged: (int? value) {
                            setState(() {
                              selectedNetwork = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicRadio(
                          style: NeumorphicRadioStyle(
                            selectedColor: Colors.grey[200],
                            unselectedColor: Colors.grey[200],
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                          ),
                          value: 2,
                          groupValue: selectedNetwork,
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            "Rinkeby",
                            style: TextStyle(fontSize: 16),
                          ),
                          onChanged: (int? value) {
                            setState(() {
                              selectedNetwork = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
