import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/LoginTokenExampleScreen.dart';
import 'package:test_project/main.dart';
import 'package:test_project/model/Posts.dart';

import 'FAQScreen.dart';
import 'RealEstateScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<Widget> _pages = [
    // Add your pages/widgets here
    Text('Page 1'),
    Text('Page 2'),
    Text('Page 3'),
  ];

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  int _selectedIndex =
      -1; // changed bool to int and set value to -1 on first time if you don't select anything otherwise set 0 to set first one as selected.

  final List<String> names = [
    "Rajesh",
    "Mohit",
    "Saket",
    "Harsh",
    "Ayan",
    "Max",
    "Adarsh"
  ];

  final List<String> imageUrls = [
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMTQ2NTEtaW1hZ2Uta3d2eWQybmIuanBn.jpg',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMTQ2NTEtaW1hZ2Uta3d2eWQybmIuanBn.jpg',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L25zMTQ2NTEtaW1hZ2Uta3d2eWQybmIuanBn.jpg',
    // Add more image URLs
  ];

  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    // Add more item names
  ];

  bool isUsersDropdownVisible = false;

  late SharedPreferences prefs;

  Future<void> _loadContent() async {
    prefs = await SharedPreferences.getInstance();
    // Simulate a delay of 3 seconds
    await Future.delayed(Duration(seconds: 3));
    // After 3 seconds, set isLoading to false to hide the progress indicator
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('jwt token--- ${jwt}');
    _loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedFontSize: 14,
        selectedItemColor: Colors.deepOrange,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.deepOrange,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.deepOrange,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
      // appBar: const PreferredSize(
      //     preferredSize: Size.fromHeight(50), child: CustomAppBar()),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SliderDrawer(
              isDraggable: false,
              appBar: const SliderAppBar(
                  appBarPadding: EdgeInsets.only(top: 60),
                  appBarHeight: 100,
                  appBarColor: Colors.white,
                  drawerIconSize: 24,
                  title: Text("Wylth®",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700))),
              key: _sliderDrawerKey,
              slider: Container(
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   topRight: Radius.circular(16.0),
                        //   //bottomRight: Radius.circular(16.0),
                        // ),
                        // Rounded corners for the container
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.purple],
                          // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border(
                          right: BorderSide(
                            //                   <--- right side
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Wylth®',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // DottedLine(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_activity_rounded,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Loans",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // DottedLine(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "SIP",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // DottedLine(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                _sliderDrawerKey.currentState?.closeSlider();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RealEstate()),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.landscape,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Real Estate",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // DottedLine(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_activity_rounded,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Mutual Funds",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // DottedLine(),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FaqScreen()),
                                );
                                if (_sliderDrawerKey
                                    .currentState!.isDrawerOpen) {
                                  _sliderDrawerKey.currentState?.closeSlider();
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "FAQ's",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                              primary: Colors.red,
                              textStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Version 1.0',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 20.0, top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(fontSize: 22),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.login,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  prefs.setString('token', "");
                                  print('jwt token--- ${jwt}');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.orange, Colors.purple],
                                        // Gradient colors
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        18.0,
                                      ), // Rounded corners
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.2,
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.transparent,
                                      child: Center(
                                        child: Text(
                                          "A", // Display the first letter of the name
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    right: -2,
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      child: const CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.greenAccent,
                                        child: null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: imageUrls[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.orange, BlendMode.colorBurn),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      items[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 180.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      // PreferredSize(
                      //     preferredSize: Size.fromHeight(20), child: CustomAppBar()),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isUsersDropdownVisible = !isUsersDropdownVisible;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            // Rounded corners
                            border: Border.all(
                              color: Colors.black45, // Border color
                              width: 1.0, // Border width
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      height: 33,
                                      width: 33,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.purple
                                          ],
                                          // Gradient colors
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          18.0,
                                        ), // Rounded corners
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.2,
                                        ),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.transparent,
                                        child: Center(
                                          child: Text(
                                            "A",
                                            // Display the first letter of the name
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Rohit",
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: IconButton(
                                    padding: EdgeInsets.all(0.0),
                                    color: Colors.black,
                                    icon: Icon(Icons.arrow_drop_down_rounded,
                                        size: 18.0),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      isUsersDropdownVisible
                          ? Container(
                              height: 250,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: names.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = index;
                                        });
                                      },
                                      child: Card(
                                        elevation:
                                            _selectedIndex == index ? 1 : 0,
                                        color: Color(0xfff5f7f6),
                                        child: ListTile(
                                          leading: _selectedIndex == index
                                              ? Icon(
                                                  Icons.circle,
                                                  color: Colors.green,
                                                  size: 10,
                                                )
                                              : Icon(
                                                  Icons.circle,
                                                  color: Colors.red,
                                                  size: 10,
                                                ),
                                          trailing: _selectedIndex == index
                                              ? Text(
                                                  "✓",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 20),
                                                )
                                              : Text(
                                                  "+",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                          title: Text(
                                            names[index],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Active policies", // Display the first letter of the name
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      ActivePoliyCardWidget(
                        name: 'Rohit',
                        policyName: 'Team Life | HQ8789ANH0',
                        policyCompanyname: 'HDFC life term insurance',
                        validityStatus: 'Expiring in 5 days',
                        coverAmount: '₹1,20,560',
                        premiumAmount: '₹4,000/pm',
                        policyActionText: 'Renew',
                        isExpired: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ActivePoliyCardWidget(
                        name: 'Rohit',
                        policyName: 'Motor Insurane | MO8789A09',
                        policyCompanyname: 'National Insurance',
                        validityStatus: 'Valid till 20 Mar 2023',
                        coverAmount: '₹6,10,560',
                        premiumAmount: '₹6,500/pm',
                        policyActionText: 'View policy',
                        isExpired: false,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ActivePoliyCardWidget(
                        name: 'Akshit',
                        policyName: 'Motor Insurane | MO8789A09',
                        policyCompanyname: 'Inter-Continental Insurance',
                        validityStatus: 'Valid till 20 Mar 2023',
                        coverAmount: '₹6,10,560',
                        premiumAmount: '₹6,500/pm',
                        policyActionText: 'View policy',
                        isExpired: false,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       height: 35,
                      //       width: MediaQuery.of(context).size.width * 0.4,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey.shade100,
                      //         borderRadius: BorderRadius.circular(6),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Expanded(
                      //             flex: 2,
                      //             child: Container(
                      //               height: 35,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.green,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(6),
                      //                   bottomLeft: Radius.circular(6),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 children: [
                      //                   Text(
                      //                     '3000',
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontWeight: FontWeight.bold),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 2,
                      //                   ),
                      //                   Icon(
                      //                     Icons.keyboard_arrow_down,
                      //                     color: Colors.white,
                      //                     size: 14.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 12,
                      //           ),
                      //           Expanded(
                      //             flex: 3,
                      //               child: Padding(
                      //             padding: const EdgeInsets.only(right: 8.0),
                      //             child: Text('Page 1 of 10'),
                      //           ))
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                          size: 14.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text('Page 1 of 1000'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DottedLine(),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16.0), // Rounded corners
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            // Rounded corners for the container
                            gradient: LinearGradient(
                              colors: [Colors.orange, Colors.purple],
                              // Gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      iconSize: 60,
                                      icon: const Icon(
                                        Icons.paypal_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // do something
                                      },
                                    ),
                                    Text(
                                      textAlign: TextAlign.end,
                                      'Unlock the true potential\nof your business!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    // Rounded corners for the container
                                    color: Color(0xFF242754),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Get instant business loans',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            // do something
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Get insurance", // Display the first letter of the name
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.orange, Colors.purple],
                                        // Gradient colors
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          18.0), // Rounded corners
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.car_repair_sharp,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Four Wheeler',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 65,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.purple
                                          ],
                                          // Gradient colors
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            18.0), // Rounded corners
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.pedal_bike,
                                          color: Colors.white,
                                          size: 36.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Two Wheeler',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.orange, Colors.purple],
                                        // Gradient colors
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          18.0), // Rounded corners
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.warehouse_sharp,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Real Estate',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                      //   child: GridView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     shrinkWrap: true,
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 3,
                      //       crossAxisSpacing: 10.0,
                      //       mainAxisSpacing: 10.0,
                      //     ),
                      //     itemCount: 4, // Number of items in the grid
                      //     itemBuilder: (context, index) {
                      //       return GridViewItemWidget(); // Custom grid item widget
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class GridViewItemWidget extends StatelessWidget {
  const GridViewItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var generatedColor = Random().nextInt(Colors.primaries.length);

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      child: Center(
        child: Icon(
          Icons.star,
          color: Colors.white,
          size: 36.0,
        ),
      ),
    );
  }
}

class ActivePoliyCardWidget extends StatelessWidget {
  final String name;
  final String policyName;
  final String policyCompanyname;
  final String validityStatus;
  final String coverAmount;
  final String premiumAmount;
  final String policyActionText;
  final bool isExpired;

  const ActivePoliyCardWidget({
    super.key,
    required this.name,
    required this.policyName,
    required this.policyCompanyname,
    required this.validityStatus,
    required this.coverAmount,
    required this.premiumAmount,
    required this.policyActionText,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  child: const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.blue,
                    child: null,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  name,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              policyName,
              style: TextStyle(color: Colors.black26, fontSize: 12),
            ),
            Text(
              policyCompanyname,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Text(
              validityStatus,
              style: isExpired
                  ? TextStyle(color: Colors.red, fontSize: 12)
                  : TextStyle(color: Colors.green, fontSize: 12),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cover amount',
                          style: TextStyle(color: Colors.black26, fontSize: 16),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          coverAmount,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium",
                          style: TextStyle(color: Colors.black26, fontSize: 16),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          premiumAmount,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  policyActionText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.greenAccent),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: const Text(
        'Home',
      ),
      // leading: IconButton(
      //   icon: const Icon(
      //     Icons.menu,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {
      //     // do something
      //   },
      // ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            // do something
          },
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.purple],
              // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0), // Rounded corners
          ),
          child: const CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Text(
                "A", // Display the first letter of the name
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
