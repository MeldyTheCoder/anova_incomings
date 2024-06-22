import 'package:anova_incomings/src/views/item_create_view.dart';
import 'package:anova_incomings/src/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:flutter_animate/flutter_animate.dart';

final List<String> months = [
  'января',
  'ферваля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

enum IncomingType {
  incoming,
  outcoming,
}

enum IncomingCategory {
  supermarkets,
  games,
  taxi,
  house,
  marketplaces,
  another,
  animals,
  transfers,
  deposit,
  widthdrawal,
  purchaseReturn,
}

typedef TIncoming = ({
  int id,
  String title,
  double price,
  IncomingType type,
  IncomingCategory? category,
  DateTime date,
});

typedef TIncomingList = List<TIncoming>;
typedef TIncomingListByDates = Map<String, TIncomingList>;


Widget buildCategoryText(TIncoming incomingData, BuildContext context) {
    TextStyle style = const TextStyle(
      fontSize: 13,
    );

    switch (incomingData.category!) {
      case IncomingCategory.animals:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Домашние животные',
                style: style,
              ),
            ] 
          )
        );
      
      case IncomingCategory.another:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Остальные траты',
                style: style,
              )
            ]
          )
        );

      case IncomingCategory.games:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Видео-игры',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.house:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Товары для дома',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.marketplaces:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Покупка на маркетплейсе',
                style: style,
              )
            ]
          ),
        );

      case IncomingCategory.supermarkets:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Продукты и супермаркеты',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.taxi:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Такси',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.transfers:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Переводы',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.deposit:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Пополнение через банкомат',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.purchaseReturn:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Возврат',
                style: style,
              ),
            ]
          )
        );

      case IncomingCategory.widthdrawal:
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Снятие наличных',
                style: style,
              ),
            ]
          )
        );
    }
}

class IncomingElement extends StatelessWidget {
  final TIncoming incomingData;
  
  const IncomingElement({
    super.key,
    required this.incomingData,
  });

  Widget buildTypePrice(BuildContext context) {
    double price = incomingData.price;
    String priceString = MoneyFormatter(
      amount: price,
      settings: MoneyFormatterSettings(
        symbol: '₽',
        thousandSeparator: ' ',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        compactFormatType: CompactFormatType.short,
      )
    ).output.symbolOnRight.replaceAll('.00', '');

    switch (incomingData.type) {
      case IncomingType.incoming:
        return Text(
          '+$priceString',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 15,
          ),
        ).animate().fade();

      case IncomingType.outcoming:
        return Text(
          '-$priceString',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ).animate().fade();

      default:
        return const Icon(Icons.device_unknown);
    }
  }

  Widget buildCategoryIcon(BuildContext context) {
    switch (incomingData.category!) {
      case IncomingCategory.animals:
        return const Icon(
          Icons.pets_rounded,
          color: Color.fromARGB(255, 83, 214, 254),
          size: 40,
        );

      case IncomingCategory.another:
        return const Icon(
          Icons.device_unknown_outlined,
          size: 40,
        );

      case IncomingCategory.games:
        return const Icon(
          Icons.gamepad_rounded,
          color: Colors.purple,
          size: 40,
        );

      case IncomingCategory.house:
        return const Icon(
          Icons.house_rounded,
          color: Colors.brown,
          size: 40,
        );

      case IncomingCategory.marketplaces:
        return const Icon(
          Icons.shop_two_rounded,
          color: Colors.lightGreen,
          size: 40,
        );

      case IncomingCategory.supermarkets:
        return const Icon(
          Icons.shopping_bag_rounded,
          color: Colors.green,
          size: 40,
        );

      case IncomingCategory.taxi:
        return const Icon(
          Icons.local_taxi_rounded,
          color: Colors.yellow,
          size: 40,
        );

      case IncomingCategory.transfers:
        return const Icon(
          Icons.transform_outlined,
          color: Colors.grey,
          size: 40,
        );

      case IncomingCategory.deposit:
        return const Icon(
          Icons.add,
          color: Colors.green,
          size: 40,
        );

      case IncomingCategory.widthdrawal:
        return const Icon(
          Icons.settings_backup_restore_rounded,
          color: Colors.red,
          size: 40,
        );

      case IncomingCategory.purchaseReturn:
        return const Icon(
          Icons.restart_alt_rounded,
          color: Colors.green,
          size: 40,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: buildCategoryIcon(context),
        ),
        title: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                incomingData.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),

            const Spacer(),

            buildTypePrice(context),
          ],
        ),
        subtitle: buildCategoryText(incomingData, context)
      ),
    );
  }
}

typedef GroupElementDeleteCallback = Function(TIncoming);
typedef GroupDeleteCallback = Function(String);
typedef GroupConfirmDeleteCallback = Future<bool> Function(BuildContext, TIncoming);

class _IncomingElementGroupState extends State<IncomingElementGroup> with TickerProviderStateMixin{
  late AnimationController _animationController;

  TIncomingList _incomings = [];

  @override
  void dispose() {
    // _animationController.repeat(reverse: true);
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();

    setState(() {
      _incomings = [...widget.incomings];
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
          top: 15,
          bottom: 0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 5,
              ),
              child: Text(
                widget.heading,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ).animate(
                controller: _animationController,
                autoPlay: false,
              ).blur()
            ),

            ..._incomings.map(
              (incoming) => Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(incoming.id.toString()), 
                confirmDismiss: (_) async {
                  return widget.onElementDeleteConfirm!(context, incoming);
                },
                onDismissed: (_) {
                  widget.onElementDelete!(incoming);
                  _incomings.removeWhere((element) => element.id == incoming.id);

                  if (_incomings.isEmpty) {
                    _animationController.forward().then((_) => widget.onGroupDelete!(widget.heading));
                  }
                },
                child: IncomingElement(incomingData: incoming),
              ),
            ),
          ],
        ),
    );
  }
}

class IncomingElementGroup extends StatefulWidget {
  final String heading;
  final TIncomingList incomings;
  final GroupElementDeleteCallback? onElementDelete;
  final GroupDeleteCallback? onGroupDelete;
  final GroupConfirmDeleteCallback? onElementDeleteConfirm;

  const IncomingElementGroup({
    super.key,
    required this.heading,
    required this.incomings,
    this.onElementDelete,
    this.onElementDeleteConfirm,
    this.onGroupDelete,
  });

  @override
  State<StatefulWidget> createState() {
    return _IncomingElementGroupState();
  }
}

class IncomingsListState extends State<IncomingsList> {
  Future<bool> confirmDismiss(BuildContext context, TIncoming incoming) {
    String incomingTitle = incoming.title;

    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.yellow,
          size: 60,
        ),
        content: Text.rich(
          TextSpan(
            text: 'Вы уверены, что хотите удалить запись ',
            children: [
              TextSpan(
                text: incomingTitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                )
              ),
              const TextSpan(
                text: '?'
              ),
            ]
          )
          ,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton.icon(
            label: const Text('Удалить', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context, false);
            }, 
            label: const Text('Отмена'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceEvenly,
      )
    ).then((value) => (value != null && value) || false);
  } 

  Widget buildEmptyContent(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          const Text(
            '🥹',
            style: TextStyle(
              fontSize: 56
            ),
          ),
          const Text(
            'Не найдено ни одной записи.', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ),
          ),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.restorablePushNamed(context, ItemCreateView.routeName);
            }, 
            label: const Text('Создать'),
            icon: const Icon(Icons.add),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final groups = widget.getByDates(widget.incomings); 

    Iterable<Widget> children = [
      ...groups.entries.map(
        (entry) => 
          IncomingElementGroup(
            key: Key(entry.key),
            heading: entry.key, 
            incomings: entry.value,
            onElementDelete: (incoming) => widget.onDelete(incoming.id),
            onElementDeleteConfirm: confirmDismiss,
            onGroupDelete: (groupName) {
              setState(() {
                groups.remove(groupName);  
              });
            },
          ),
      ),
    ];

    return groups.keys.isNotEmpty ? 
      ListView(
        shrinkWrap: true,
        children: [...children],
      ) : buildEmptyContent(context)
    ;
  }
}

typedef IncomingDeleteCallback = Function(int);

class IncomingsList extends StatefulWidget {
  final TIncomingList incomings;
  final IncomingDeleteCallback onDelete;

  const IncomingsList({
    super.key,
    required this.incomings,
    required this.onDelete,
  });

  String convertDateTimeToString(DateTime datetime) {
    DateTime now = DateTime.now();
    int day = datetime.day;
    int year = datetime.year;

    String monthString = months.elementAt(datetime.month - 1);

    if (datetime.year == now.year) {
      return '$day $monthString';
    }

    return '$day $monthString $year';
  }

  TIncomingListByDates getByDates(TIncomingList incomingList) {
    TIncomingListByDates result = {};
    TIncomingList incomingsSorted = [...incomingList];
    
    incomingsSorted.sort(
      (next, prev) => prev.date.compareTo(next.date)
    );

    for (final incoming in incomingsSorted) {
      String dateFormatted = convertDateTimeToString(incoming.date);

      if (result.containsKey(dateFormatted)) {
        result.update(dateFormatted, (value) => [...value, incoming]);
      } else {
        result[dateFormatted] = [incoming];
      }
    }

    return result;
  } 

  @override
  State<StatefulWidget> createState() {
    return IncomingsListState();
  }
}