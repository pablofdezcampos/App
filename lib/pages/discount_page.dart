import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({Key? key}) : super(key: key);
  static const route = '/discounts';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(90, 60, 140, .6)),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('discounts').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: (snapshot.data as QuerySnapshot).size,
                itemBuilder: (context, index) => _buildList(
                    context, (snapshot.data! as QuerySnapshot).docs[index]),
              );
            }),
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    leading: Container(
      padding: const EdgeInsets.only(right: 12),
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.white))),
      child: const Icon(
        Icons.price_change_outlined,
        color: Colors.white,
      ),
    ),
    title: Text(
      documentSnapshot['code'],
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Text(
              documentSnapshot['description'],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ),
    onTap: () {
      _deleteDiscount(context, documentSnapshot);
    },
  );
}

void _deleteDiscount(
    BuildContext context, DocumentSnapshot documentSnapshot) async {
  showDialog(
      context: context,
      builder: (contextDialog) => AlertDialog(
            title: const Text('Delete discount?'),
            content:
                const Text('Are you sure you want to delete this discount?'),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(contextDialog),
                  child: const Text('Cancel')),
              FlatButton(
                child: const Text('Accept'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('discounts')
                      .doc(documentSnapshot.id)
                      .delete();
                  Navigator.pop(contextDialog);
                },
              ),
            ],
          ));
}
