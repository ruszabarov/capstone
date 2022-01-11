import 'package:cloud_firestore/cloud_firestore.dart';

fetchUser(String userId) async {
  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc(userId).get();
  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    return data;
  }

  return {};
}

addAddress(String userId, nickname) async {
  //! Add address to blockchain

  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc(userId).get();
  List<dynamic> accounts = [];

  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data();
    accounts = data!['accounts'];
    accounts.add({'address': '0x38953792983228592', 'nickname': nickname});
    collection.doc(userId).update({'accounts': accounts});
  }
}

// {accounts: [{address: 0x38953792983228592, nickname: Main Account}, {address: 0x2378429832295292, nickname: Second Account}]}
