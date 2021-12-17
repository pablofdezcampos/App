import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref(fileName).putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results = await storage.ref().listAll();

    results.items.forEach((Reference reference) {
      print('Found file: $reference');
    });

    return results;
  }

  Future<String> dowloadUrl() async {
    String dowloadUrl = await storage.ref().getDownloadURL();
    return dowloadUrl;
  }
}
