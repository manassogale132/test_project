import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  CustomDialogBox({
    required this.title,
    required this.subTitle,
    required this.buttonText1,
    required this.buttonText2,
    required this.onPressed1,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     offset: Offset(0, 1),
        //     blurRadius: 10,
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 25),
          Image.network(
            'https://web-strapi.mrmilu.com/uploads/flutter_logo_470e9f7491.png',
            // URL of the image
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            height: 90,
            width: 90,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Text(
                  'Image not found'); // Placeholder or error message widget
            },
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: onPressed1,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12), backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust border radius as needed
                    ), // Change background color as needed
                  ),
                  child: Text(
                    buttonText1,
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: onPressed2,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12), backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust border radius as needed
                    ), // Change background color as needed
                  ),
                  child: Text(
                    buttonText2,
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
