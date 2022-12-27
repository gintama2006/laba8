


import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuple/tuple.dart';


// class UserDataModel {
//   final String userEmail;
//   final String password;
//
//   UserDataModel({
//     required this.userEmail,
//     required this.password
//   });
// }

class AuthServise{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Tuple2<User?, String?>> signInWithEmailAndPassword(String email, String password) async {
    try{
      print(email + "|" + password);
      final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return Tuple2(credential.user, "ok");
    } on FirebaseAuthException catch (e) {
      return Tuple2(null, e.message);
      print(e.message);
    }
    catch(e){
      return Tuple2(null, e.toString());
    }
  }

  Future<Tuple2<User?, String?>> registerWithEmailAndPassword(String email, String password) async{
    try{
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return Tuple2(credential.user, "ok");
    } on FirebaseAuthException catch (e){
      return Tuple2(null, e.message);
    }
    catch(e){
      return Tuple2(null, e.toString());
    }
  }

  Future logOut() async {
    await _auth.signOut();
  }

  Stream<User?> get currentUser{
    return _auth.authStateChanges();
  }

}


