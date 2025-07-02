import 'package:chatify/models/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import 'package:get_it/get_it.dart';
import '../services/navigation_services.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationServices _navigationServices;
  late final DatabaseService _db;
  late ChatUser user;
  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationServices = GetIt.instance.get<NavigationServices>();
    _db = GetIt.instance.get<DatabaseService>();

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _db.updateuserlastTime(_user.uid);
        _db.getUser(_user.uid).then(
          (_snapshot) {
            Map<String, dynamic> _userData = _snapshot.data()! as Map<String, dynamic>;
            user = ChatUser.fromJSON(
              {
                "uid": _user.uid,
                "email": _userData["email"],
                "name": _userData["name"],
                "last_active": _userData["last_active"],
                "image": _userData["image"],
              },
            );
            GetIt.instance.get<NavigationServices>().removeAndNavigateToRoute('/home');
            print("user");
          },
        );
      } else {
        _navigationServices.removeAndNavigateToRoute('/login');
        print("Not Authentication");
      }
    });
  }
  Future<void> loginusingEmailandpassword(String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password); 
      GetIt.instance.get<NavigationServices>().removeAndNavigateToRoute('/home');
    } on FirebaseAuthException {
      print("Error loging user into Firebase");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> regiterUserUsingEmailPassword(  String _email, String _password) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      return credentials.user!.uid;
    } on FirebaseAuthException {
      print("Error Register User");
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
