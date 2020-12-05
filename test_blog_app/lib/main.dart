import 'package:flutter/material.dart';
import 'package:test_blog_app/LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Mapping.dart';
import 'Authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp
    (
      title: "Blog App",
      theme: new ThemeData
      (
        primarySwatch: Colors.red

      ),
      home: MappingPage(auth:Auth(),),
    );
  }
}