import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet/screens/account/general.dart';
import 'package:wallet/screens/account/network.dart';
import 'package:wallet/screens/auth/auth_page.dart';
import 'package:wallet/screens/shared/neumorphic_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String title = "Account";
  bool testBool = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            NeumorphicCard(
              Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "General",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Currency · Timezone · Language",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GeneralPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Security",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Biometrics · PIN · Backup",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
              () {},
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Notifications",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Transactions · Markets",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
              () {},
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Row(
                children: [
                  Icon(
                    Icons.ads_click,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Network",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mainnet · Ropsten · Rinkeby",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  )
                ],
              ),
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NetworkPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Lock",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", true);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
