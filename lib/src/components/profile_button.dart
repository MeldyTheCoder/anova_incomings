import 'package:anova_incomings/src/auth_provider.dart';
import 'package:anova_incomings/src/components/alert.dart';
import 'package:anova_incomings/src/settings/settings_view.dart';
import 'package:anova_incomings/src/views/auth_view.dart';
import 'package:anova_incomings/src/views/registration_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


typedef LogoutCallback = Future<dynamic> Function();


Widget buildAvatar(BuildContext context, dynamic userData) {
  bool isAuthenticated = userData != null;

  // if (isAuthenticated) {
  //   image = NetworkImage('');
  // }

  return const CircleAvatar(
      radius: 30,
      child: Icon(Icons.person),
  );
}

class ProfileModal extends StatelessWidget {
  final dynamic userData;
  final LogoutCallback onLogout;

  const ProfileModal({
    super.key,
    required this.userData,
    required this.onLogout,
  });

  List<Widget> buildAuthorizedDialog(BuildContext context) {
    return [
      TextButton.icon(
        onPressed: () {
          // Navigator.restorablePushNamed(context, ProfileView.routeName);
          showDialog(
            context: context, 
            builder: (_) => const TypedAlert(
              alertType: AlertTypes.error, 
              content: Text(
                'Данная функция находится в разработке.',
                textAlign: TextAlign.center,
              )
            )
          );
        },
        label: const Text('Профиль'),
        icon: const Icon(Icons.person_rounded),
      ),

      TextButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        }, 
        label: const Text('Настройки'),
        icon: const Icon(Icons.settings_rounded),
      ),

      const Divider(),

      TextButton.icon(
        onPressed: () {
          onLogout();
          Navigator.popAndPushNamed(context, AuthView.routeName);
        },
        label: const Text(
          'Выход',
          style: TextStyle(
            color: Colors.red
          ),
        ),
        icon: const Icon(Icons.logout_rounded),
        style: const ButtonStyle(
          iconColor: WidgetStatePropertyAll(Colors.red),
        ),
      ),
    ];
  }

  List<Widget> buildUnauthorizedDialog(BuildContext context) {
    return [
      TextButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, AuthView.routeName);
        },
        label: const Text('Войти в аккаунт'),
        icon: const Icon(Icons.login_rounded),
      ),

      TextButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, RegistrationView.routeName);
        }, 
        label: const Text('Создать новый аккаунт'),
        icon: const Icon(Icons.create_rounded),
      ),

      const Divider(),

      TextButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        }, 
        label: const Text('Настройки'),
        icon: const Icon(Icons.settings_rounded),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => AlertDialog(
        icon: Center(
          heightFactor: 1,
          widthFactor: 1,
          child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: <Widget>[
              buildAvatar(context, value.user),

              Column(
                children: <Widget>[
                  if (value.user != null) ...[
                    Text(
                      value.user.username,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value.user.email,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ]

                  else ...[
                    const Text(
                      'Аккаунт',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ]
                ],
              )
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Divider(),

            if (value.user != null) ...buildAuthorizedDialog(context)
            else ...buildUnauthorizedDialog(context)
          ],
        ),
      )
    );
  }
}


class ProfileButton extends StatelessWidget {
  final dynamic userData;
  final LogoutCallback onLogout;

  const ProfileButton({
    super.key,
    required this.userData,
    required this.onLogout,
  });

  Future handleAvatarClick(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ProfileModal(userData: userData, onLogout: onLogout,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () => handleAvatarClick(context),
        child: buildAvatar(context, userData),
      ),
    );
  }
}