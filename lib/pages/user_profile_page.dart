import 'package:app/pages/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  static const route = "/profile";

  const UserProfilePage({Key? key}) : super(key: key);
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: (snapshot.data as QuerySnapshot).size,
              itemBuilder: (context, index) =>
                  _buildForm((snapshot.data as QuerySnapshot).docs[index]),
            );
          },
        ),
      ),
    );
  }

  Future<String> _getImage(String fileName) {
    return FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
  }

  Widget _buildForm(DocumentSnapshot documentSnapshot) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            FutureBuilder(
              future: _getImage(documentSnapshot['imagePath'].toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Colors.blue),
                      accountName: Text(
                        documentSnapshot['userName'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      accountEmail: Text(documentSnapshot['email'].toString(),
                          style: const TextStyle(color: Colors.white)),
                      currentAccountPicture: Image(
                        alignment: Alignment.center,
                        image: NetworkImage(snapshot.data.toString()),
                      ));
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
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: TextFormField(
                initialValue: documentSnapshot['userName']?.toString(),
                decoration: const InputDecoration(hintText: 'Name'),
                enabled: false,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: TextFormField(
                initialValue: documentSnapshot['email']?.toString(),
                decoration: const InputDecoration(hintText: '@ username'),
                enabled: false,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: TextFormField(
                initialValue: documentSnapshot['city']?.toString(),
                decoration: const InputDecoration(hintText: 'Add actual city'),
                enabled: false,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_link),
              title: TextFormField(
                initialValue: documentSnapshot['webSite']?.toString(),
                decoration: const InputDecoration(hintText: 'Add web site'),
                enabled: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text('Go Home'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue),
              ),
            )
          ],
        ));
  }
}
