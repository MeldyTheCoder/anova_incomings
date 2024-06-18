
import 'package:anova_incomings/src/components/alert.dart';
import 'package:anova_incomings/src/forms/registration_form.dart';
import 'package:anova_incomings/src/views/auth_view.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  static const routeName = '/registration';

  Future handleFormSubmit(
      BuildContext context, 
      {
        username, 
        password, 
        email,
      }
    ) async {

      await showDialog(
        context: context, 
        builder: (_) => const TypedAlert(
          alertType: AlertTypes.success, 
          content: Text.rich(
            TextSpan(
              text: 'Успешная регистрация, теперь войдите в свой новый аккаунт.',
            )
            ,
            textAlign: TextAlign.center,
          ),
        )
      ).then((_) {
        Navigator.popAndPushNamed(context, AuthView.routeName);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: RegistrationForm(
          onSubmit: handleFormSubmit,
        ),
      )
    );
  }
}