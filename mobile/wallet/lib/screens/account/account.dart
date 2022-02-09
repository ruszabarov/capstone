import 'package:flutter/material.dart';
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
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: card(
                child: Row(
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: card(
                child: Row(
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: card(
                child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
