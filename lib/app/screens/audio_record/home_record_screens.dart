import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:minhas_anotacoes/app/screens/audio_record/list_record_screens.dart';
import 'package:minhas_anotacoes/app/screens/audio_record/recorder_screens.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRecordScreen extends StatefulWidget {
  @override
  _HomeRecordScreenState createState() => _HomeRecordScreenState();
}

class _HomeRecordScreenState extends State<HomeRecordScreen> {
  Directory appDir;
  Stream<FileSystemEntity> fileStream;
  List<String> records;
  FlutterAudioRecorder2 audioRecorder;

  @override
  void initState() {
    records = [];
    checkAndRequestStoragePermissions();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    fileStream = null;
    appDir = null;
    records = null;
    super.dispose();
  }

  Future<bool> checkAndRequestStoragePermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      getExternalStorageDirectory().then((value) async {
        appDir = value.parent.parent.parent.parent;
        Directory appDirec = Directory("${appDir.path}/Audiorecords/");
        appDir = appDirec;
        await appDirec.create(recursive: true);
        appDir.list().listen((onData) {
          records.add(onData.path);
        }).onDone(() {
          records = records.reversed.toList();
          setState(() {});
        });
      });
      return false;
    } else {
      getExternalStorageDirectory().then((value) async {
        appDir = value.parent.parent.parent.parent;
        Directory appDirec = Directory("${appDir.path}/Audiorecords/");
        appDir = appDirec;
        appDir.list().listen((onData) {
          records.add(onData.path);
        }).onDone(() {
          records = records.reversed.toList();
          setState(() {});
        });
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        onPressed: () {
          show(context);
        },
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(
        title: Text('Meus Áudios'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListRecordScreen(
              records: records,
            ),
          ),
        ],
      ),
    );
  }

  _onFinish() {
    records.clear();
    appDir.list().listen((onData) {
      records.add(onData.path);
    }).onDone(() {
      records.sort();
      records = records.reversed.toList();
      setState(() {});
    });
  }

  void show(BuildContext context) {
    showModalBottomSheet<void>(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white70,
          child: RecordScreen(
            save: _onFinish,
          ),
        );
      },
    );
  }
}
