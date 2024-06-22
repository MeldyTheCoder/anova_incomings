import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


enum AlertTypes { 
  success, 
  error, 
  warning 
}

typedef CloseCallback = void Function(bool);

class TypedAlert extends StatelessWidget {
  final AlertTypes alertType;
  final Widget content;
  final String? title;
  final Widget? icon;
  final CloseCallback? onClose;


  const TypedAlert({
    super.key,
    required this.alertType,
    required this.content,
    this.title,
    this.icon,
    this.onClose,
  });

  void handleDismissButton(BuildContext context) {
    Navigator.pop(context, false);
  }

  Widget buildIcon(BuildContext context) {
    if (icon != null) {
      return icon!;
    }

    switch (alertType) {
      case AlertTypes.error:
        return const Icon(
          Icons.error,
          color: Colors.red,
          size: 60,
        );

      case AlertTypes.success:
        return const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 60,
        );

      case AlertTypes.warning:
        return const Icon(
          Icons.warning_amber_rounded,
          color: Colors.yellow,
          size: 60,
        );

      default:
        return const Icon(
          Icons.info_outline,
          color: Colors.lightBlue,
          size: 60,
        );
    }
  }

  Widget buildTitle(BuildContext context) {
    const TextStyle style = TextStyle(
      fontSize: 20,
    );

    if (title != null && title!.isNotEmpty) {
      return Text(
        title!,
        style: style,
      );
    }
  
    switch (alertType) {
      case AlertTypes.error:
        return const Text(
          'Ошибка',
          style: style,
        );

      case AlertTypes.success:
        return const Text(
          'Успех',
          style: style,
        );

      case AlertTypes.warning:
        return const Text(
          'Предупреждение',
          style: style,
        );

      default:
        return const Text(
          'Информация',
          style: style,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onClose,
      child: Animate(
        effects: const [
          FadeEffect(duration: Duration(milliseconds: 300))
        ],
        child: AlertDialog(
          icon: Builder(
            builder: buildIcon,
          ),
          content: content,
          actionsAlignment: MainAxisAlignment.center,
        )
      )
    );
  }
}