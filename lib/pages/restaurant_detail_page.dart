import 'package:app/model/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  DocumentSnapshot? documentSnapshot;
  TaskSnapshot? snapshot;
  static const route = '/restaurantsDetail';
  List<Restaurant> restaurantsList = [];

  RestaurantDetailPage({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent(context), bottomContent(context)],
        ),
      ),
    );
  }

  Icon iconReturn(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot['availability'] == true) {
      return const Icon(
        Icons.task_alt_rounded,
        color: Colors.white,
      );
    } else if (documentSnapshot['availability'] == false) {
      return const Icon(
        Icons.cancel,
        color: Colors.white,
      );
    } else {
      throw Exception();
    }
  }

  /*Future<dynamic> _getImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  } */

  Future<String> _getImage(String fileName) {
    return FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
  }

  Stack topContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder(
            future: _getImage(documentSnapshot!['image']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data.toString()),
                          fit: BoxFit.cover)),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 1.2,
                  child: const CircularProgressIndicator(),
                );
              }
              return const Text('ERROR');
            }),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 60, 86, .7)),
          child: Center(
            child: column(context),
          ),
        ),
      ],
    );
  }

  Container bottomContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40),
      child: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: bottomContentTitle(context),
          ),
          bottomContentText(context),
        ],
      )),
    );
  }

  Column column(BuildContext buildContext) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 80),
          const Icon(Icons.restaurant_rounded, color: Colors.white, size: 40.0),
          Container(
              width: 90,
              child: const Divider(
                color: Colors.white,
              )),
          const SizedBox(
            height: 30,
          ),
          Text(documentSnapshot?['name'],
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(flex: 1, child: iconReturn(documentSnapshot!)),
            const Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(('Availability'),
                        style: TextStyle(color: Colors.white, fontSize: 20)))),
          ])
        ]);
  }

  Text bottomContentTitle(BuildContext context) {
    return Text(documentSnapshot?['name'],
        style: const TextStyle(color: Colors.black, fontSize: 30));
  }

  Padding bottomContentText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(documentSnapshot?['description'],
          style: const TextStyle(color: Colors.black, fontSize: 20)),
    );
  }

  Container readButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: TextFormField(
              initialValue: 'saljd',
              decoration: const InputDecoration(hintText: 'Name'),
              enabled: false,
            ),
          ),
        ));
  }
}
