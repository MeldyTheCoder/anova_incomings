import 'package:anova_incomings/src/components/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

typedef SubmitFunction = Future Function(BuildContext, {String username, String password, String email});

class RegistrationForm extends StatelessWidget {
  final SubmitFunction onSubmit;

  RegistrationForm({
    super.key,
    required this.onSubmit,
  });

  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validateUsername(String? value) {
    if (value != null && value.length < 3) {
      return 'Минимум 2 символа.';
    }

    if (!RegExp(r"^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$").hasMatch(value!)) {
      return 'Некорректное имя пользователя.';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return 'Минимум 8 символов.';
    }

    return null;
  }

  String? validatePasswordRepeat(String? value) {
    if (value!.length < 8) {
      return 'Минимум 8 символов.';
    }

    if (passwordController.text != value) {
      return 'Введенные пароли не совпадают.';
    }

    return null;

  }

  String? validateEmail(String? value) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value!)) {
        return 'Некорректная почта.';
      }

    return null;
  }

  void handleLoginButtonClicked(BuildContext context) {
    Navigator.popAndPushNamed(context, '/login');
  }

  Future submitForm(BuildContext context) async {
    String username = loginController.text;
    String password = passwordController.text;
    String email = emailController.text;

    await onSubmit(
      context,
      username: username,
      password: password,
      email: email,
    );
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
                      alignment: WrapAlignment.center,
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
                          'Регистрация',
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
                            obscureText: false,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Эл. почта',
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: validateEmail,
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

                    const SizedBox(height: 30),

                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            obscureText: true,
                            controller: passwordRepeatController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Повтор пароля',
                              prefixIcon: const Icon(Icons.password),
                            ),
                            validator: validatePasswordRepeat,
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
                              Icons.create_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Зарегистрироваться',
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
                          handleLoginButtonClicked(context);
                        },
                        style: const ButtonStyle(
                          enableFeedback: true,
                        ),
                        child: const Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.login_outlined,
                            ),
                            Text(
                              'Войти', 
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
