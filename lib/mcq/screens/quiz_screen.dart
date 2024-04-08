import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:placeprep/Authentication/config.dart';
import '../screens/result_sreen.dart';
import 'package:http/http.dart' as http;

import '../models/question.dart';
// import '../models/questions.dart';
import '../widgets/answer_card.dart';
import '../widgets/next_button.dart';
// Replace with your API URL

Future<List<Question>> fetchQuestions() async {
  final response = await http.get(Uri.parse(classobj));
  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    print(response.body);
    if (data is List) {
      List<Question> questions = data.map((json) => Question.fromJson(json)).toList();
      return questions;
    } else if (data is Map<String, dynamic>) {
      List<Question> questions = [Question.fromJson(data)];
      return questions;
    } else {
      throw Exception('Invalid data format');
    }
  } else {
    throw Exception('Failed to load questions');
  }
}


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  late Timer _timer;
  int _secondsRemaining = 15;
  late List<Question> questions=[];

  @override
  void initState() {
    super.initState();
    getQuestionsAndStartTimer();
  }

  Future<void> getQuestionsAndStartTimer() async {
    questions = await fetchQuestions();
    startTimer();
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
          goToNextQuestion();
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _secondsRemaining = 15;
    });
    _timer.cancel(); // Cancel the existing timer before starting a new one
    startTimer();
  }

  void pickAnswer(int value) {
    resetTimer();
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    resetTimer();
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '$_secondsRemaining seconds remaining',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedAnswerIndex == null
                      ? () => pickAnswer(index)
                      : null,
                  child: AnswerCard(
                    currentIndex: index,
                    question: question.options[index],
                    isSelected: selectedAnswerIndex == index,
                    selectedAnswerIndex: selectedAnswerIndex,
                    correctAnswerIndex: question.correctAnswerIndex,
                  ),
                );
              },
            ),
            isLastQuestion
                ? RectangularButton(
              onPressed: () {
                // Inside QuizScreen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      score: score,
                      totalQuestions: questions.length, // Pass the total number of questions
                    ),
                  ),
                );

              },
              label: 'Finish',
            )
                : RectangularButton(
              onPressed: selectedAnswerIndex != null
                  ? goToNextQuestion
                  : null,
              label: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
