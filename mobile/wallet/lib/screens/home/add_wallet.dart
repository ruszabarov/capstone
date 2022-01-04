import 'package:flutter/material.dart';

class AddWalletCard extends StatelessWidget {
  final Function handleAddButton;

  const AddWalletCard(this.handleAddButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    );
  }
}
