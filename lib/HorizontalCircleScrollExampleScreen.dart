import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//**Using PageViewBuilder

class CircleAvatarListPageScreen extends StatefulWidget {
  @override
  State<CircleAvatarListPageScreen> createState() =>
      _CircleAvatarListPageScreenState();
}

class _CircleAvatarListPageScreenState
    extends State<CircleAvatarListPageScreen> {
  int _selectedIndex = 0;
  bool _isChecked = false;
  Color color = Colors.red;
  String imageString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: color,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        actions: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: _isChecked,
              side: MaterialStateBorderSide.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return BorderSide(color: Colors.white);
                } else {
                  return BorderSide(color: Colors.black87);
                }
              },),
              // side: BorderSide.none,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              checkColor: Colors.black87,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.orangeAccent;
                } else {
                  return Colors.white;
                }
              }),
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
          ),
        ],
        title: Text(
          "Images",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.purple],
              // Define your gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Expanded(
            // child: Container(
            //   decoration: BoxDecoration(
            //     // borderRadius: BorderRadius.circular(10),
            //     image: DecorationImage(
            //       image: NetworkImage(
            //         imageString, // Replace with your image URL
            //       ),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            child: CachedNetworkImage(
              imageUrl: imageString,
              imageBuilder: (context, imageProvider) => ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black87.withOpacity(0.2),
                  // Set your desired tint color
                  BlendMode.srcATop,
                ),
                child: Container(
                  // height: 750,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      //     Colors.orange, BlendMode.colorBurn),
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80, // Height of the circle avatars
                child: CircleAvatarList(
                  callback: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  color: (Color value) {
                    setState(() {
                      color = value;
                    });
                  },
                  image: (String value) {
                    setState(() {
                      imageString = value;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 160.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ), // First icon
                  SizedBox(width: 20), // Spacer between icons
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ), // Second icon
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 5, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleAvatarList extends StatefulWidget {
  final ValueChanged<int> callback;
  final ValueChanged<Color> color;
  final ValueChanged<String> image;

  const CircleAvatarList({
    super.key,
    required this.callback,
    required this.color,
    required this.image,
  });

  @override
  _CircleAvatarListState createState() => _CircleAvatarListState();
}

class _CircleAvatarListState extends State<CircleAvatarList> {
  final List<Color> colorsList = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.orangeAccent,
    Colors.purple,
    Colors.pinkAccent,
    Colors.cyan,
    Colors.lime,
    Colors.brown
  ];

  final List<String> imagesList = [
    "https://images.unsplash.com/photo-1682685796444-acc2f5c1b7b6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
    "https://plus.unsplash.com/premium_photo-1706571989393-f35be42b509b?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
    "https://images.unsplash.com/photo-1682687982502-1529b3b33f85?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8",
    "https://images.unsplash.com/photo-1706402500309-597ba87c8f3a?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1682687218608-5e2522b04673?q=80&w=2875&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1706200234292-66928ea63168?q=80&w=2582&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://plus.unsplash.com/premium_photo-1697778137575-e739b2591416?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1706059925993-42795fd8eef9?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1706474066514-730d8a3cf344?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1682687982134-2ac563b2228b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ];

  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction:
        0.25, // Adjust this value to change the size of the CircleAvatars
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      //itemCount: colorsList.length, // Number of items
      itemCount: imagesList.length, // Number of items
      itemBuilder: (context, index) {
        return GestureDetector(
          // onTap: () {
          //   widget.callback(index + 1);
          //   widget.color(colorsList[index]);
          // },
          child: CircleAvatarItem(
            colors: colorsList,
            index: index,
            pageController: _pageController,
          ),
        );
      },
      onPageChanged: (int index) {
        // widget.callback(index + 1);
        widget.color(colorsList[index]);
        widget.image(imagesList[index]);
        // Handle page change if needed
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CircleAvatarItem extends StatelessWidget {
  final int index;
  final PageController pageController;
  final List<Color> colors;

  const CircleAvatarItem({
    required this.index,
    required this.pageController,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = (pageController.page ?? 0) - index;
          value = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 100,
            // Adjust size based on value
            width: Curves.easeInOut.transform(value) * 100,
            child: child,
          ),
        );
      },
      child: CircleAvatar(
        radius: 30, // Radius of the CircleAvatar
        backgroundColor: colors[index], // Example background color
        child: Text(
          (index + 1).toString(), // Example text inside CircleAvatar
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
