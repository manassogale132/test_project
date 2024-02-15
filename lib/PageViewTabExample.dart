import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class CustomSegmentedControlDemo extends StatefulWidget {
  @override
  _CustomSegmentedControlDemoState createState() =>
      _CustomSegmentedControlDemoState();
}

class _CustomSegmentedControlDemoState
    extends State<CustomSegmentedControlDemo> {
  int _currentSelection = 0;
  int _currentSelectionTwo = 0;
  BorderRadius dynamicBorder = const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Segmented Control Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSlidingSegmentedControl<int>(
              fromMax: false,
              innerPadding: EdgeInsets.zero,
              children: {
                0: Center(
                  child: Text(
                    "FLIGHTS",
                    style: TextStyle(
                      color:
                          _currentSelection == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                1: Center(
                  child: Text(
                    "TRAINS",
                    style: TextStyle(
                      color:
                          _currentSelection == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                2: Center(
                  child: Text(
                    "HOTELS",
                    style: TextStyle(
                      color:
                          _currentSelection == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              },
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: 20,
              thumbDecoration: BoxDecoration(
                borderRadius: dynamicBorder,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.7, 0.0),
                  colors: [
                    Color(0xff5851db),
                    Color(0xffe1306c),
                  ],
                ),
              ),
              onValueChanged: (int value) {
                setState(() {
                  _currentSelection = value;
                });
                switch (value) {
                  case 0:
                    setState(() {
                      dynamicBorder = const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(0),
                      );
                    });
                    break;
                  case 1:
                    setState(() {
                      dynamicBorder = const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(0),
                      );
                    });
                    break;
                  case 2:
                    setState(() {
                      dynamicBorder = const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      );
                    });
                    break;
                  default:
                }
              },
            ),
            SizedBox(height: 20),
            Text('Selected Index: $_currentSelection'),
            SizedBox(height: 50),
            SizedBox(
              height: 40,
              child: CustomSlidingSegmentedControl<int>(
                fromMax: false,
                innerPadding: EdgeInsets.zero,
                children: {
                  0: Center(
                    child: Icon(
                      Icons.monetization_on,
                      color: _currentSelectionTwo == 0
                          ? Colors.white
                          : Colors.grey.shade500,
                      size: 20,
                    ),
                  ),
                  1: Center(
                    child: Icon(
                      Icons.money,
                      color: _currentSelectionTwo == 1
                          ? Colors.white
                          : Colors.grey.shade500,
                      size: 20,
                    ),
                  ),
                },
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: 20,
                thumbDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: _currentSelectionTwo == 0
                        ? Radius.circular(20)
                        : Radius.zero,
                    bottomLeft: _currentSelectionTwo == 0
                        ? Radius.circular(20)
                        : Radius.zero,
                    topRight: _currentSelectionTwo == 1
                        ? Radius.circular(20)
                        : Radius.zero,
                    bottomRight: _currentSelectionTwo == 1
                        ? Radius.circular(20)
                        : Radius.zero,
                  ),
                  border: _currentSelectionTwo == 0 || _currentSelectionTwo == 1
                      ? Border.all(color: Colors.grey.shade100, width: 1.5)
                      : null, // Border only for selected items
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.7, 0.0),
                    colors: [
                      Colors.blueAccent,
                      Colors.greenAccent,
                    ],
                  ),
                ),
                onValueChanged: (int value) {
                  setState(() {
                    _currentSelectionTwo = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Selected Index: $_currentSelectionTwo'),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
//
// class CustomSegmentedControlDemo extends StatefulWidget {
//   @override
//   _CustomSegmentedControlDemoState createState() =>
//       _CustomSegmentedControlDemoState();
// }
//
// class _CustomSegmentedControlDemoState
//     extends State<CustomSegmentedControlDemo> {
//   int _currentSelection = 0;
//   Color color = Colors.black;
//   BorderRadius dynamicBorder = const BorderRadius.only(
//     topLeft: Radius.circular(20),
//     bottomLeft: Radius.circular(20),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Segmented Control Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomSlidingSegmentedControl<int>(
//               fromMax: false,
//               innerPadding: EdgeInsets.zero,
//               children: {
//                 0: Center(
//                   child: Text(
//                     "FLIGHTS",
//                     style: TextStyle(color: color),
//                   ),
//                 ),
//                 1: Center(
//                   child: Text(
//                     "TRAINS",
//                     style: TextStyle(color: color),
//                   ),
//                 ),
//                 2: Center(
//                   child: Text(
//                     "HOTELS",
//                     style: TextStyle(color: color),
//                   ),
//                 ),
//               },
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: 20,
//               thumbDecoration: BoxDecoration(
//                 borderRadius: dynamicBorder,
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment(0.7, 0.0),
//                   colors: [
//                     Color(0xff5851db),
//                     Color(0xffe1306c),
//                   ],
//                 ),
//               ),
//               onValueChanged: (int value) {
//                 setState(() {
//                   _currentSelection = value;
//                   color = Colors.white;
//                 });
//                 switch (value) {
//                   case 0:
//                     setState(() {
//                       dynamicBorder = const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(0),
//                         topRight: Radius.circular(0),
//                       );
//                     });
//                     break;
//                   case 1:
//                     setState(() {
//                       dynamicBorder = const BorderRadius.only(
//                         topLeft: Radius.circular(0),
//                         bottomLeft: Radius.circular(0),
//                         bottomRight: Radius.circular(0),
//                         topRight: Radius.circular(0),
//                       );
//                     });
//                     break;
//                   case 2:
//                     setState(() {
//                       dynamicBorder = const BorderRadius.only(
//                         topLeft: Radius.circular(0),
//                         bottomLeft: Radius.circular(0),
//                         bottomRight: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       );
//                     });
//                     break;
//                   default:
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             Text('Selected Index: $_currentSelection'),
//           ],
//         ),
//       ),
//     );
//   }
// }
