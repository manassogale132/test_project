import 'package:dotted_line/dotted_line.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<bool> _expansionTileStateList = List.generate(22, (index) => false);

  //bool isExpanded = false;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(
          "FAQ's",
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
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              // key: Key('builder ${selected.toString()}'),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  child: ExpansionTileCard(
                    initiallyExpanded: index == selected,
                    expandedTextColor: Colors.white,
                    onExpansionChanged: ((newState) {
                      if (newState)
                        setState(() {
                          Duration(seconds: 20000);
                          selected = index;
                        });
                      else
                        setState(() {
                          selected = -1;
                        });
                    }),
                    elevation: 5,
                    baseColor: Colors.white,
                    expandedColor: Colors.purple,
                    // key: Key(index.toString()),
                    leading: const CircleAvatar(
                      child: Text(
                        'A',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    title: Text(
                      'Tap me ${index+1}!',
                      style: TextStyle(
                          fontWeight: selected == index
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    subtitle: Text(
                      'I am expanded!',
                    ),
                    children: <Widget>[
                      // const Divider(
                      //   thickness: 1.0,
                      //   height: 1.0,
                      // ),
                      const DottedLine(
                        dashColor: Colors.white,
                        lineThickness: 1,
                        dashLength: 7.0,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi there, I'm a drop-in replacement for Flutter's ExpansionTile",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Use me any time you think your app could benefit from being just a bit more Material.",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "These buttons control the next card down!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      const DottedLine(
                        dashColor: Colors.white,
                        lineThickness: 1,
                        dashLength: 7.0,
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 16.0,
                      //       vertical: 8.0,
                      //     ),
                      //     child: Text(
                      //       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
                      //
                      //     Use me any time you think your app could benefit from being just a bit more Material.
                      //
                      //     These buttons control the next card down!""",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyMedium!
                      //           .copyWith(fontSize: 16),
                      //     ),
                      //   ),
                      // ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              var snackBar = SnackBar(content: Text("Open pressed for ${index} index"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(
                                  'Open',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              var snackBar = SnackBar(content: Text("Closed pressed for ${index} index"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.arrow_upward, color: Colors.white),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              var snackBar = SnackBar(content: Text("Toggle pressed for ${index} index"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.swap_vert, color: Colors.white),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(
                                  'Toggle',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Code of opening multiple
//
// class FaqScreen extends StatefulWidget {
//   const FaqScreen({super.key});
//
//   @override
//   State<FaqScreen> createState() => _FaqScreenState();
// }
//
// class _FaqScreenState extends State<FaqScreen> {
//   List<bool> _expansionTileStateList = List.generate(6, (index) => false);
//   final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
//   final List<GlobalKey<ExpansionTileCardState>> keys = [];
//
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(color: Colors.white),
//         centerTitle: true,
//         title: Text(
//           "FAQ's",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.orange, Colors.purple],
//               // Define your gradient colors
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 8,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _expansionTileStateList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 keys.add(GlobalKey());
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 18.0, vertical: 8.0),
//                   child: Container(
//                     child: ExpansionTileCard(
//                       expandedTextColor: Colors.white,
//                       onExpansionChanged: (value) {
//                         setState(() {
//                           isExpanded = value;
//                         });
//                       },
//                       elevation: 5,
//                       baseColor: Color(0xfff9e6ff),
//                       expandedColor: Colors.purple,
//                       key: keys[index],
//                       leading: const CircleAvatar(
//                         child: Text(
//                           'A',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: Colors.orange,
//                       ),
//                       title: Text(
//                         'Tap me ${index}!',
//                         style: TextStyle(
//                             fontWeight: isExpanded
//                                 ? FontWeight.bold
//                                 : FontWeight.normal),
//                       ),
//                       subtitle: Text(
//                         'I am expanded!',
//                       ),
//                       children: <Widget>[
//                         // const Divider(
//                         //   thickness: 1.0,
//                         //   height: 1.0,
//                         // ),
//                         const DottedLine(
//                           dashColor: Colors.white,
//                           lineThickness: 1.5,
//                           dashLength: 7.0,
//                         ),
//                         SizedBox(
//                           height: 14,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0,
//                             vertical: 8.0,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Hi there, I'm a drop-in replacement for Flutter's ExpansionTile",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 16,
//                               ),
//                               Text(
//                                 "Use me any time you think your app could benefit from being just a bit more Material.",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 16,
//                               ),
//                               Text(
//                                 "These buttons control the next card down!",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Align(
//                         //   alignment: Alignment.centerLeft,
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.symmetric(
//                         //       horizontal: 16.0,
//                         //       vertical: 8.0,
//                         //     ),
//                         //     child: Text(
//                         //       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//                         //
//                         //     Use me any time you think your app could benefit from being just a bit more Material.
//                         //
//                         //     These buttons control the next card down!""",
//                         //       style: Theme.of(context)
//                         //           .textTheme
//                         //           .bodyMedium!
//                         //           .copyWith(fontSize: 16),
//                         //     ),
//                         //   ),
//                         // ),
//                         ButtonBar(
//                           alignment: MainAxisAlignment.spaceAround,
//                           buttonHeight: 52.0,
//                           buttonMinWidth: 90.0,
//                           children: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 keys[index].currentState?.expand();
//                               },
//                               child: Column(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.arrow_downward,
//                                     color: Colors.white,
//                                   ),
//                                   Padding(
//                                     padding:
//                                     EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   Text(
//                                     'Open',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 keys[index].currentState?.collapse();
//                               },
//                               child: Column(
//                                 children: <Widget>[
//                                   Icon(Icons.arrow_upward, color: Colors.white),
//                                   Padding(
//                                     padding:
//                                     EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   Text(
//                                     'Close',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 keys[index].currentState?.toggleExpansion();
//                               },
//                               child: Column(
//                                 children: <Widget>[
//                                   Icon(Icons.swap_vert, color: Colors.white),
//                                   Padding(
//                                     padding:
//                                     EdgeInsets.symmetric(vertical: 2.0),
//                                   ),
//                                   Text(
//                                     'Toggle',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
