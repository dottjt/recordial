import 'package:flutter/material.dart';
import 'package:music/views/home_loading_view/home_loading_view.dart';
import 'package:music/views/home_error_view/home_error_view.dart';

import 'views/home/home_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MusicAppInitialize());
}

class MusicAppInitialize extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MusicApp(component:  HomeErrorView());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore.instance.settings = Settings(
              cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
          );

          return MusicApp(component:  HomeView(title: 'Recordial'));
        }

        return MusicApp(component:  HomeLoadingView());
      },
    );
  }
}

class MusicApp extends StatefulWidget {
  MusicApp({Key key, this.component}) : super(key: key);

  final Widget component;

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recordial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.component,
    );
  }
}


// new MaterialApp(home: new LoginForm())
