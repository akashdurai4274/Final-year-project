import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placeprep/Authentication/login.dart';
import 'package:placeprep/Profile/screens/account_screen.dart';
import 'package:placeprep/Profile/setting.dart';
import 'package:placeprep/theme/color.dart';
import 'package:placeprep/utils/data.dart';
import 'package:placeprep/widgets/custom_image.dart';
import 'package:placeprep/widgets/setting_box.dart';
import 'package:placeprep/widgets/setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  final loginusername;
  const AccountPage({required this.loginusername, Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _image;
  Future<void> _getImage(ImageSource source) async {
    if (_image == null) {
      final pickedFile = await ImagePicker().pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Future<void> _getPic(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _viewImage() {
    if (_image != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 300,
              height: 300,
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _getPic(ImageSource.camera);
                },
                child: Text('Change Image'),
              ),
            ],
          );
        },
      );
    }
  }

  void _otherFeature1() {
    // Add functionality for other feature 1
  }

  void _otherFeature2() {
    // Add functionality for other feature 2
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: AppColor.appBgColor,
          pinned: true,
          snap: true,
          floating: true,
          title: _buildHeader(),
        ),
        SliverToBoxAdapter(child: _buildBody())
      ],
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Account",
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(
            height: 20,
          ),
          _buildRecord(),
          const SizedBox(
            height: 20,
          ),
          _buildSection1(),
          const SizedBox(
            height: 20,
          ),
          _buildSection2(),
          const SizedBox(
            height: 20,
          ),
          _buildSection3(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await _getImage(ImageSource.camera);
            _viewImage();
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? Icon(
              Icons.camera_alt,
              size: 50,
            )
                : null,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.loginusername,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecord() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SettingBox(
            title: "12 courses",
            icon: "assets/icons/work.svg",
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SettingBox(
            title: "55 hours",
            icon: "assets/icons/time.svg",
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SettingBox(
            title: "4.8",
            icon: "assets/icons/star.svg",
          ),
        ),
      ],
    );
  }

  Widget _buildSection1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen(image: _image)));},
            child: SettingItem(
              title: "Setting",
              leadingIcon: "assets/icons/setting.svg",
              bgIconColor: AppColor.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Payment",
            leadingIcon: "assets/icons/wallet.svg",
            bgIconColor: AppColor.green,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Bookmark",
            leadingIcon: "assets/icons/bookmark.svg",
            bgIconColor: AppColor.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSection2() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SettingItem(
            title: "Notification",
            leadingIcon: "assets/icons/bell.svg",
            bgIconColor: AppColor.purple,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Privacy",
            leadingIcon: "assets/icons/shield.svg",
            bgIconColor: AppColor.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildSection3() {
    return GestureDetector(
      onTap: () {
        _logout();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: SettingItem(
          title: "Log Out",
          leadingIcon: "assets/icons/logout.svg",
          bgIconColor: AppColor.darker,
        ),
      ),
    );
  }

  void _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    // Navigate to the login page or any other page after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }
}
