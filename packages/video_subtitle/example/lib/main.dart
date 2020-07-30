import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:video_subtitle/video_subtitle.dart';

const videoUrl =
    'https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _videoController = VideoPlayerController.asset('assets/video.mp4');

  @override
  void initState() {
    super.initState();

    _videoController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();

    super.dispose();
  }

  Widget _buildFab() {
    return FloatingActionButton(
      child: Icon(
        _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
      ),
      onPressed: () {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
        setState(() {});
      },
    );
  }

  Widget _buildBody() {
    return Center(
      child: SizedBox(
        height: 200,
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoSubtitle.asset(
                'assets/subtitle.srt',
                videoController: _videoController,
                builder: (context, subtitle) => Text(
                  subtitle,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Video subtitles'),
    );
  }
}
