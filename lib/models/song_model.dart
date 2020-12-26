import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class Song {
//   final String sender;

//   Song(this.sender);
// }

class SongModel extends ChangeNotifier {
  CollectionReference _songs = FirebaseFirestore.instance.collection('songs');

  String _selectedSongId;

  // GET
  // int get getSongs {
  get getSongs {
    return _songs;
  }

  get getSelectedSong {
    return _selectedSongId;
  }

  void updateSelectedSongId(String selectedSongId) {
    _selectedSongId = selectedSongId;
    notifyListeners();
  }

  // Future<void> getSong(documentId) {
  //   return _songs.doc(documentId).get();
  // }

  Future<void> addSong({ String name }) {
    return _songs
      .add({
        'name': name, // John Doe
      })
      .then((value) => print("Song Added"))
      .catchError((error) => print("Failed to add song: $error"));
  }

  Future<void> updateSong({ String songId, String name }) {
    return _songs
      .doc(songId)
      .update({
        'name': name
      })
      // .update({'info.address.zipcode': 90210}) // update deeply nested.
      .then((value) => print("Song Updated"))
      .catchError((error) => print("Failed to update song: $error"));
  }

  Future<void> deleteSong({ String songId }) {
    return _songs
      .doc(songId)
      .delete()
      .then((value) => print("Song Deleted"))
      .catchError((error) => print("Failed to delete song: $error"));
  }

  // void removeSong() {
  //   _count += 1;
  // }

  // void incrementCounter() {
  //   _count += 1;
  //   notifyListeners();
  // }
}
