import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart'; // Monokai Sublime theme
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:placeprep/Authentication/config.dart';
import 'package:placeprep/mcq/screens/quiz_screen.dart';
import 'package:placeprep/mcq/screens/result_sreen.dart';

import '../models/question.dart';

class CodingTestScreen extends StatefulWidget {
  const CodingTestScreen({Key? key}) : super(key: key);

  @override
  _CodingTestScreenState createState() => _CodingTestScreenState();
}

class _CodingTestScreenState extends State<CodingTestScreen> {
  late Timer _timer;
  int _secondsRemaining = 300; // 5 minutes timer
  bool _showAnswer = false;
  String _problemStatement = '';
  String _answer = ''; // Variable to hold problem statement
  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    fetchProblemStatement();
    // Set initial value for text field
    _codeController.text = '''class Main {
  public static void main(String[] args) {
    // Your code here
  }
}''';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          // Handle timer completion here
        }
      });
    });
  }

  void fetchProblemStatement() async {
    final response = await http.get(Uri.parse(coding));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        // Assuming the problem statement is a list, take the first element
        _problemStatement = jsonData['problems'][0]['statement'];
        _answer = jsonData['problems'][0]['answer'];
      });
    }
  }

  void submitAnswer() async {
    // Get the user's answer from the text field
    String userAnswer = _codeController.text.trim();

    // Check if the code box is empty
    if (userAnswer.isEmpty) {
      // Show an alert dialog to prompt the user to fill in their code
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please write your code before submitting.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the function without further validation
    }

    // Proceed with answer validation
    print('User Answer: $userAnswer');
    print('Correct Answer: $_answer'); // Add this line for debugging

    bool isCorrect = validateAnswer(userAnswer, _answer);
    if (isCorrect) {
      // Fetch the total number of questions
      final List<Question> questions = await fetchQuestions();
      int totalQuestions = questions.length;

      int score = 100;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(score: score, totalQuestions: totalQuestions)),
      );
    } else {
      // Show a dialog indicating that the answer is incorrect
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incorrect Answer'),
            content: Text('Sorry, your answer is incorrect. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  bool validateAnswer(String userAnswer, String correctAnswer) {
    // Remove leading and trailing whitespaces from user's answer
    userAnswer = userAnswer.trim();
    // Remove leading and trailing whitespaces from correct answer
    correctAnswer = correctAnswer.trim();

    print('User Answer: $userAnswer');
    print('Correct Answer: $correctAnswer');

    // Perform case-insensitive comparison
    bool isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();

    if (isCorrect) {
      // Score the user's answer based on the asymptotic notation
      int score = 100; // Default score
      if (userAnswer.contains('O(1)')) {
        // Best-case scenario
        score = 100;
      } else if (userAnswer.contains('O(n^2)')) {
        // Worst-case scenario
        score = 50;
      } else if (userAnswer.contains('O(log n)')) {
        // Average-case scenario
        score = 75;
      }
      // Display the score
      print('Your score: $score');
    }

    return isCorrect;
  }


  void revealAnswer() {
    setState(() {
      _showAnswer = true;
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coding Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Problem Statement:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily, // Apply JetBrains Mono font
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey[900],
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _problemStatement,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.jetBrainsMono().fontFamily, // Apply JetBrains Mono font
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Start Coding.....',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily, // Apply JetBrains Mono font
                ),
              ),
              _showAnswer
                  ? HighlightView(
                _answer,
                language: 'java', // Set the language to Java
                theme: monokaiSublimeTheme, // Use the Monokai Sublime theme
                padding: EdgeInsets.all(12),
              )
                  : TextField(
                controller: _codeController,
                maxLines: 10,
                readOnly: false, // Enable editing
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily, // Apply JetBrains Mono font
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your code here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[900],
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '$_secondsRemaining seconds remaining',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: !_showAnswer, // Hide when answer is displayed
                child: ElevatedButton(
                  onPressed: submitAnswer,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 29.0, vertical: 10.0),
                    ),
                  ),
                  child: Text('Submit'),
                ),
              ),
              Visibility(
                visible: !_showAnswer, // Hide when answer is displayed
                child: ElevatedButton(
                  onPressed: () {
                    revealAnswer();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 29.0, vertical: 10.0),
                    ),
                  ),
                  child: Text('Give Up'),
                ),
              ),
            ],
          ),

        ]),
      ),
    ));
  }
}
