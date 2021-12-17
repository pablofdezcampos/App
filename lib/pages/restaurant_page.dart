import 'package:app/pages/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);
  static const route = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(33, 150, 243, .9)),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('restaurants')
                .snapshots(),
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
        Icons.restaurant_menu_rounded,
        color: Colors.white,
      ),
    ),
    title: Text(
      documentSnapshot['name'],
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
        )),
      ],
    ),
    trailing: const Icon(
      Icons.keyboard_arrow_right_rounded,
      color: Colors.white,
      size: 30,
    ),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RestaurantDetailPage(
                    documentSnapshot: documentSnapshot,
                  )));
    },
  );
}
