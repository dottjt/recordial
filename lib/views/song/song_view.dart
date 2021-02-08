import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:music/components/song_lyric_list.dart';
import 'package:music/components/song_recording_list.dart';
import 'package:provider/provider.dart';

import '../home/home_navigation_bar.dart';
import '../../navigation/recording_navigation_floating_action_button.dart';

import 'package:music/models/song_model.dart';
import 'package:split_view/split_view.dart';

class SongView extends StatefulWidget {
  SongView({Key key, this.songId }) : super(key: key);
  final String songId;

  @override
  _SongViewState createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        return FutureBuilder(
          future: songModel.selectSong(songId: widget.songId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            print(widget.songId);
            if (snapshot.hasError) {
              return Text('Could not load song.');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data['title']),
                ),
                body: Center(
                  child: SongViewMain(song: snapshot.data)
                ),
                bottomNavigationBar: RecordingNavigationBar(recorder: _recorder),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: RecordingFloatingActionButton(
                  recordButtonCallback: () => {

                  }
                )
              );
            }
            return Container(width: 0.0, height: 0.0);
          }
        );
      }
    );
  }
}

class SongViewMain extends StatefulWidget {
  SongViewMain({Key key, this.song }) : super(key: key);
  final song;

  @override
  _SongViewMainState createState() => _SongViewMainState();
}

class _SongViewMainState extends State<SongViewMain> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final SongModel songModel = SongModel();

  @override
  Widget build(BuildContext context) {
    return SplitView(
      gripColor: Colors.white,
      initialWeight: 0.5,
      view1: SongRecordingList(song: widget.song),
      view2: SongLyricList(song: widget.song),
      viewMode: SplitViewMode.Vertical,
    );
  }
}