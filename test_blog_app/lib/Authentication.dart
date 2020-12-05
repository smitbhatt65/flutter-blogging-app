import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class AuthImplementation
{
  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();

}

class Auth implements AuthImplementation
{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<String> SignIn(String email, String password) async{
    auth.User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> SignUp(String email, String password) async{
    auth.User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> getCurrentUser() async{
    auth.User user = _firebaseAuth.currentUser;
    return user.uid;

  }

  Future<void> signOut() async
  {
    _firebaseAuth.signOut();
  }

}
