import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'screens/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:placeprep/Authentication/login.dart';
import 'theme/color.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;

  const MyApp({required this.token, Key? key,
}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Course App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      home: token != null && !JwtDecoder.isExpired(token!) ? RootApp(token: token!) : LoginPage(),
    );
  }
}
