import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/HomeScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _token = '';
  String _errorMessage = '';

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String apiUrl =
        'https://dummyjson.com/auth/login'; // Replace with your API endpoint
    var urlParse = Uri.parse(apiUrl);

    final body = jsonEncode({'username': username, 'password': password});

    final response = await http.post(
      urlParse,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _token = responseData['token'];
        _errorMessage = '';
      });
      prefs.setString('token', _token);

      // Navigate to next screen or perform necessary actions upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      var snackBar = SnackBar(
        content: Text(
          'Login Successful!!!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final errorMessage = json.decode(response.body)['message'];
      setState(() {
        _errorMessage = errorMessage;
        _token = '';
      });
      var snackBar = SnackBar(
        content: Text('Error....'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Username - kminchelle",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Password - 0lelplR",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 12.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            // if (_token.isNotEmpty)
            //   Text(
            //     'Token: $_token',
            //     style: TextStyle(color: Colors.green),
            //   ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogListViewExample();
                  },
                );
              },
              child: Text('Load Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

//scrollable
class DialogListViewExample extends StatefulWidget {
  const DialogListViewExample({super.key});

  @override
  State<DialogListViewExample> createState() => _DialogListViewExampleState();
}

class _DialogListViewExampleState extends State<DialogListViewExample> {
  //int? selectedIndex;
  List<bool> selectedItems = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              20), // Adjust the value to change the roundness
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select options',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          //selectedIndex = index;
                          selectedItems[index] = !selectedItems[index];
                        });
                      },
                      child: Card(
                        // color: selectedIndex == index
                        //     ? Colors.grey.withOpacity(0.3)
                        //     : Colors.transparent,
                        color: selectedItems[index]
                            ? Colors.red.withOpacity(0.3)
                            : Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          leading: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: selectedItems[index]
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the value to change the roundness
                            ),
                            child: Center(
                              child: Text(
                                '#${index}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedItems[index]
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            '#Title${index}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            '#SubTitle${index}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Checkbox(
                            //value: selectedIndex == index ? true : false,
                            value: selectedItems[index],
                            activeColor: Colors.black,
                            onChanged: (bool? value) {},
                          ),
                          //selected: selectedIndex == index,
                          selected: selectedItems[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//dynamic size
// class DialogListViewExample extends StatelessWidget {
//   const DialogListViewExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(
//               20), // Adjust the value to change the roundness
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Setting this to min
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 8,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Select options',
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).pop(),
//                       // Close the dialog
//                       child: Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Flexible(
//                 // Use Flexible to allow the ListView to expand within the available space
//                 child: SingleChildScrollView(
//                   // Wrap with SingleChildScrollView
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List.generate(6, (index) {
//                       return ListTile(
//                         leading: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(
//                                 20), // Adjust the value to change the roundness
//                           ),
//                           child: Center(
//                             child: Text(
//                               '#${index}',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           '#Title${index}',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(
//                           '#SubTitle${index}',
//                           style: TextStyle(fontWeight: FontWeight.normal),
//                         ),
//                         trailing: Checkbox(
//                           value: false,
//                           onChanged: (bool? value) {},
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
