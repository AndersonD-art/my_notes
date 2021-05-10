import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minhas_anotacoes/app/screens/audio_record/widget/custom_expansion_tile.dart';
import 'package:share/share.dart';

class ListRecordScreen extends StatefulWidget {
  final List<String> records;

  const ListRecordScreen({
    Key key,
    this.records,
  }) : super(key: key);

  @override
  _ListRecordScreenState createState() => _ListRecordScreenState();
}

class _ListRecordScreenState extends State<ListRecordScreen> {
  int _totalTime;
  int _currentTime;
  double _percent = 0.0;
  int _selected = -1;
  bool isPlay = false;
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key('builder ${_selected.toString()}'),
      itemCount: widget.records.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          child: Theme(
            data: ThemeData(
              accentColor: Colors.red,
              unselectedWidgetColor: Colors.deepPurpleAccent,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
            child: CustomExpansionTile(
              key: Key(index.toString()),
              initiallyExpanded: index == _selected,
              title: Text(
                'Record ${widget.records.length - index}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                _getTime(filePath: widget?.records?.elementAt(index)),
                style: TextStyle(color: Colors.black38),
              ),
              onExpansionChanged: ((newState) {
                if (newState) {
                  if (newState)
                    setState(() {
                      Duration(seconds: 20000);
                      _selected = index;
                    });
                  else
                    setState(() {
                      _selected = -1;
                    });
                }
              }),
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        value: _selected == index ? _percent : 0,
                      ),
                      Row(
                        children: [
                          (isPlay)
                              ? _Presso(
                                  ico: Icons.pause,
                                  onPressed: () {
                                    setState(() {
                                      isPlay = false;
                                    });
                                    advancedPlayer.pause();
                                  })
                              : _Presso(
                                  ico: Icons.play_arrow,
                                  onPressed: () {
                                    setState(() {
                                      isPlay = true;
                                    });
                                    advancedPlayer.play(
                                        widget.records.elementAt(index),
                                        isLocal: true);
                                    setState(() {});
                                    setState(() {
                                      _selected = index;
                                      _percent = 0.0;
                                    });
                                    advancedPlayer.onPlayerCompletion
                                        .listen((_) {
                                      setState(() {
                                        _percent = 0.0;
                                      });
                                    });
                                    advancedPlayer.onDurationChanged
                                        .listen((duration) {
                                      setState(() {
                                        _totalTime = duration.inMicroseconds;
                                      });
                                    });
                                    advancedPlayer.onAudioPositionChanged
                                        .listen((duration) {
                                      setState(() {
                                        _currentTime = duration.inMicroseconds;
                                        _percent = _currentTime.toDouble() /
                                            _totalTime.toDouble();
                                      });
                                    });
                                  }),
                          _Presso(
                              ico: Icons.stop,
                              onPressed: () {
                                advancedPlayer.stop();
                                setState(() {
                                  _percent = 0.0;
                                });
                              }),
                          _Presso(
                              ico: Icons.delete,
                              onPressed: () {
                                Directory appDirec =
                                    Directory(widget.records.elementAt(index));
                                appDirec.delete(recursive: true);
                                Fluttertoast.showToast(msg: "File Deleted");
                                setState(() {
                                  widget.records
                                      .remove(widget.records.elementAt(index));
                                });
                              }),
                          _Presso(
                              ico: Icons.share,
                              onPressed: () {
                                Directory appDirec =
                                    Directory(widget.records.elementAt(index));
                                List<String> list = [];
                                list.add(appDirec.path);
                                Share.shareFiles(list);
                              }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getTime({@required String filePath}) {
    String fromPath = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));
    if (fromPath.startsWith('1', 0)) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(fromPath));
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;
      int hour = dateTime.hour;
      int min = dateTime.minute;
      String dato = '$day-$month-$year--$hour:$min';
      return dato;
    } else {
      return "No Date";
    }
  }
}

class _Presso extends StatelessWidget {
  final IconData ico;
  final VoidCallback onPressed;

  const _Presso({Key key, this.ico, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 48.0,
      child: ElevatedButton(
          child: Icon(
            ico,
            color: Colors.white,
          ),
          onPressed: onPressed),
    );
  }
}
