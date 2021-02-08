import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class SongModel extends ChangeNotifier {
  CollectionReference _songs = FirebaseFirestore.instance.collection('songs');

  var _allSongs = [];
  var _selectedSong;
  var _selectedRecording;
  // var _selectedLyric;

  Future<QuerySnapshot> retrieveSongs() async {
    QuerySnapshot querySnapshot = await _songs.get();
    print(querySnapshot.docs);
    print('querySnapshot.docs');
    _allSongs = querySnapshot.docs;
    notifyListeners();
    
    return querySnapshot;
  }

  get getAllSongs { return _allSongs; }
  get getSelectedSong { return _selectedSong; }

  Future<Map<String, dynamic>> selectSong({ String songId }) async {
    var song = await _songs.doc(songId).get();

    // _selectedSong = song;
    // notifyListeners();

    return song.data();
  }

  Future<void> addSong({ String title }) {
    final Map<String, dynamic> songMap = {
      'title': title,
      'recordings': [],
      'lyrics': [
        { 'text': '' }
      ]
    };

    return _songs
      .add(songMap)
      .then((value) {
        print("Song Added: ${value.id}");
        _selectedSong = value;
        notifyListeners();
      })
      .catchError((error) => print("Failed to add song: $error"));
  }

  Future<void> updateSong({ String songId, String title }) {
    return _songs
      .doc(_selectedSong.id)
      .update({
        'title': title
      })
      .then((value) {
        print("Song Updated");
        _selectedSong = {
          ..._selectedSong,
          'title': title
        };
      })
      .catchError((error) => print("Failed to update song: $error"));
  }

  Future<void> deleteSong({ String songId }) {
    return _songs
      .doc(_selectedSong.id)
      .delete()
      .then((value) => print("Song Deleted"))
      .catchError((error) => print("Failed to delete song: $error"));
  }

  // RECORDINGS

  Future<void> addSongRecording({ recording }) {
    var uuid = Uuid();
    uuid.v4();

    return _songs
      .doc(_selectedSong.id)
      .update({
        'recordings': FieldValue.arrayUnion(recording),
      })
      .then((value) {
        print("Recording Added");

        _selectedRecording = recording;
        notifyListeners();
      })
      .catchError((error) => print("Failed to add recording: $error"));
  }

  Future<void> deleteSongRecording({ recording }) {
    // ensure this is the entire recording.
    return _songs
      .doc(_selectedSong.id)
      .update({
        'recordings': FieldValue.arrayRemove(recording),
      })
      .then((value) => print("Recording delete"))
      .catchError((error) => print("Failed to delete recording: $error"));
  }



  // void removeSong() {
  //   _count += 1;
  // }

  // void incrementCounter() {
  //   _count += 1;
  //   notifyListeners();
  // }
}
