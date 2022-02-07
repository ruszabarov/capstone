import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/providers/Account.dart';

class AccountDetailsCard extends StatelessWidget {
  final Account account;
  final Function handleCloseButton;

  const AccountDetailsCard(this.account, this.handleCloseButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${account.name} details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    handleCloseButton();
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                )
              ],
            ),
            Divider(
              thickness: 3,
              height: 40,
              color: Colors.white,
            ),
            Text(
              "Wallet Address",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // width: double.maxFinite,
              height: 50,
              // padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  color: Colors.blue.shade900.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        account.address,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Clipboard.setData(
                          //   ClipboardData(text: cryptoWallet.adress),
                          // ).then((_) => {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text('Address copied'),
                          //         ),
                          //       )
                          //     });
                        },
                        icon: Icon(Icons.copy),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: QrImage(
                  data: account.address,
                  version: QrVersions.auto,
                  size: 200,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
