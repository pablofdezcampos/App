import 'package:app/pages/discount_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/pages/restaurant_page.dart';
import 'package:app/pages/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: (snapshot.data as QuerySnapshot).size,
            itemBuilder: (context, index) => _buildDrawer(
                context, (snapshot.data as QuerySnapshot).docs[index]));
      },
    ));
  }
}

Future<String> _getImage(String fileName) {
  return FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
}

Widget _buildDrawer(BuildContext context, DocumentSnapshot documentSnapshot) {
  return Column(
    children: [
      UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colors.blue),
          accountName: Text(documentSnapshot['userName'],
              style: const TextStyle(color: Colors.white)),
          accountEmail: Text(documentSnapshot['email'],
              style: const TextStyle(color: Colors.white)),
          currentAccountPicture: FutureBuilder(
            future: _getImage(documentSnapshot['imagePath'].toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Image(image: NetworkImage(snapshot.data.toString()));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 1.2,
                  child: const CircularProgressIndicator(),
                );
              }
              return const Text('ERROR');
            },
          )),
      ListTile(
        leading: const Icon(Icons.person_outlined),
        title: const Text('Profile'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserProfilePage()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.restaurant_outlined),
        title: const Text('Restaurants'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RestaurantPage()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.price_change_outlined),
        title: const Text('Discounts'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DiscountPage()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.supervised_user_circle_rounded),
        title: const Text('Create Account'),
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => RegisterPage()),
              (route) => false);
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Logout'),
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        },
      )
    ],
  );
}
