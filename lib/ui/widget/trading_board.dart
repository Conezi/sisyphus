import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import 'custom_tab.dart';
import 'trade_bottom_sheet.dart';

class TradingBoard extends StatelessWidget {
  const TradingBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.symmetric(
              horizontal: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ))),
      child: const DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomTab(tabs: [
                  Tab(text: 'Open Orders'),
                  Tab(text: 'Positions'),
                  Tab(text: 'Order History'),
                  Tab(text: 'Trade History')
                ], isScrollable: true),
              ),
              SizedBox(
                height: 290,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    EmptyWidget(title: 'No Open Orders'),
                    EmptyWidget(),
                    EmptyWidget(),
                    EmptyWidget(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final String title;
  const EmptyWidget({this.title = "Nothing to show here!", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 2,
                color: Theme.of(context).textTheme.bodySmall!.color),
          )
        ],
      ),
    );
  }
}

class ButtonsCard extends StatelessWidget {
  const ButtonsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.symmetric(
                horizontal: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ))),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showTradeBottomSheet(context, 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                child: const Text(
                  'Buy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showTradeBottomSheet(context, 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                child: const Text(
                  'Sell',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ));
  }

  static Future<dynamic> _showTradeBottomSheet(
      BuildContext context, int initialIndex) async {
    final data = await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        backgroundColor: Theme.of(context).colorScheme.background,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return FractionallySizedBox(
              heightFactor: 0.7,
              child: TradeBottomSheet(initialIndex: initialIndex));
        });
    return data;
  }
}
