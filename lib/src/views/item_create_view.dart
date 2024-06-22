import 'package:anova_incomings/src/api.dart';
import 'package:anova_incomings/src/auth_provider.dart';
import 'package:anova_incomings/src/components/alert.dart';
import 'package:anova_incomings/src/components/incomings_list.dart';
import 'package:anova_incomings/src/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


typedef TIncomingCreate = ({
  String title,
  double price,
  IncomingType type,
  IncomingCategory? category,
  DateTime? date, 
});
typedef CreateCallback = Future<dynamic> Function(TIncomingCreate);

String buildCategoryText(IncomingCategory category, BuildContext context, bool? enabled) {
    switch (category) {
      case IncomingCategory.animals:
        return 'Домашние животные';
      
      case IncomingCategory.another:
        return 'Остальные траты';

      case IncomingCategory.games:
        return 'Видео-игры';

      case IncomingCategory.house:
        return 'Товары для дома';

      case IncomingCategory.marketplaces:
        return 'Покупка на маркетплейсе';

      case IncomingCategory.supermarkets:
        return 'Продукты и супермаркеты';

      case IncomingCategory.taxi:
        return 'Такси';

      case IncomingCategory.transfers:
        return 'Переводы';

      case IncomingCategory.deposit:
        return 'Пополнение через банкомат';

      case IncomingCategory.purchaseReturn:
        return 'Возврат';

      case IncomingCategory.widthdrawal:
        return 'Снятие наличных';
    }
}


class _ItemCreateViewState extends State<ItemCreateView> {
  bool isIncoming = true;
  IncomingCategory? category;
  double price = 0;

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryDropdownController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validatePrice(String? price) {
    if (price == null || price.isEmpty) {
      return 'Обязательное поле.';
    }

    double? priceDouble = double.tryParse(price);

    if (priceDouble == null) {
      return 'Некорректное число.';
    }

    if (priceDouble <= 0) {
      return 'Число должно быть больше 0.';
    }

    return null;
  }

  String? validateTitle(String? value) {
    if (value == null) {
      return 'Обязательное поле.';
    }

    if (value.length < 3) {
      return 'Минимальное значение - 3 символа.';
    }

    if (value.length > 20) {
      return 'Максимальное значение - 20 символов.';
    }
  }

  void handleIncomingSwitchChange(bool value) {
    setState(() {
      isIncoming = value;
      category = null;
      categoryDropdownController.clear();
    });
  }

  void handleCategoryChange(IncomingCategory value) {
    setState(() {
      category = value;
    });
  }

  void handleDropdownChange(dynamic value) {
    setState(() {
      category = value;
    });
  }

  Future<void> handleSubmitForm(dynamic value) async {
    final title = titleController.value.text;
    final price = int.parse(priceController.value.text);
    final category_ = (category! as dynamic).toString().split('.')[1];
    final incomingType = isIncoming ? 
      'incoming'
      : 
      'outcoming'
    ;

    if (_formKey.currentState!.validate()) {
      await value.createIncoming(
        title, 
        price, 
        category_, 
        incomingType,
      )
      .then((value) async {
        if (value == null) {
          print('Ошибка');
        }

        await showDialog(
          context: context, 
          builder: (_) => const TypedAlert(
            alertType: AlertTypes.success, 
            content: Text('Запись была успешно создана.', textAlign: TextAlign.center,),
          ),
        )
        .then(
          (_) {
            Navigator.of(context).restorablePushNamed(MainView.routeName);
          }
           
        );
      });
    }
  }

  Iterable<DropdownMenuEntry> buildCategoryItems(BuildContext context) {
    List<IncomingCategory> disableIfOutcoming = [
      IncomingCategory.animals,
      IncomingCategory.taxi,
      IncomingCategory.house,
      IncomingCategory.marketplaces,
      IncomingCategory.supermarkets,
      IncomingCategory.games,
      IncomingCategory.widthdrawal,
      IncomingCategory.another,
    ];

    bool canHideForIncomings(IncomingCategory value) => isIncoming && !disableIfOutcoming.contains(value);
    bool canHideForOutcomings(IncomingCategory value) => !isIncoming && disableIfOutcoming.contains(value);

    return IncomingCategory.values
      .where(
        (value) => canHideForIncomings(value) || canHideForOutcomings(value)
      )
      .map(
        (value) {
          bool enabled = canHideForIncomings(value) || canHideForOutcomings(value);

          return DropdownMenuEntry(
            value: value,
            label: buildCategoryText(value, context, enabled),
          );
        } 
      );
  }

  Widget buildForm(BuildContext context, dynamic value) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Text.rich(
          //   TextSpan(
          //     text: '',
          //     children: [
          //       WidgetSpan(child: Icon(Icons.create)),
          //       TextSpan(
          //         text: ' Создайте новую запись',
          //         style: TextStyle(fontSize: 23),
          //       )
          //     ]
          //   )  
          // ),

          // const SizedBox(height: 20),

          // const Padding(
          //   padding: EdgeInsets.only(
          //     left: 40,
          //     right: 40
          //   ),
          //   child: Divider(),
          // ),
          // const SizedBox(height: 20),

          SizedBox(
            width: 290,
            child: TextFormField(
              controller: titleController,
              validator: validateTitle,
              decoration: InputDecoration(
                label: const Text('Заголовок'),
                prefixIcon: const Icon(Icons.pending_actions_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          // 
          const SizedBox(height: 30),

          SizedBox(
            width: 290,
            child: TextFormField(
              controller: priceController,
              obscureText: false,
              validator: validatePrice,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                label: const Text('Цена'),
                prefixIcon: const Icon(Icons.price_change_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffix: const Text('₽')
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            child: DropdownMenu(
              width: 290,
              enableSearch: true,
              label: const Text('Категория'),
              controller: categoryDropdownController,
              errorText: categoryDropdownController.value.text.isEmpty 
                ? 
                'Обязательное поле.' 
                : 
                null
              ,
              hintText: 'Выберите категорию...',
              dropdownMenuEntries: [...buildCategoryItems(context)],
              onSelected: handleDropdownChange,
              leadingIcon: const Icon(Icons.category_rounded),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              
            ),
          ),
          
          const SizedBox(height: 30),

          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              const Text(
                'Расход'
              ),
              Switch(
                value: isIncoming, 
                onChanged: handleIncomingSwitchChange,
                trackColor: isIncoming ? 
                  const WidgetStatePropertyAll(Color.fromARGB(255, 104, 246, 108)) 
                  :
                  const WidgetStatePropertyAll(Color.fromARGB(255, 247, 96, 85)),
                inactiveThumbColor: Colors.white,
                thumbColor: const WidgetStatePropertyAll(Colors.white),
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                  if (isIncoming) {
                    return const Icon(Icons.add, color: Colors.black);
                  }
                  return const Icon(Icons.remove_rounded); // All other states will use the default thumbIcon.
                }),
              ),
              const Text(
                'Доход'
              )
            ],
          ),

          const SizedBox(height: 30),

          Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            children: [
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(), 
                label: const Text('Назад'),
                icon: const Icon(Icons.arrow_back),
              ),
              OutlinedButton.icon(
                onPressed: () => handleSubmitForm(value), 
                label: const Text('Создать'),
                icon: const Icon(Icons.create),
              ),
            ],
          ),

          
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Создание новой записи'),
          centerTitle: true,
        ),
        body: Center(
          child: Wrap(
            children: [
              SingleChildScrollView(
                child: buildForm(context, value)
              ),
            ],
          ),
        ),
      )
    );
  }
}

typedef ItemCreateCallback = Future<dynamic> Function(TIncoming);

class ItemCreateView extends StatefulWidget {
  final ItemCreateCallback? onItemCreate;

  const ItemCreateView({
    super.key,
    this.onItemCreate,
  });

  static const routeName = '/item/create';

  @override
  State<StatefulWidget> createState() {
    return _ItemCreateViewState();
  }
}