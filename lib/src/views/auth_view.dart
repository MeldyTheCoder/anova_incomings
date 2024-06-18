
import 'package:anova_incomings/src/auth_manager.dart';
import 'package:anova_incomings/src/components/alert.dart';
import 'package:anova_incomings/src/forms/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  static const routeName = '/login';

  Future handleFormSubmit(BuildContext context, {username, password}) async {
    
    showDialog(
      builder: (context) => TypedAlert(
        alertType: AlertTypes.success, 
        content: Text.rich(
          TextSpan(
            text: 'Вы успешно авторизовались как ',
            children: <TextSpan>[
              TextSpan(
                text: username,
                style: const TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ]
          ),
          textAlign: TextAlign.center, 
        ), 
      ),
      context: context,
    ).then((_) async {
      await AuthManager.authenticate(
        token: 'eirjgierjgioerjgierjfikfengfujnergikerg'
      ).then((_) => Navigator.pop(context));
    });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: AuthForm(
          onSubmit: handleFormSubmit,
        ),
      ),
    );
  }
}