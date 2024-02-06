// Controller class to manage state and API calls
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var isLoading = false.obs;
  var responseData = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Fetch data when the controller is initialized
  //   fetchData();
  // }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        responseData(response.body);
        isLoading(false);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    } finally {
      isLoading(false);
    }
    // update(['updateView']);
    update();
  }

  void clearData() {
    responseData.value = '';
    update();
  }
}

class ApiFetchGetxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX State Management'),
      ),
      body: Center(
        child: GetBuilder<ApiController>(
          // id: 'updateView',
          init: ApiController(),
          builder: (controller) {
            return controller.isLoading.value
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.fetchData();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Background color
                                onPrimary: Colors.white, // Text color
                                elevation: 2, // Shadow depth
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Rounded corners
                                ),
                              ),
                              child: Text(
                                'Fetch Data',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              controller.responseData.value != '' ? 'Data Loaded': 'Empty',
                              style: TextStyle(
                                  color: controller.responseData.value != '' ? Colors.green : Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.clearData();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Background color
                                onPrimary: Colors.white, // Text color
                                elevation: 2, // Shadow depth
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Rounded corners
                                ),
                              ),
                              child: Text(
                                'Clear Data',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(controller.responseData.value),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
