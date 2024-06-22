
import 'package:anova_incomings/src/api.dart';
import 'package:anova_incomings/src/auth_manager.dart';
import 'package:anova_incomings/src/components/incomings_list.dart';
import 'package:flutter/foundation.dart';

IncomingCategory getCategoryByString(String value) {
  switch (value) {
    case 'animals':
      return IncomingCategory.animals;

    case 'supermarkets':
      return IncomingCategory.supermarkets;

    case 'another':
      return IncomingCategory.another;

    case 'deposit':
      return IncomingCategory.deposit;

    case 'games':
      return IncomingCategory.games;

    case 'house':
      return IncomingCategory.house;

    case 'marketplaces':
      return IncomingCategory.marketplaces;

    case 'purchaseReturn':
      return IncomingCategory.purchaseReturn;

    case 'taxi':
      return IncomingCategory.taxi;

    case 'transfers':
      return IncomingCategory.transfers;

    case 'withdrawal':
      return IncomingCategory.widthdrawal;

    default:
      return IncomingCategory.another;

  }
}

IncomingType getTypeByString(String value) {
  switch (value) {
    case 'incoming':
      return IncomingType.incoming;
    case 'outcoming':
      return IncomingType.outcoming;
    default:
      return IncomingType.incoming;
  }
}

class AuthProvider extends ChangeNotifier {
  dynamic user;
  TIncomingList incomings = [];


  Future<dynamic> refreshIncomings() async {
    final incomings_ = await ApiManager.getIncomings();
    
    incomings = incomings_.map(
      (element) => (
        id: element['id'],
        title: element['title'],
        price: element['price'].toDouble(),
        category: getCategoryByString(element['category']),
        type: getTypeByString(element['type']),
        date: DateTime.parse(element['date']),
      ) as TIncoming
    ).toList();
    notifyListeners();
  }

  Future<dynamic> refreshUser() async {
    final userData = await AuthManager.getUserCredentials();
    if (userData == null) {
      user = null;
      incomings = [];
      notifyListeners();
      return;
    }

    user = (
      username: userData['username'],
      email: userData['email'],
      id: userData['id'],
    );
    refreshIncomings();
  }

  Future<dynamic> removeIncoming(int incomingId) async {
    final deleted = await ApiManager.deleteIncoming(incomingId);

    if (deleted) {
      incomings.removeWhere((value) => value.id == incomingId);
    }
    refreshIncomings();
  }

  Future<dynamic> authenticate({token}) async {
    await AuthManager.authenticate(token: token);
    refreshUser();
  }

  Future<dynamic> createIncoming(String title, int price, String category, String type) async {
    final response = await ApiManager.createIncoming(title, price, category, type);
    refreshIncomings();
    return response;
  }

  AuthProvider() {
    refreshUser();
  }
}