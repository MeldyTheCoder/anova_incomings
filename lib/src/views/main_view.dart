import 'package:anova_incomings/src/auth_provider.dart';
import 'package:anova_incomings/src/components/incomings_list.dart';
import 'package:anova_incomings/src/components/profile_button.dart';
import 'package:anova_incomings/src/views/auth_view.dart';
import 'package:anova_incomings/src/views/item_create_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Widget buildUnauthorizedContent(BuildContext context) => Center(
  child: Wrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 10,
    children: [
      const Text(
        '👽',
        style: TextStyle(
          fontSize: 56
        ),
      ),
      const Text(
        'Приказ авторизоваться.', 
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18
        ),
      ),

      OutlinedButton.icon(
        onPressed: () {
          Navigator.restorablePushNamed(context, AuthView.routeName);
        }, 
        label: const Text('Авторизоваться'),
        icon: const Icon(Icons.arrow_forward_rounded),
      ),
    ],
  )
);

List<TIncoming> incomings = [
  (
    id: 1,
    title: 'Зоо-магазин',
    category: IncomingCategory.animals,
    price: 700,
    type: IncomingType.outcoming,
    date: DateTime(2024, 6, 19, 0, 0, 0, 0),
  ),
  (
    id: 2,
    title: 'Пополнение средств',
    category: IncomingCategory.deposit,
    price: 700,
    type: IncomingType.incoming,
    date: DateTime(2024, 6, 13, 0, 0, 0, 0),
  ),
  (
    id: 3,
    title: 'Game-Store',
    category: IncomingCategory.games,
    price: 700,
    type: IncomingType.outcoming,
    date: DateTime(2023, 9, 16, 0, 0, 0, 0),
  ),
  (
    id: 4,
    title: 'Leroy-Merlin',
    category: IncomingCategory.purchaseReturn,
    price: 700,
    type: IncomingType.incoming,
    date: DateTime(2023, 9, 16, 0, 0, 0, 0),
  ),


  (
    id: 5,
    title: 'Пополнение средств',
    category: IncomingCategory.deposit,
    price: 7000,
    type: IncomingType.incoming,
    date: DateTime(2024, 6, 10, 0, 0, 0, 0),
  ),
  (
    id: 6,
    title: 'Game-Store',
    category: IncomingCategory.games,
    price: 700,
    type: IncomingType.outcoming,
    date: DateTime(2023, 6, 8, 0, 0, 0, 0),
  ),
  (
    id: 7,
    title: 'Leroy-Merlin',
    category: IncomingCategory.another,
    price: 228000,
    type: IncomingType.outcoming,
    date: DateTime(1941, 6, 7, 0, 0, 0, 0),
  ),
];


class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: value.user != null ? FloatingActionButton(
          onPressed: () {
            if (value.user != null) Navigator.restorablePushNamed(context, ItemCreateView.routeName);
          },
          child: const Icon(Icons.add),
        ) : null,
        appBar: AppBar(
          title: const Text('Главная'),
          toolbarHeight: 60,
          actions: [
            ProfileButton(
              userData: value.user,
              onLogout: () async {
                await value.authenticate(token: null);
              },
            ),
          ],
        ),
        body: Builder(
          builder: (_) {
            if (value.user != null) {
              return IncomingsList(
                incomings: value.incomings,
                onDelete: value.removeIncoming,
              );
            }

            return buildUnauthorizedContent(context);
          }
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

class MainView extends StatefulWidget {

  const MainView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}
