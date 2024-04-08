import 'package:flutter/material.dart';

class ClassMCQ extends StatefulWidget {
  @override
  _ClassMCQState createState() => _ClassMCQState();
}

class _ClassMCQState extends State<ClassMCQ> {
  List<String> questions = [
    "1. What is a class in Java?",
    "2. What is an object in Java?",
    // Add more questions here
  ];

  List<List<String>> choices = [
    ["A. A blueprint for creating objects", "B. A data type", "C. A method", "D. A variable"],
    ["A. An instance of a class", "B. A method", "C. A data type", "D. A variable"],
    // Add choices for more questions here
  ];

  List<bool> isMultipleChoice = [
    false, // Question 1 is single choice
    true, // Question 2 is multiple choice
    // Add true or false for more questions here
  ];

  List<List<String>> correctAnswers = [
    ["A. A blueprint for creating objects"], // Question 1
    ["A. An instance of a class", "B. A method"], // Question 2
    // Add correct answers for more questions here
  ];

  List<String> selectedAnswers = List.filled(10, "");
  List<bool> isQuestionAnswered = List.filled(10, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MCQ Test'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index],
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  ...List.generate(
                    choices[index].length,
                        (choiceIndex) {
                      return isMultipleChoice[index]
                          ? CheckboxListTile(
                        title: Text(choices[index][choiceIndex]),
                        value: selectedAnswers[index].contains(choices[index][choiceIndex]),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedAnswers[index] += choices[index][choiceIndex] + "; ";
                            } else {
                              selectedAnswers[index] =
                                  selectedAnswers[index].replaceAll(choices[index][choiceIndex] + "; ", "");
                            }
                            isQuestionAnswered[index] = true; // Update the flag when the question is answered
                          });
                        },
                      )
                          : RadioListTile(
                        title: Text(choices[index][choiceIndex]),
                        value: choices[index][choiceIndex],
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value.toString();
                            isQuestionAnswered[index] = true; // Update the flag when the question is answered
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                  isQuestionAnswered[index]
                      ? Text(
                    "Answered",
                    style: TextStyle(color: Colors.green),
                  )
                      : Text(
                    "Not Answered",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Validate if all questions are answered
          bool allQuestionsAnswered = true;
          for (bool answered in isQuestionAnswered) {
            if (!answered) {
              allQuestionsAnswered = false;
              break;
            }
          }
          if (allQuestionsAnswered) {
            // Check answers
            int correctCount = 0;
            for (int i = 0; i < questions.length; i++) {
              List<String> correctAns = correctAnswers[i];
              String selectedAns = selectedAnswers[i].trim();
              if (isMultipleChoice[i]) {
                List<String> selectedAnsList = selectedAns.split("; ").toList();
                if (selectedAnsList.length != correctAns.length) continue;
                bool allCorrect = true;
                for (String ans in selectedAnsList) {
                  if (!correctAns.contains(ans)) {
                    allCorrect = false;
                    break;
                  }
                }
                if (allCorrect) correctCount++;
              } else {
                if (correctAns.length == 1 && correctAns[0] == selectedAns) {
                  correctCount++;
                }
              }
            }
            // Show result
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Result"),
                  content: Text("Your score: $correctCount / ${questions.length}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            // Show error if not all questions are answered
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("Please answer all questions."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
