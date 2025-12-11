//Copyright (C) 2025 Ivan Gaydardzhiev
//Licensed under the GPL-3.0-only

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:ntp/ntp.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(NSSessionApp());

class NSSessionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '    НС на живо',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SessionLiveStream(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SessionLiveStream extends StatefulWidget {
  @override
  _SessionLiveStreamState createState() => _SessionLiveStreamState();
}

class _SessionLiveStreamState extends State<SessionLiveStream> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  DateTime? ntpTime;
  bool streamAvailable = true;
  Timer? _clockTimer;

  final String streamUrl =
      'https://e205-ts.cdn.bg/parliament/fls/zplenarna.stream/chunklist_b800000.m3u8';

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initializePlayer();
    _syncTime();
  }

  void _initializePlayer() {
    _videoPlayerController = VideoPlayerController.network(streamUrl)
      ..initialize().then((_) {
        if (_videoPlayerController.value.duration.inSeconds == 0) {
          setState(() => streamAvailable = false);
          return;
        }
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: true,
          aspectRatio: 16 / 9,
          allowFullScreen: true,
        );
        setState(() {});
      }).catchError((error) {
        print("Грешка при зареждане на видеото: $error");
        setState(() => streamAvailable = false);
      });
  }

  Future<void> _syncTime() async {
    try {
      DateTime now = await NTP.now();
      setState(() {
        ntpTime = now;
      });
      _clockTimer = Timer.periodic(Duration(minutes: 1), (timer) {
        setState(() {
          ntpTime = ntpTime!.add(Duration(minutes: 1));
        });
      });
    } catch (e) {
      print("Грешка при синхронизация с NTP: $e");
      setState(() {
        ntpTime = DateTime.now();
      });
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _clockTimer?.cancel();
    super.dispose();
  }

  void _exitApp() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('   НС на живо'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: _exitApp,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: !streamAvailable
                  ? Text(
                      "В момента няма активен стрийм...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : (_chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? Chewie(controller: _chewieController!)
                      : CircularProgressIndicator()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ntpTime != null
                  ? "Точно време: ${ntpTime!.toLocal().hour.toString().padLeft(2, '0')}:${ntpTime!.toLocal().minute.toString().padLeft(2, '0')}"
                  : "Синхронизация на часовника...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
