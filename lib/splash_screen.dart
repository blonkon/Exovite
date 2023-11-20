import 'package:exovite/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);
  @override
  _Splashscreenstate createState() => _Splashscreenstate();
}

class _Splashscreenstate extends State<Splash_screen>{
   late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('asset/screen.mp4')
    ..initialize().then((value) {
      setState(()=>{});
    })..setVolume(0.0);
    _playvideo();
  }
  void _playvideo() async{
    _controller.play();
    await Future.delayed(const Duration(seconds: 8));
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Lonpo',)));
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(000),
     body: Center(
       child: _controller.value.isInitialized
           ?AspectRatio(aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
           _controller
       ),
     ) : Container()
     ),
   );
  }
}
