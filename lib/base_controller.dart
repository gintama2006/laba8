import 'package:firebase_storage/firebase_storage.dart' as fireStore;
import 'dart:io';


class FireStorageManager {

  final fireStore.FirebaseStorage storage = fireStore.FirebaseStorage.instance;

  Future<void> uploadFile(String filepath, String fileName) async {
    File file = File(filepath);
    try{
      await storage.ref("music/$fileName").putFile(file);
    } on fireStore.FirebaseException catch (e){
      print(e);
    }


  }

  Future<fireStore.ListResult> listFilesToMiracle() async {
    fireStore.ListResult result = await storage.ref("Miracle").listAll();

    return result;
  }

  Future<fireStore.ListResult> listFilesToCowboy() async {
    fireStore.ListResult result = await storage.ref("Cowboys from hell").listAll();

    return result;
  }

  Future<String> getUrlFromMiracle(String fileName) async {
    String url = await storage.ref("Miracle/$fileName").getDownloadURL();
    return url;
  }

  Future<String> getUrlFromCowboy(String fileName) async {
    String url = await storage.ref("Cowboys from hell/$fileName").getDownloadURL();
    return url;
  }
}