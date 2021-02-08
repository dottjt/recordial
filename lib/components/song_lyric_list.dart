import 'package:flutter/material.dart';

class SongLyricList extends StatefulWidget {
  SongLyricList({Key key, this.song }) : super(key: key);
  final song;

  @override
  _SongLyricListState createState() => _SongLyricListState();
}

class _SongLyricListState extends State<SongLyricList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a search term'
          ),
        ),
      ),
    );
  }
}

