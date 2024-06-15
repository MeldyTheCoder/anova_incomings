import 'package:flutter/material.dart';


class AuthFormState extends State<AuthForm> {
  bool submited = false;

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

  void setSubmited(bool value) {
    if (!value) {
      return;
    }

    if (loginController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        builder: (context) => const AlertDialog(
          title: Text('Ошибка'),
          content: Text('Не все поля были заполнены.'),
        ),
        context: context,
      );
      return;
    }

    final loginSelected = loginController.text;

    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Успех'),
        content: Text(
          'Вы успешно вошли в аккаунт "$loginSelected".'
        ),
      ),
      context: context,
    );
    
    setState(() {
      submited = value;
      loginController.text = '';
      passwordController.text = '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          semanticContainer: false,
          margin: const EdgeInsets.only(
            top: 200,
            bottom: 200,
            left: 20,
            right: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.login),
                    SizedBox(width: 10),
                    Text(
                      'Авторизация',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          
                const SizedBox(
                  height: 30,
                ),

                const Divider(),

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
                        autofocus: true,
                        obscureText: false,
                        controller: loginController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Логин',
                          prefixIcon: Icon(Icons.person),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Пароль',
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: validatePassword,
                      ),
                    ]
                  )               
                ),

                const SizedBox(height: 50),

                SizedBox(
                  width: 400,
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setSubmited(true);
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    child: const Text(
                      'Войти', 
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});


  @override
  State<StatefulWidget> createState() {
    return AuthFormState();
  }
}