import 'package:flutter/material.dart';
import 'test_data.dart';

class WalletCard extends StatelessWidget {
  final String title;
  final String balance;

  WalletCard(this.title, this.balance);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(title),
            subtitle: Text('Balance' + balance),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Expanded(
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cryptoWallets.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new WalletCard(
                    cryptoWallets[index].name, cryptoWallets[index].balance);
              }),
        )
      ],
    );
  }
}
