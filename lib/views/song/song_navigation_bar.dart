import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordingNavigationBar extends StatefulWidget {
  RecordingNavigationBar({Key key, this.recorder}) : super(key: key);

  final FlutterSoundRecorder recorder;

  @override
  _RecordingNavigationBarState createState() => _RecordingNavigationBarState();
}

class _RecordingNavigationBarState extends State<RecordingNavigationBar> {
  int _selectedIndex = 0;

  void _onBottomNavigationItemTapped(int index, FlutterSoundRecorder recorder) {
    setState(() {
      if (index == 0) {
        // recorder
        // stop the recording
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Lyrics',
        ),
      ],
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) => _onBottomNavigationItemTapped(index, widget.recorder),
    );
  }
}
