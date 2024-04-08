import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:placeprep/Authentication/config.dart';
import 'package:placeprep/Authentication/login.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
     var regBody={
       "email":emailController.text,
       "password":passwordController.text,
     };
     var response = await http.post(Uri.parse(register),
     headers: {"Content-Type":"application/json"},
     body: json.encode(regBody)
     );
     var jsonresponse = jsonDecode(response.body);

     print(jsonresponse['status']);
     if(jsonresponse['status']==true){
       Navigator.of(context).push(
         MaterialPageRoute(builder: (context) => LoginPage()),
       );
     }
     else{
       print("Something Went Wrong");
     }
    } else {
      setState(() {
        _isNotValidate=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Create an account, It's free",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  makeInput(
                    label: "Email",
                    controller: emailController,
                  ),
                  makeInput(
                    label: "Password",
                    obscureText: true,
                    controller: passwordController,
                  ),
                  makeInput(
                    label: "Confirm Password",
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: registerUser,
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({
    label,
    obscureText = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: () {
            print("Email");
          },
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              errorText: _isNotValidate ? "Enter All the Fields" : null,
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
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
