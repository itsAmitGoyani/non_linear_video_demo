import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Non-linear Video Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDialogShown = false;
  final videoList = <VideoSection>[
    VideoSection(name: 'Sea water', duration: const Duration(seconds: 23)),
    VideoSection(name: 'Water fall', duration: const Duration(seconds: 60)),
    VideoSection(name: 'Rain', duration: const Duration(seconds: 74)),
    VideoSection(name: 'Forest', duration: const Duration(seconds: 100)),
    VideoSection(name: 'Land', duration: const Duration(seconds: 117)),
    VideoSection(name: 'Seashore', duration: const Duration(seconds: 132)),
    VideoSection(name: 'Sunset', duration: const Duration(seconds: 151)),
  ];

  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) => setState(() {}));
    _controller.play();
    _controller.addListener(showDialogListener);
    _controller.addListener(pausePlayListener);
  }

  void showDialogListener() {
    debugPrint(_controller.value.position.toString());
    final cp = _controller.value.position;
    switch (cp) {
      case >= const Duration(seconds: 19) && < const Duration(seconds: 22):
        displayDialog(isInitial: true);
        break;
      case >= const Duration(milliseconds: 22500) &&
            < const Duration(seconds: 23):
        _controller.seekTo(const Duration(seconds: 4));
        break;
      case >= const Duration(milliseconds: 58500) &&
            < const Duration(seconds: 59):
        _controller.seekTo(const Duration(seconds: 23));
        displayDialog();
        break;
      case >= const Duration(milliseconds: 72500) &&
            < const Duration(seconds: 73):
        _controller.seekTo(const Duration(seconds: 60));
        displayDialog();
        break;
      case >= const Duration(milliseconds: 98500) &&
            < const Duration(seconds: 99):
        _controller.seekTo(const Duration(seconds: 74));
        displayDialog();
        break;
      case >= const Duration(milliseconds: 114500) &&
            < const Duration(seconds: 115):
        _controller.seekTo(const Duration(seconds: 100));
        displayDialog();
        break;
      case >= const Duration(milliseconds: 129500) &&
            < const Duration(seconds: 130):
        _controller.seekTo(const Duration(seconds: 117));
        displayDialog();
        break;
      case >= const Duration(milliseconds: 149500) &&
            < const Duration(seconds: 150):
        _controller.seekTo(const Duration(seconds: 132));
        displayDialog();
        break;
      case >= const Duration(minutes: 3, seconds: 8) &&
            < const Duration(minutes: 3, seconds: 8, milliseconds: 500):
        _controller.seekTo(const Duration(seconds: 151));
        displayDialog();
        break;
      default:
        break;
    }
  }

  void pausePlayListener() {
    if (_controller.value.isPlaying != isPlaying) {
      setState(() {
        isPlaying = _controller.value.isPlaying;
      });
    }
  }

  void displayDialog({bool isInitial = false}) {
    if (isDialogShown) return;
    isDialogShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
        title: Text(
          isInitial
              ? "What would you like to watch in BIG ISLAND, HAWAII?"
              : "What else would you like to watch?",
          style: const TextStyle(fontSize: 18),
        ),
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: videoList
                .map((e) => TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        isDialogShown = false;
                        // _controller.pause();
                        _controller.seekTo(e.duration);
                        // _controller.play();
                      },
                      child: Text(e.name),
                    ))
                .toList(),
          ),
          if (!isInitial) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    isDialogShown = false;
                    _controller.pause();
                    _controller.seekTo(Duration.zero);
                  },
                  child: const Text(
                    "or Exit",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Non-linear Video Demo"),
        actions: [
          IconButton(
            onPressed: () {
              _controller.seekTo(Duration.zero);
            },
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Container(),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class VideoSection {
  final String name;
  final Duration duration;

  VideoSection({required this.name, required this.duration});
}
