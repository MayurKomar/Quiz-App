import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/utils/db_connect.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddOrEditQuestionScreen extends StatefulWidget {
  const AddOrEditQuestionScreen({super.key});

  static const routeName = 'AddorEdit';

  @override
  State<AddOrEditQuestionScreen> createState() =>
      _AddOrEditQuestionScreenState();
}

class _AddOrEditQuestionScreenState extends State<AddOrEditQuestionScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<String> optionsList = [];

  // ignore: prefer_typing_uninitialized_variables
  var args;
  String selectedValue = '';
  bool isLoading = true;
  String questionId = "";
  String newQuestionId =
      DateFormat("dd-MM-yyyy-hh-mm-ss").format(DateTime.now());

  void updateQuestion(String id) {
    var db = DbConnect();
    db.updateQuestion(Question(
        id: id,
        options: {
          option1Controller.text: option1Controller.text == selectedValue,
          option2Controller.text: option2Controller.text == selectedValue,
          option3Controller.text: option3Controller.text == selectedValue,
          option4Controller.text: option4Controller.text == selectedValue,
        },
        title: questionController.text));
  }

  void addQuestion() {
    var db = DbConnect();
    db.addQuestion(Question(
        id: newQuestionId,
        options: {
          option1Controller.text: option1Controller.text == selectedValue,
          option2Controller.text: option2Controller.text == selectedValue,
          option3Controller.text: option3Controller.text == selectedValue,
          option4Controller.text: option4Controller.text == selectedValue,
        },
        title: questionController.text));
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      if (isLoading) {
        args = ModalRoute.of(context)?.settings.arguments as Question;
        questionController.text = args.title;
        questionId = args.id;
        args.options.forEach((key, value) {
          optionsList.add(key);
          if (value) {
            selectedValue = key;
          }
        });
        option1Controller.text = optionsList[0];
        option2Controller.text = optionsList[1];
        option3Controller.text = optionsList[2];
        option4Controller.text = optionsList[3];
        isLoading = false;
      }
    } else {
      if (isLoading) {
        questionController.text = "";
        questionId = DateTime.now().toString();
        option1Controller.text = "";
        option2Controller.text = "";
        option3Controller.text = "";
        option4Controller.text = "";
        selectedValue = "a";
        isLoading = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? "Edit Question" : "Add Question"),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (ModalRoute.of(context)?.settings.arguments != null) {
                    updateQuestion(args.id);
                    Navigator.pop(context);
                  } else {
                    if (selectedValue == 'a') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select a correct option")));
                    }else{
                      addQuestion();
                      Navigator.pop(context);
                    }
                  }
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: questionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter some question";
                } else {
                  return null;
                }
              },
              decoration:
                  const InputDecoration(hintText: "Enter some question"),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                    value: option1Controller.text,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val!;
                      });
                    }),
                Expanded(
                  child: TextFormField(
                    controller: option1Controller,
                    validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter some option";
                    } else {
                      return null;
                    }
                  },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                    value: option2Controller.text,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val!;
                      });
                    }),
                Expanded(
                  child: TextFormField(
                    controller: option2Controller,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter some option";
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                    value: option3Controller.text,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val!;
                      });
                    }),
                Expanded(
                  child: TextFormField(
                    controller: option3Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter some option";
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                    value: option4Controller.text,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val!;
                      });
                    }),
                Expanded(
                  child: TextFormField(
                    controller: option4Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter some option";
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
