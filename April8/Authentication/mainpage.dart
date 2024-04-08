import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class mainpage extends StatefulWidget {
  final token;
  const mainpage({required this.token,super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {

  late String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<dynamic,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Text(email),
      ),
    );
  }
}
