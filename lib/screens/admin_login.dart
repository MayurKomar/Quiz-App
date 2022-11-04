import 'package:flutter/material.dart';
import 'package:quiz_app/screens/questions_list.dart';
import '../widgets/round_button.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});

  static const routeName = 'AdminLogin';
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordController = TextEditingController();

  login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Login")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailEditingController,
              decoration: const InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(Icons.alternate_email)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Password', prefixIcon: Icon(Icons.password)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Login',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (emailEditingController.text == "Admin" &&
                      passwordController.text == "admin") {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        QuestionsList.routeName, ((route) => false));
                  }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
