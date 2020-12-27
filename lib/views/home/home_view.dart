import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:music/components/song_list.dart';

import 'home_navigation_bar.dart';
import '../../navigation/recording_navigation_floating_action_button.dart';
import '../song/song_view.dart';

// import '../models/song_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text('hi', style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.end),
            SongList(),
          ],
        )
      ),
      bottomNavigationBar: RecordingNavigationBar(recorder: _recorder),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: RecordingFloatingActionButton(
        recordButtonCallback: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SongView()),
          )

          // SongModel.addSong('cake')
        }
      )
    );
  }
}

