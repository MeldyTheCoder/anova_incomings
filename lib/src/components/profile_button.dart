import 'package:anova_incomings/src/settings/settings_view.dart';
import 'package:anova_incomings/src/views/auth_view.dart';
import 'package:anova_incomings/src/views/profile_view.dart';
import 'package:anova_incomings/src/views/registration_view.dart';
import 'package:flutter/material.dart';



Widget buildAvatar(BuildContext context, dynamic userData) {
  bool isAuthenticated = userData != null;
  NetworkImage image = const NetworkImage('');

  if (isAuthenticated) {
    image = NetworkImage(userData?.image!);
  }

  return CircleAvatar(
      radius: 30,
      foregroundImage: image,
      child: const Icon(Icons.person),
  );
}

class ProfileModal extends StatelessWidget {
  final dynamic userData;

  const ProfileModal({
    super.key,
    required this.userData,
  });

  List<Widget> buildAuthorizedDialog(BuildContext context) {
    return [
      TextButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, ProfileView.routeName);
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
    bool isAuthenticated = userData != null;
    String userUsername = '???';
    String userEmail = 'example@mail.ru';

    if (isAuthenticated) {
      userUsername = userData?.username ?? '???';
      userEmail = userData?.email ?? 'example@mail.ru';
    }

    return AlertDialog(
      icon: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: <Widget>[
            buildAvatar(context, userData),

            Column(
              children: <Widget>[
                if (isAuthenticated) ...[
                  Text(
                    userUsername,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    userEmail,
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

          if (isAuthenticated) ...buildAuthorizedDialog(context)
          else ...buildUnauthorizedDialog(context)
        ],
      ),
    );
  }
}


class ProfileButton extends StatelessWidget {
  final dynamic userData;

  const ProfileButton({
    super.key,
    required this.userData,
  });

  Future handleAvatarClick(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ProfileModal(userData: userData)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
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