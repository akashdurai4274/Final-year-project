import 'package:flutter/material.dart';
import 'package:placeprep/OOPS/Introduction.dart';
import 'package:placeprep/theme/color.dart';

class Ooppage extends StatelessWidget {
  // Define a list of names, subnames, and image paths
  final List<String> names = [
    'Introduction',
    'Class & Object',
    'Inheritance',
    'Polymorphism1',
    'Polymorphism2',
    'Abstraction',
    'Encapsulation',
  ];

  final List<String> subnames = [
    'to oops',
    '(Template & Instance)',
    '(Sub & Super)',
    '(overridding)',
    '(overloading)',
    '(hiding)',
    '(wrapping)',
  ];

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
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("OOps"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
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
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          names.length,
          (index) => CardItem(
            name: names[index],
            subname: subnames[index],
            imagePath: imagePaths[index],
            pageToNavigate: index,
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String name;
  final String subname;
  final String imagePath;
  final int pageToNavigate;

  const CardItem({
    required this.name,
    required this.subname,
    required this.imagePath,
    required this.pageToNavigate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(context, pageToNavigate);
      },
      child: Card(
        margin: const EdgeInsets.all(18),
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
                  padding: const EdgeInsets.fromLTRB(30, 65, 20, 0),
                  child: Text(
                    '$name',
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '$subname',
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                )
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
                      offset: const Offset(0, 2),
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
      ),
    );
  }

  void navigateToPage(BuildContext context, int pageIndex) {
    final List<Widget Function(BuildContext)> pageBuilders = [
      (context) => Introduction(),
      (context) => Class(),
      (context) => Inheritance(),
      (context) => Cpolymorphism(),
      (context) => Rpolymorphism(),
      (context) => Abstraction(),
      (context) => Encapsulation(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(builder: pageBuilders[pageIndex]),
    );
  }
}
