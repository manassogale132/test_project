import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomObject {
  final String name;
  bool isChecked;

  CustomObject({required this.name, this.isChecked = false});
}

class CheckboxListView extends StatefulWidget {
  @override
  _CheckboxListViewState createState() => _CheckboxListViewState();
}

class _CheckboxListViewState extends State<CheckboxListView> {
  bool selectAll = false;
  List<CustomObject> items = List.generate(
    10,
        (index) => CustomObject(name: 'Item $index'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox List View'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: selectAll,
                onChanged: (bool? value) {
                  setState(() {
                    selectAll = value!;
                    items.forEach((item) {
                      item.isChecked = value;
                    });
                  });
                },
              ),
              Text('Select All'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(items[index].name),
                    value: items[index].isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        items[index].isChecked = value!;
                        if (!value) {
                          selectAll = false;
                        } else {
                          selectAll = items.every((item) => item.isChecked);
                        }
                      });
                    },
                    activeColor: Colors.blue, // Customize the active color if needed
                    checkColor: Colors.white, // Customize the check color if needed
                    tileColor: Colors.grey.shade50, // Transparent tile color
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

// Using List.generate()
// class CheckboxListView extends StatefulWidget {
//   @override
//   _CheckboxListViewState createState() => _CheckboxListViewState();
// }
//
// class _CheckboxListViewState extends State<CheckboxListView> {
//   bool selectAll = false;
//   List<bool> checkedList = List.generate(10, (index) => false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkbox List View'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Checkbox(
//                 value: selectAll,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     selectAll = value!;
//                     checkedList = List.generate(10, (index) => value);
//                   });
//                 },
//               ),
//               Text('Select All'),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                   title: Text('Item $index'),
//                   value: checkedList[index],
//                   onChanged: (bool? value) {
//                     setState(() {
//                       checkedList[index] = value!;
//                       if (!value) {
//                         selectAll = false;
//                       } else {
//                         selectAll =
//                             checkedList.every((element) => element == true);
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
