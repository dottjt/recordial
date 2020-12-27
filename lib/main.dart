import 'package:flutter/material.dart';
import 'package:music/views/home_loading_view/home_loading_view.dart';
import 'package:music/views/home_error_view/home_error_view.dart';

import 'app.dart';
import 'views/home/home_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppInitialize());
}

class AppInitialize extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return App(component: HomeErrorView());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore.instance.settings = Settings(
              cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
          );

          return App(component: HomeView(title: 'Recordial'));
        }

        return App(component: HomeLoadingView());
      },
    );
  }
}
