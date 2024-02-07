import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeomorphicDesigneExampleScreen extends StatelessWidget {
  const NeomorphicDesigneExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color baseColor = Colors.blueAccent.shade400;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Data List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ClayContainer(
                    color: baseColor,
                    height: 130,
                    width: 130,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 50,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ClayContainer(
              color: baseColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ClayText("Seize the Clay!", emboss: true, size: 35),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 100,
                ),
                SizedBox(
                  width: 30,
                ),
                ClayContainer(
                  emboss: true,
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 50,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  customBorderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(150, 150),
                      bottomLeft: Radius.circular(50)),
                ),
                SizedBox(
                  width: 30,
                ),
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 75,
                  depth: 40,
                  spread: 15,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 75,
                  curveType: CurveType.concave,
                ),
                SizedBox(width: 50),
                ClayContainer(
                  color: baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 75,
                  curveType: CurveType.none,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ClayContainer(
              color: baseColor,
              height: 150,
              width: 150,
              borderRadius: 75,
              curveType: CurveType.convex,
            ),
          ],
        ),
      ),
    );
  }
}
