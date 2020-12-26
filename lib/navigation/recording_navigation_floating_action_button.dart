import 'package:flutter/material.dart';
import '../components/record_button.dart';

class RecordingFloatingActionButton extends StatefulWidget {
  RecordingFloatingActionButton({Key key, this.recordButtonCallback}) : super(key: key);

  final recordButtonCallback;

  @override
  _RecordingFloatingActionButtonState createState() => _RecordingFloatingActionButtonState();
}

class _RecordingFloatingActionButtonState extends State<RecordingFloatingActionButton> {

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      onPressed: widget.recordButtonCallback,
      tooltip: 'Record',
      child: Container(
          child: CustomPaint(
            painter: OpenPainter(),
          ),
      ),
    );
  }
}



