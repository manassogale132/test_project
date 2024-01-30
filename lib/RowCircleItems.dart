import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'CustomDialogBox.dart';
import 'controller/MainScreenController.dart';

class StackedCircleAvatarsWithCount extends StatefulWidget {
  @override
  State<StackedCircleAvatarsWithCount> createState() =>
      _StackedCircleAvatarsWithCountState();
}

class _StackedCircleAvatarsWithCountState
    extends State<StackedCircleAvatarsWithCount> {
  // bool isCategoriesDrawerOpen = false;
  //
  // final List<String> images = [
  //   'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1604076850742-4c7221f3101b?q=80&w=2731&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1579546929662-711aa81148cf?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1550859492-d5da9d8e45f3?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1614850523459-c2f4c699c52e?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1523821741446-edb2b68bb7a0?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   'https://images.unsplash.com/photo-1557682224-5b8590cd9ec5?q=80&w=2858&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //   // Add more usernames as needed
  // ];
  //
  // final List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller =
        Get.find(tag: 'mainScreenController');

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Other Categories.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.decideSnackbarOrDialog(context);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Stack(
                children: [
                  //dropdown container list view is behind
                  buildCustomDropDownList(),
                  //searchview view
                  buildCustomDropDown(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility buildCustomDropDownList() {
    final MainScreenController controller =
        Get.find(tag: 'mainScreenController');

    return Visibility(
      visible: controller.isCategoriesDrawerOpen.value ? true : false,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 1.5, // Border width s
          ),
        ),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: controller.images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: index == 0
                    ? EdgeInsets.only(top: 5)
                    : EdgeInsets.only(top: 0),
                child: GestureDetector(
                  onTap: () {
                    controller.addOrRemoveelectedImages(index);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        controller.selectedImages
                                .contains(controller.images[index])
                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmxksH2Foo1LoAB0DIANk3LIZOamiDFsVNNAV3W_5spw&s"
                            : controller.images[index],
                      ), // Replace with actual image URLs
                    ),
                    subtitle: Text(
                      'TitLorem ipsum may be used as a placeholder before final copy is available.',
                    ),
                    title: Text(
                      'Title',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildCustomDropDown() {
    final MainScreenController controller =
        Get.find<MainScreenController>(tag: 'mainScreenController');

    return GestureDetector(
      onTap: () {
        controller.changeDropdownBooleanState();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // Background color
          borderRadius: BorderRadius.circular(50.0),
          // Rounded corners
          border: Border.all(
            color: Colors.black54, // Border color
            width: 1.5, // Border width
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              controller.selectedImages.isEmpty
                  ? Expanded(
                      child: Text(
                        "Select item dropdown",
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectedImages.length > 4
                            ? 5
                            : controller.selectedImages.length,
                        itemBuilder: (context, index) {
                          if (index < 4) {
                            return Align(
                              widthFactor: 0.45,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade700,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black87.withOpacity(0.1),
                                    // Set your desired tint color
                                    BlendMode.srcATop,
                                  ),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(controller
                                            .selectedImages[
                                        index]), // Replace with actual image URLs
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  '+${controller.selectedImages.length - 4}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
              SizedBox(
                width: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
