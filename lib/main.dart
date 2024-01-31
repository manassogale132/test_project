import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_project/HomeScreen.dart';
import 'package:test_project/RealEstateScreen.dart';
import 'CheckBoxSelectionExampleScreen.dart';
import 'CustomCameraScreen.dart';
import 'DatePickerExampleScreen.dart';
import 'DropDownUsingExpansionTileExample.dart';
import 'HorizontalCircleScrollExampleScreen.dart';
import 'RazorPayExampleScreen.dart';
import 'RowCircleItems.dart';
import 'controller/MainScreenController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: MyHomePage(
      //   title: 'Razor Pay',
      // ),
      home: ExpansionTileExampleScreen(),
    );
  }
}

// class ContainerWithDynamicColumn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           color: Colors.green,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Container with Dynamic Height Column',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   color: Colors.green.shade70 0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Item 1', style: TextStyle(fontSize: 18)),
//                       Text('Item 2', style: TextStyle(fontSize: 18)),
//                       Text('Item 3', style: TextStyle(fontSize: 18)),
//                       Text('Item 1', style: TextStyle(fontSize: 18)),
//                       Text('Item 2', style: TextStyle(fontSize: 18)),
//                       Text('Item 3', style: TextStyle(fontSize: 18)),
//                       // Add more items as needed
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyGridView extends StatelessWidget {
  final MainScreenController controller =
      Get.put(MainScreenController(), tag: "mainScreenController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBannerContainer(),
            StackedCircleAvatarsWithCount(),
            SizedBox(
              height: 30,
            ),
            DottedLine(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Users.',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.itemsUsersSelected.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changeUsersListSelected(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Card(
                          elevation:
                              controller.itemsUsersSelected[index] ? 2 : 0,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              color: controller.itemsUsersSelected[index]
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          color: controller.itemsUsersSelected[index]
                              ? Colors.green
                              : Colors.grey.shade50,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: controller.itemsUsersSelected[index]
                                    ? Colors.green
                                    : Colors.black54,
                              ),
                            ),
                            title: Text(
                              "John Doe #${index}",
                              style: TextStyle(
                                  color: controller.itemsUsersSelected[index]
                                      ? Colors.white
                                      : Colors.black54),
                            ),
                            subtitle: Text(
                              "Software Engineer",
                              style: TextStyle(
                                  color: controller.itemsUsersSelected[index]
                                      ? Colors.white
                                      : Colors.black54),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: controller.itemsUsersSelected[index]
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}

class TopBannerContainer extends StatelessWidget {
  const TopBannerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1503424886307-b090341d25d1?q=80&w=2952&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        // Adjust the opacity as needed
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 10,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                // Replace with your desired icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RealEstate()));
                },
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                // Replace with your desired icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore top\ndestinations around\nthe world.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
