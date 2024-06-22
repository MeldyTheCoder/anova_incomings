import 'package:anova_incomings/src/components/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


typedef SubmitFunc = Future Function(BuildContext, {String username, String password});

class AuthForm extends StatelessWidget {
  AuthForm({
    super.key,
    required this.onSubmit,
  });

  final SubmitFunc onSubmit;
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validateUsername(String? value) {
    if (value != null && value.length < 3) {
      return 'Минимум 2 символа.';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && value.length < 8) {
      return 'Минимум 8 символов.';
    }

    return null;
  }

  Future submitForm(BuildContext context) async {
    final loginSelected = loginController.text;
    final passwordSelected = passwordController.text;
    
    await onSubmit(
      context,
      username: loginSelected,
      password: passwordSelected,
    );

    loginController.text = '';
    passwordController.text = '';
  }

  void handleRegistrationButtonClicked(BuildContext context) {
    Navigator.popAndPushNamed(context, '/registration');
  }


  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 600))
      ],
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SizedBox(
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              semanticContainer: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 15,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Icon(
                            size: 35,
                            Icons.person_2_outlined
                          ),
                        ),

                        Text(
                          'Авторизация',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            obscureText: false,
                            controller: loginController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Логин',
                              prefixIcon: const Icon(Icons.person),
                            ),
                            validator: validateUsername,
                          ),
                        ]
                      )
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Пароль',
                              prefixIcon: const Icon(Icons.password),
                            ),
                            validator: validatePassword,
                          ),
                        ]
                      )               
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await submitForm(context);
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.deepPurple,
                          ),
                          enableFeedback: true,
                        ),
                        child: const Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            Text(
                              'Войти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),

                    const HorizontalOrLine(
                      label: 'или', 
                      height: 2,
                    ),

                    SizedBox(
                      width: 400,
                      child: OutlinedButton(
                        onPressed: () {
                          handleRegistrationButtonClicked(context);
                        },
                        style: const ButtonStyle(
                          enableFeedback: true,
                        ),
                        child: const Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.create_outlined,
                            ),
                            Text(
                              'Создать аккаунт', 
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        )
      ),
    );
  }
}