import 'package:flutter/material.dart';

import 'package:music/types/list_type.dart';
import 'package:music/views/song/song_view.dart';

class HomeSongItem implements ListItem {
  final String name;

  HomeSongItem(this.name);

  Widget buildTitle(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

class SongList extends StatelessWidget {

  final items = List<HomeSongItem>.generate(
    10,
    (i) => HomeSongItem("Song Name")
  );

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
      print('handle edit');
    }

    if (selected == 2) {
      print('handle pete');
    }
  }

  @override
  Widget build(BuildContext context) {
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
}
