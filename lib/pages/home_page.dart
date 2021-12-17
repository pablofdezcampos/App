import 'package:app/components/botton_navigation.dart';
import 'package:app/components/drawer.dart';
import 'package:app/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final StorageService storageService = StorageService();
    return Scaffold(
      drawer: const HomeDrawer(),
      bottomNavigationBar: const BottomNavigation(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'prueba',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[_buildHomePage(context, storageService)],
      ),
    );
  }
}

Widget _buildHomePage(
  BuildContext context,
  StorageService storageService,
) {
  return Container(
      height: 539,
      padding: const EdgeInsets.only(left: 325, top: 10),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/explorer.jpeg'), fit: BoxFit.cover)),
      child: FutureBuilder(
          future: storageService.listFiles(),
          builder: (context, AsyncSnapshot<ListResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _userProfile(context),
                  _buildBottonGallery(storageService: storageService),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return Container();
          }));
}

Future<String> _getImage(String fileName) {
  return FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
}

class _buildBottonGallery extends StatelessWidget {
  const _buildBottonGallery({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  final StorageService storageService;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpeg']);

        if (results == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('No file selected')));
        }

        final path = results!.files.single.path;
        final fileName = results.files.single.name;

        storageService.uploadFile(path!, fileName);
      },
      child: const Icon(Icons.edit),
    );
  }
}

Widget _userProfile(BuildContext context) {
  //final StorageService storageService = StorageService();
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      image: const DecorationImage(
          image: AssetImage('assets/user.png'), fit: BoxFit.cover),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 3),
    ),
    child: Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/user.png'))),
    ),
  );
}
