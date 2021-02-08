import 'package:flutter/material.dart';

import 'package:music/types/list_type.dart';
import 'package:music/views/song/song_view.dart';

class SongRecordingList extends StatefulWidget {
  SongRecordingList({Key key, this.song }) : super(key: key);
  final song;

  @override
  _SongRecordingListState createState() => _SongRecordingListState();
}

class _SongRecordingListState extends State<SongRecordingList> {
  @override
  Widget build(BuildContext context) {
    final recordings = widget.song['recordings'];

    final items = List<SongRecordingItem>.generate(
      recordings.length,
      (i) => SongRecordingItem(recordings[i])
    );

    if (items.length > 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
            trailing: GestureDetector(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(context, details.globalPosition);
              },
              child: Icon(Icons.more_vert),
            ),
            onTap:  () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SongView()),
              )
            },
            onLongPress: () => {

            },
          );
        },
      );
    }

    return Center(child: Text('You have no recordings.'));
  }
}

class SongRecordingItem implements ListItem {
  final String title;

  SongRecordingItem(this.title);

  Widget buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
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
      PopupMenuItem(
        value: 3,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
              child: Icon(Icons.share),
            ),
            Text('Delete')
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

  if (selected == 3) {
    print('handle delete');
  }
}
