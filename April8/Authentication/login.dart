import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:placeprep/Authentication/signup.dart';
import 'package:http/http.dart' as http;
import 'package:placeprep/Authentication/config.dart';
import 'package:placeprep/screens/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isNotValidate = false;
  late SharedPreferences pref;
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
    super.initState();
  }

  void initSharedPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  bool isPressed = false;

  void loginuser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: json.encode(regBody));
      var jsonresponse = jsonDecode(response.body);
      print(jsonresponse);

      if (jsonresponse['status'] == true) {
        var MyToken = jsonresponse['token'];
        print(MyToken);
        pref.setString('token', MyToken);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => RootApp(
                    token: MyToken,
                  )),
        );
      } else {
        _showMyDialog();
      }
    } else {
      setState(() {
        isNotValidate = true;
      });
    }
  }

  //
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wrong UserName or Password'),
                Text('use Corrct Crendtials'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1),
                      FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: makeInput(
                              label: "Username", controller: emailController),
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: makeInput(
                              label: "Password",
                              obscureText: true,
                              controller: passwordController),
                        ),
                      ],
                    ),
                  ),
                  // FadeInUp(
                  //   duration: Duration(milliseconds: 1400),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 40),
                  //     child: Container(
                  //       padding: EdgeInsets.only(top: 3, left: 3),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(50),
                  //         border: Border(
                  //           bottom: BorderSide(color: Colors.black),
                  //           top: BorderSide(color: Colors.black),
                  //           left: BorderSide(color: Colors.black),
                  //           right: BorderSide(color: Colors.black),
                  //         ),
                  //       ),
                  //       child: MaterialButton(
                  //         minWidth: double.infinity,
                  //         height: 60,
                  //         onPressed: () {loginuser();},
                  //         color: Colors.greenAccent,
                  //         elevation: 0,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //         ),
                  //         child: Text(
                  //           "Login",
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 18,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // FadeInUp(
                  //   duration: Duration(milliseconds: 1200),
                  //   child: GestureDetector(
                  //     onLongPress: () {
                  //       loginuser();
                  //     },
                  //     // child: Container(
                  //     //   padding: EdgeInsets.all(1),
                  //     //   decoration: BoxDecoration(
                  //     //     shape: BoxShape.circle,
                  //     //     color: Colors.white,
                  //     //   ),
                  //     child: AnimatedContainer(
                  //       duration: Duration(milliseconds: 300),
                  //       padding: EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(color: Colors.greenAccent, width: 2),
                  //       ),
                  //       child: Image.asset(
                  //         'assets/images/icon5.png', // Replace with your image path
                  //         width: 65, // Adjust size as needed
                  //         height: 65, // Adjust size as needed
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: GestureDetector(
                      onLongPressStart: (details) {
                        setState(() {
                          // Set a flag to control the animation
                          isPressed = true;
                        });
                      },
                      onLongPressEnd: (details) {
                        setState(() {
                          // Reset the flag when long-press ends
                          isPressed = false;
                          loginuser();
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Original login image
                          Image.asset(
                            'assets/images/icon5.png', // Replace with your empty image path
                            width: 65,
                            height: 65,
                          ),
                          // Animated fingerprint GIF
                          isPressed
                              ? Image.asset(
                                  'assets/images/ripple.gif', // Replace with your fingerprint GIF path
                                  width: 80,
                                  height: 80,
                                )
                              : Container(), // Hide the GIF when not pressed
                        ],
                      ),
                    ),
                  ),

                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeInput(
      {label, obscureText = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 1),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: isNotValidate ? "Fill all feilds" : null,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
