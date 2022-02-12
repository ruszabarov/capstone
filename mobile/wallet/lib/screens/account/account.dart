import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wallet/screens/shared/card.dart';

class AccountPage extends StatefulWidget {
  const AccountPage();

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String title = "Account";
  bool testBool = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              Icons.settings_outlined,
              Colors.blueGrey,
              "General",
              "Currency · Timezone · Language",
              Container(),
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Icons.security,
              Colors.blue,
              "Security",
              "Biometrics · PIN · Backup",
              Container(),
            ),
            SizedBox(
              height: 20,
            ),
            NeumorphicCard(
              Icons.notifications,
              Colors.amber,
              "Notifications",
              "Transactions · Markets",
              Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class NeumorphicCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final Widget page;

  const NeumorphicCard(
      this.icon, this.iconColor, this.title, this.description, this.page);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        color: Colors.grey[200],
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
      ),
      padding: EdgeInsets.all(20),
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.iconColor,
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
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.description,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
