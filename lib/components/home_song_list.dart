import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music/models/song_model.dart';

import 'package:music/types/list_type.dart';
import 'package:music/views/song/song_view.dart';
import 'package:provider/provider.dart';

class HomeSongItem implements ListItem {
  final QueryDocumentSnapshot item;

  HomeSongItem({ this.item });

  get songId {
    return item.id;
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      item.data()['title'],
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

class SongList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SongModel>(
      builder: (context, songModel, child) {
        return FutureBuilder(
          future: songModel.retrieveSongs(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Could not get songs.');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              var songs = songModel.getAllSongs;
              print(songs);
              print('songs');
              if (songs.length > 0) {
                final items = List<HomeSongItem>.generate(
                  songs.length,
                  (i) => HomeSongItem(item: songs[i])
                );

                return HomeSongListBuilder(items: items);
              }

              return Text('Hit the record button to create your first song.');
            }

            return Container(width: 0.0, height: 0.0);
          },
        );
      }
    );
  }
}

class HomeSongListBuilder extends StatefulWidget {
  HomeSongListBuilder({Key key, this.items}) : super(key: key);
  final items;

  @override
  _HomeSongListBuilderState createState() => _HomeSongListBuilderState();
}

class _HomeSongListBuilderState extends State<HomeSongListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
          trailing: GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(context, details.globalPosition);
            },
            child: Icon(Icons.more_vert),
          ),
          onTap:  () {
            print('item.songId');
            print(item.songId);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SongView(songId: item.songId)),
            );
          },
          onLongPress: () => {

          },
        );
      },
    );
  }
}

Future<void> _showPopupMenu(BuildContext context, Offset offset) async {
  double left = offset.dx;
  double top = offset.dy;

  int selected = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: [
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
              child: Icon(Icons.create_sharp),
            ),
            Text('Rename')
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
              child: Icon(Icons.share),
            ),
            Text('Share')
          ],
        )
      ),
    ],
    elevation: 8.0,
  );

  if (selected == 1) {
    print('handle rename');
  }

  if (selected == 2) {
    print('handle share');
  }
}