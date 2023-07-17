// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Non-linear Video Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final videoList = <VideoSource>[
//     VideoSource(name: 'Mountain', path: 'assets/mountain.mp4'),
//     VideoSource(name: 'Vally', path: 'assets/vally.mp4'),
//     VideoSource(name: 'Rain', path: 'assets/rain.mp4'),
//   ];
//
//   late VideoPlayerController _controller;
//   bool isPlaying = true;
//
//   @override
//   void initState() {
//     super.initState();
//     start();
//   }
//
//   void start() {
//     _controller = VideoPlayerController.asset('assets/intro.mp4')
//       ..initialize().then((_) => setState(() {}));
//     _controller.addListener(showDialogListener);
//     _controller.addListener(pausePlayListener);
//     _controller.play();
//   }
//
//   void showDialogListener() {
//     if (_controller.value.position > const Duration(milliseconds: 7000)) {
//       _controller.removeListener(showDialogListener);
//       _controller.pause();
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => AlertDialog(
//           title: const Text(
//             "Which video you prefer?",
//             style: TextStyle(fontSize: 18),
//           ),
//           actions: videoList
//               .map((e) => TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _controller.pause();
//                       _controller = VideoPlayerController.asset(e.path)
//                         ..initialize().then((_) {
//                           setState(() {});
//                         });
//                       _controller.addListener(pausePlayListener);
//                       _controller.play();
//                     },
//                     child: Text(e.name),
//                   ))
//               .toList(),
//         ),
//       );
//     }
//   }
//
//   void pausePlayListener() {
//     if (_controller.value.isPlaying != isPlaying) {
//       setState(() {
//         isPlaying = _controller.value.isPlaying;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text("Non-linear Video Demo"),
//         actions: [
//           IconButton(
//             onPressed: start,
//             icon: const Icon(Icons.replay),
//           ),
//         ],
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? VideoPlayer(_controller)
//             : Container(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying
//                 ? _controller.pause()
//                 : _controller.play();
//           });
//         },
//         child: Icon(
//           isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//
// class VideoSource {
//   final String name, path;
//
//   VideoSource({required this.name, required this.path});
// }
