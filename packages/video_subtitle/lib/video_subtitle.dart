import 'package:flutter/widgets.dart';
import 'package:pedantic/pedantic.dart';
import 'package:srt_parser/srt_parser.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

typedef SubtitleBuilder = Widget Function(BuildContext, String);

class VideoSubtitle extends StatefulWidget {
  VideoSubtitle._({
    @required this.videoController,
    @required this.builder,
    Key key,
    this.asset,
    this.url,
  })  : assert(videoController != null),
        assert(builder != null),
        super(key: key);

  VideoSubtitle.asset(
    String asset, {
    @required VideoPlayerController videoController,
    @required SubtitleBuilder builder,
    Key key,
  }) : this._(
          videoController: videoController,
          key: key,
          asset: asset,
          url: null,
          builder: builder,
        );

  VideoSubtitle.network(
    String url, {
    @required VideoPlayerController videoController,
    @required SubtitleBuilder builder,
    Key key,
  }) : this._(
          videoController: videoController,
          key: key,
          url: url,
          asset: null,
          builder: builder,
        );

  final VideoPlayerController videoController;
  final String asset;
  final String url;
  final SubtitleBuilder builder;

  @override
  _VideoSubtitleState createState() => _VideoSubtitleState();
}

class _VideoSubtitleState extends State<VideoSubtitle> {
  VoidCallback _videoControllerListener;
  List<Subtitle> _subtitles;
  bool _isPlaying = false;
  Subtitle _subtitle;

  VideoPlayerController get _videoController => widget.videoController;
  bool get _isSubtitledFromAssets => widget.asset != null && widget.url == null;
  bool get _isPlayTaped => !_isPlaying && _videoController.value.isPlaying;
  bool get _isPauseTaped => _isPlaying && !_videoController.value.isPlaying;
  int get _currentDuration => _videoController.value.position.inMilliseconds;

  @override
  void initState() {
    super.initState();

    _initListeners();
    _getSubtitles().then((subtitles) {
      _subtitles = subtitles;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _getSubtitleText());
  }

  @override
  void dispose() {
    _disposeListeners();

    super.dispose();
  }

  void _initListeners() {
    _videoControllerListener = () {
      if (_isPlayTaped) {
        _isPlaying = true;
        _scheduleNextSubtitle();
      } else if (_isPauseTaped) {
        _isPlaying = false;
      } else {
        // Nothing
      }
    };
    _videoController.addListener(_videoControllerListener);
  }

  void _disposeListeners() {
    _videoController.removeListener(_videoControllerListener);
  }

  Future<List<Subtitle>> _getSubtitles() async {
    if (_isSubtitledFromAssets) {
      final String subtitleStr = await rootBundle.loadString(widget.asset);
      final List<Subtitle> subtitles = parseSrt(subtitleStr);
      return subtitles;
    } else {
      // TODO check this
      final http.Response response = await http.get(widget.url);
      final List<Subtitle> subtitles = parseSrt(response.body);
      return subtitles;
    }
  }

  void _scheduleNextSubtitle() {
    if (_subtitles == null) return;

    if (_isPlaying) {
      final Subtitle nextSubtitle = _findSubtitle();

      if (nextSubtitle.range.begin <= _currentDuration &&
          _currentDuration < nextSubtitle.range.end &&
          _subtitle == nextSubtitle) {
        _closeSubtitle(nextSubtitle);
      } else {
        _openSubtitle(nextSubtitle);
      }
    }
  }

  Future<void> _openSubtitle(Subtitle subtitle) async {
    if (_currentDuration < subtitle.range.begin) {
      await Future.delayed(
        Duration(milliseconds: subtitle.range.begin - _currentDuration),
      );
    }

    if (!_isPlaying) return;
    _subtitle = subtitle;
    setState(() {});

    unawaited(_closeSubtitle(subtitle));
  }

  Future<void> _closeSubtitle(Subtitle subtitle) async {
    if (_currentDuration < subtitle.range.end) {
      await Future.delayed(
        Duration(milliseconds: subtitle.range.end - _currentDuration),
      );
    }

    if (!_isPlaying) return;

    final Subtitle nextSubtitle = _getNextSubtitle(subtitle);
    _subtitle = null;
    setState(() {});

    unawaited(_openSubtitle(nextSubtitle));
  }

  Subtitle _findSubtitle() {
    Subtitle prevSub;

    for (Subtitle sub in _subtitles) {
      if (sub.range.begin <= _currentDuration &&
          _currentDuration < sub.range.end) {
        return sub;
      }

      if (prevSub != null &&
          prevSub.range.end <= _currentDuration &&
          _currentDuration < sub.range.begin) {
        return sub;
      }

      prevSub = sub;
    }

    return null;
  }

  String _getSubtitleText() {
    if (_subtitle == null) return '';
    final stringBuffer = StringBuffer();

    for (String line in _subtitle.rawLines) {
      stringBuffer.writeln(line);
    }
    return stringBuffer.toString();
  }

  Subtitle _getNextSubtitle(Subtitle subtitle) {
    final int index = _subtitles.indexOf(subtitle);

    if (_subtitles.length - 1 == index) return null;

    return _subtitles[index + 1];
  }
}
