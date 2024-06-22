
import 'package:anova_incomings/src/api.dart';
import 'package:anova_incomings/src/auth_provider.dart';
import 'package:anova_incomings/src/components/alert.dart';
import 'package:anova_incomings/src/forms/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


typedef AuthCallback = Future<dynamic> Function(dynamic);

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
  });

  static const routeName = '/login';

  Future handleFormSubmit(BuildContext context, dynamic value, {username, password}) async {
    await ApiManager.login(
      username,
      password,
    ).then(
      (response) async {
        await value.authenticate(
          token: response['token']['access_token'],
        ).then((_) async {
          Navigator.pop(context);
        });
      }
    ).onError((error, _) => 
      showDialog(
        context: context, 
        builder: (_) => TypedAlert(
          alertType: AlertTypes.error,
          content: Text(error.toString(), textAlign: TextAlign.center,)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: AuthForm(
            onSubmit: (context, {dynamic username, dynamic password}) => 
              handleFormSubmit(context, value, username: username, password: password),
          ),
        ),
      )
    );
  }
}