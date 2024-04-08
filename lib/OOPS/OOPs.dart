import 'package:flutter/material.dart';
import 'package:placeprep/OOPS/ClassandObject.dart';
import 'package:placeprep/OOPS/Data_Abstraction.dart';
import 'package:placeprep/OOPS/Encapsulation.dart';
import 'package:placeprep/OOPS/Inheritance.dart';
import 'package:placeprep/OOPS/Introduction.dart';
import 'package:placeprep/OOPS/Polymorphism/Compile_Polymorphism.dart';
import 'package:placeprep/OOPS/Polymorphism/Run_Polymorphism.dart';

import '../theme/color.dart';

class ooppage extends StatefulWidget {
  @override
  _ooppageState createState() => _ooppageState();
}

class _ooppageState extends State<ooppage> {
  // Define a list of names
  final List<String> names = [
    'Introduction',
    'Class & Object',
    'Inheritance',
    'Polymorphism1',
    'Polymorphism2',
    'Abstraction',
    'Encapsulation',
  ];

  final List<String> subname = [
    'to oops',
    '(Template & Instance)',
    '(Sub & Super)',
    '(overridding)',
    '(overloading)',
    '(hiding)',
    '(wrapping)',
  ];
  // Define a list of image paths
  final List<String> imagePaths = [
    'assets/images/icon1.jpg',
    'assets/images/icon0.png',
    'assets/images/icon2.jpg',
    'assets/images/icon8.png',
    'assets/images/icon9.png',
    'assets/images/icon10.jpg',
    'assets/images/icon7.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              leading: Icon(Icons.menu),
              title: const Text("OOps"),
              titleSpacing: 0.0,
              centerTitle: true,
              toolbarHeight: 60.0,
              toolbarOpacity: 0.8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              elevation: 1.0,
              shadowColor: Colors.grey,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          7,
              (index) => CardItem(
            name: names[index],
                subname:subname[index],// Pass name from the list
            imagePath: imagePaths[index], // Pass image path from the list
            pageToNavigate: index, // Pass the page index to navigate
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String name;
  final String subname;// Add a name parameter
  final String imagePath; // Add an image path parameter
  final int pageToNavigate; // Add a parameter to specify the page to navigate

  const CardItem({
    required this.name,
    required this.imagePath,
    required this.pageToNavigate,
    required this.subname,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page based on the pageToNavigate parameter
        switch (pageToNavigate) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Introduction(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Class(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Inheritance(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cpolymorphism(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Rpolymorphism(),
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Abstraction(),
              ),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Encapsulation(),
              ),
            );
            break;
        // Add more cases for other pages if needed
          default:
            break;
        }
      },
      child: Card(
        margin: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        shadowColor: Colors.grey,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,65,20,0),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text('$subname',style: TextStyle(
                  fontSize: 8,
                ),)
              ],
            ),
            Positioned(
              top: 20,
              right: 14,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}



