import 'package:flutter/material.dart';
import 'package:placeprep/OOPS/Inheritance.dart';
import 'package:placeprep/OOPS/Oopstask/classobjmcq.dart';
import 'package:placeprep/mcq/screens/codingquiz.dart';
import 'package:placeprep/mcq/screens/quiz_screen.dart';
import 'package:placeprep/theme/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  bool isLoading = true;
  Future<void> simulateLoading() async {
    await Future.delayed(Duration(seconds: 6));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    simulateLoading();
  }

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://www.geeksforgeeks.org/classes-objects-java/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              leading: Builder(
                builder: (context) => InkWell(
                  child: Icon(Icons.menu),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              title: const Text("Class & Object"),
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
              backgroundColor: Colors.white60,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: WebViewWidget(controller: controller),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      drawer: buildMenu(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen()),
          );
        },
        icon: Icon(Icons.assignment),
        label: Text("Take Test"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        elevation: 2.0,
        extendedPadding: EdgeInsets.all(40),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        splashColor: Colors.grey,
        highlightElevation: 8.0, // Adjust the size as needed
      ),

    );
  }
}

Widget buildMenu(BuildContext context) {
  return Drawer(
    child: Container(
      color: AppColor.primary1,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: AppColor.primary1,
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primary1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Positioned(
                    top: 20,
                    right: 14,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 3),
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
                          'assets/images/icon0.png',
                          fit: BoxFit.cover,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'CLASS & OBJECT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          buildMenuItem('Introduction', () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inheritance()),
            );
          }),
          buildMenuItem('Inheritance', () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Class()),
            );
          }),
          buildMenuItem('Polymorphism1', () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inheritance()),
            );
          }),
          buildMenuItem('polymorphism2', () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inheritance()),
            );
          }),
          buildMenuItem('Data Abstraction', () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inheritance()),
            );
          }),
        ],
      ),
    ),
  );
}

Widget buildMenuItem(String title, VoidCallback onTap) {
  return Card(
    elevation: 1, // Add elevation for shadow effect
    color: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.9), // Customize shadow color
    margin: EdgeInsets.fromLTRB(25, 15, 0, 15), // Add margin for spacing
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
      // Set border radius to 20
    ),
    child: ListTile(
      title: Center(child: Text(title)),
      onTap: onTap,
    ),
  );
}
