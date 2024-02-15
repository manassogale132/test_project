import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewExample extends StatefulWidget {
  @override
  _StoryViewExampleState createState() => _StoryViewExampleState();
}

class _StoryViewExampleState extends State<StoryViewExample> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    storyItems = [
      // StoryItem.text(
      //   title: "I am Flutter Developer",
      //   backgroundColor: Colors.red,
      // ),
      StoryItem.pageImage(
          url:
              "https://assets.verticalmag.com/wp-content/uploads/2023/07/ValorSummer2023-COVER-791x1024.jpg",
          controller: controller,
          caption: "#0",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
          url:
              "https://assets.verticalmag.com/wp-content/uploads/2022/12/V21I6-PhotoContestIssue-FC-400x513.jpg",
          controller: controller,
          caption: "#1",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
        url:
            "https://assets.verticalmag.com/wp-content/uploads/2016/06/v15i1.jpg",
        controller: controller,
        caption: "#2",
        imageFit: BoxFit.cover,
      ),
      StoryItem.pageImage(
          url:
              "https://assets.verticalmag.com/wp-content/uploads/2024/02/V23I1-COV-REG-400x514.jpg",
          controller: controller,
          caption: "#3",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
          url:
              "https://pbs.twimg.com/media/GDFmAx-WsAAT_-M?format=jpg&name=4096x4096",
          controller: controller,
          caption: "#4",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
          url:
              "https://mediakit.mhmpub.com/wp/wp-content/uploads/2022/03/V22I4-FC-scaled-1-scaled-1.jpeg",
          controller: controller,
          caption: "#5",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
          url:
              "https://assets.verticalmag.com/wp-content/uploads/2020/10/V19I5-OCT-FC-400x518.jpg",
          controller: controller,
          caption: "#6",
          imageFit: BoxFit.cover),
      StoryItem.pageImage(
          url:
              "https://assets.verticalmag.com/wp-content/uploads/2023/03/Insight-MEGA-VertFC-798x1024.jpg",
          controller: controller,
          caption: "#7",
          imageFit: BoxFit.cover),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Stories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black87.withOpacity(0.05),
              // Set your desired tint color
              BlendMode.srcATop,
            ),
            child: StoryView(
              inline: false,
              indicatorForegroundColor: Colors.greenAccent,
              storyItems: storyItems,
              controller: controller,
              repeat: true,
              onComplete: () {
                // Do something when the story is completed
                print("Story Completed");
              },
            ),
          ),
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
          //       Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          //     ],
          //   ),
          // ),
          Positioned(
              left: 25,
              bottom: 65,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
          Positioned(
              right: 25,
              bottom: 65,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
