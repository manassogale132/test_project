import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CustomDialogBox.dart';

class MainScreenController extends GetxController {
  var isCategoriesDrawerOpen = false.obs;

  // var isUsersListSelected = false.obs;

  final List<String> images = [
    'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1604076850742-4c7221f3101b?q=80&w=2731&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1579546929662-711aa81148cf?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1550859492-d5da9d8e45f3?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1614850523459-c2f4c699c52e?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1523821741446-edb2b68bb7a0?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1557682224-5b8590cd9ec5?q=80&w=2858&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // Add more usernames as needed
  ];

  var selectedImages = <String>[].obs;

  var itemsUsersSelected = List.generate(10, (index) => false).obs;

  void addOrRemoveelectedImages(int index) {
    if (!selectedImages.contains(images[index])) {
      selectedImages.add(images[index]);
    } else {
      selectedImages.remove(images[index]);
    }
  }

  void changeDropdownBooleanState() {
    isCategoriesDrawerOpen.value = !isCategoriesDrawerOpen.value;
  }

  void changeUsersListSelected(int index) {
    itemsUsersSelected[index] = !itemsUsersSelected[index];
  }

  void decideSnackbarOrDialog(BuildContext context) {
    if (!selectedImages.isEmpty) {
      selectedImages.clear();
      var snackBar = const SnackBar(
        content: Text('Selection cleared!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'Empty!!!',
            subTitle:
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
            buttonText1: 'Cancel',
            buttonText2: 'OK',
            onPressed1: () {
              Navigator.of(context).pop();
            },
            onPressed2: () {
              // Implement your OK button functionality here
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }
}
