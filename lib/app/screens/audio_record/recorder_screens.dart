import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class RecordScreen extends StatefulWidget {
  final Function save;

  const RecordScreen({
    Key key,
    this.save,
  }) : super(key: key);
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final ValueNotifier<bool> stop = ValueNotifier<bool>(false);
  final ValueNotifier<RecordingStatus> _currentStatus =
      ValueNotifier<RecordingStatus>(RecordingStatus.Unset);
  final ValueNotifier<Recording> _current = ValueNotifier<Recording>(null);
  final ValueNotifier<String> _time = ValueNotifier<String>("0:00:00");

  IconData _recordIcon = Icons.mic;
  MaterialColor colo = Colors.orange;
  bool _permission = false;
  FlutterAudioRecorder audioRecorder;

  @override
  void initState() {
    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (hasPermision) {
        _currentStatus.value = RecordingStatus.Initialized;
        _permission = true;
        _init();
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _currentStatus.value = RecordingStatus.Unset;
    audioRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              _time.value == null ? "0:00:00" : _time.value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            stop.value == false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.purple,
                          ),
                          onPressed: () async {
                            await _onRecordButtonPressed();
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  _recordIcon,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _permission
                                    ? Text(
                                        "Gravar",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "Sem Permisão",
                                        style: TextStyle(color: Colors.red),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.red,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Sair",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: colo,
                          ),
                          onPressed: () async {
                            await _onRecordButtonPressed();
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              _recordIcon,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.red,
                          ),
                          onPressed:
                              _currentStatus.value != RecordingStatus.Unset
                                  ? _stop
                                  : null,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.stop,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_currentStatus.value) {
      case RecordingStatus.Initialized:
        {
          await _recordo();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _pause();
          break;
        }
      case RecordingStatus.Paused:
        {
          await _resume();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _recordo();
          break;
        }
      default:
        break;
    }
  }

  _init() async {
    Directory appDir = await getExternalStorageDirectory();
    String jrecord = 'Audiorecords';
    String dato = "${DateTime.now()?.millisecondsSinceEpoch?.toString()}.wav";
    Directory appDirec =
        Directory("${appDir.parent.parent.parent.parent.path}/$jrecord/");
    if (await appDirec.exists()) {
      String patho = "${appDirec.path}$dato";
      audioRecorder = FlutterAudioRecorder(patho, audioFormat: AudioFormat.WAV);
      await audioRecorder.initialized;
      var current = await audioRecorder.current(channel: 0);
      _current.value = current;
      _currentStatus.value = current.status;
    } else {
      await appDirec.create(recursive: true);
      Fluttertoast.showToast(msg: "Start Recording , Press Start");
      String patho = "${appDirec.path}$dato";
      audioRecorder = FlutterAudioRecorder(patho, audioFormat: AudioFormat.WAV);
      await audioRecorder.initialized;
    }
  }

  _start() async {
    try {
      await audioRecorder.start();
      /* var recording = await audioRecorder.current(channel: 0);

      setState(() {
        _current.value = recording;
      });
 */
      const tick = const Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus.value == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await audioRecorder.current(channel: 0);
        setState(() {
          _current.value = current;
          _currentStatus.value = _current.value.status;
          _time.value = _current.value?.duration?.toString()?.substring(0, 7);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await audioRecorder.resume();
    Fluttertoast.showToast(msg: "Resume Recording");
    setState(() {
      _recordIcon = Icons.pause;
      colo = Colors.red;
    });
  }

  _pause() async {
    await audioRecorder.pause();
    Fluttertoast.showToast(msg: "Pause Recording");
    setState(() {
      _recordIcon = Icons.play_arrow_rounded;
      colo = Colors.green;
    });
  }

  _stop() async {
    var result = await audioRecorder.stop();
    Fluttertoast.showToast(msg: "Stop Recording , File Saved");
    widget.save();

    setState(() {
      _currentStatus.value = result.status;
      _current.value.duration = null;
      _recordIcon = Icons.mic;
      stop.value = false;
    });
  }

  Future<void> _recordo() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      await _init();
      await _start();

      setState(() {
        _recordIcon = Icons.pause;
        colo = Colors.red;
        stop.value = true;
      });
      Fluttertoast.showToast(msg: "Start Recording");
    } else {
      Fluttertoast.showToast(msg: "Allow App To Use Mic");
    }
  }
}
