import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../home/home_navigation_bar.dart';
import '../../navigation/recording_navigation_floating_action_button.dart';

class SongView extends StatefulWidget {
  SongView({Key key}) : super(key: key);

  @override
  _SongViewState createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('song page title thing'),
      ),
      body: Center(
        child: Text('welcome to the song page')
      ),
      bottomNavigationBar: RecordingNavigationBar(recorder: _recorder),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: RecordingFloatingActionButton(
        recordButtonCallback: () => {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SecondRoute()),
          // );
        }
      )
    );
  }
}
