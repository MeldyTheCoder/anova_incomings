import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key});

  static const routeName = '/item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
      ),
      body: const Text('erjgoierg'),
    );
  }
}
