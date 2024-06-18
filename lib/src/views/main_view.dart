import 'package:anova_incomings/src/components/profile_button.dart';
import 'package:anova_incomings/src/components/profile_dropdown.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../list/item.dart';
import 'item_detail_view.dart';

/// Displays a list of SampleItems.
class MainView extends StatelessWidget {
  const MainView({
    super.key,
    this.items = const [ListItem(1), ListItem(2), ListItem(3)],
  });

  static const routeName = '/';

  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: const [
          ProfileButton(
            userData: (
              username: "Sunday", 
              image: 'https://m.media-amazon.com/images/S/pv-target-images/ae4816cade1a5b7f29787d0b89610132c72c7747041481c6619b9cc3302c0101.jpg',
              email: 'example@mail.ru',
            ),
            // userData: null,
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text('Элемент ${item.id}'),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(
                context,
                ItemDetailsView.routeName,
              );
            }
          );
        },
      ),
    );
  }
}
