import 'package:camera_filters/camera_filters.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ImageFilterPackageExample extends StatefulWidget {
  @override
  _ImageFilterPackageExampleState createState() =>
      _ImageFilterPackageExampleState();
}

class _ImageFilterPackageExampleState extends State<ImageFilterPackageExample> {
  // late VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CameraScreenPlugin(
          onDone: (value) {
            /// value returns the picture path you can save here or navigate to some screen
            print(value);
          },

          /// value returns the video path you can save here or navigate to some screen
          onVideoDone: (value) {
            print(value);
          },

          /// profileIconWidget: , if you want to add profile icon on camera you can your widget here
          // profileIconWidget: Icon(
          //   Icons.camera,
          //   color: Colors.white,
          // ),
          ///filterColor: ValueNotifier<Color>(Colors.transparent),  your first filter color when you open camera
          filters: [
            Colors.transparent,
            Colors.blue,
            Colors.red,
            Colors.orangeAccent,
            Colors.green,
            Colors.yellow,
            Colors.pink
          ],

          ///you can pass your own list of colors like this List<Color> colors = [Colors.blue, Colors.blue, Colors.blue ..... Colors.blue]
          ///make sure to pass transparent color to first index so the first index of list has no filter effect
        ),
      ),
    );
  }
}
