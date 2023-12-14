import 'package:flutter/material.dart';
import 'package:sisyphus/res/app_colors.dart';
import 'package:sisyphus/res/app_images.dart';
import 'package:sisyphus/ui/widget/image_view.dart';

import '../../core/view_model.dart';
import 'dropdown_view.dart';

class OrderBooks extends StatefulWidget {
  const OrderBooks({super.key});

  @override
  State<OrderBooks> createState() => _OrderBooksState();
}

class _OrderBooksState extends State<OrderBooks> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ViewModel.instance,
      builder: (BuildContext context, Widget? child) {
        final limits = ViewModel.instance.limits;
        final currentLimit = ViewModel.instance.currentLimit;
        final orderBook = ViewModel.instance.orderBook;
        final symbolsPairs = ViewModel.instance.symbols;
        double? highestBid;
        double? lowestAsk;
        double? diffHigLow;
        if (orderBook != null) {
          highestBid = orderBook.bids.isNotEmpty
              ? orderBook.bids
                  .reduce((value, v) => value.first > v.first ? value : v)
                  .first
              : 0;
          lowestAsk = orderBook.asks.isNotEmpty
              ? orderBook.asks
                  .reduce((value, v) => value.first > v.first ? v : value)
                  .first
              : 0;
          diffHigLow = highestBid - lowestAsk;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    Drawer(
                        icon: AppImages.icDrawer1,
                        selected: _selectedIndex == 0,
                        onTap: () => setState(() => _selectedIndex = 0)),
                    Drawer(
                        icon: AppImages.icDrawer3,
                        selected: _selectedIndex == 1,
                        onTap: () => setState(() => _selectedIndex = 1)),
                    Drawer(
                        icon: AppImages.icDrawer3,
                        selected: _selectedIndex == 2,
                        onTap: () => setState(() => _selectedIndex = 2)),
                    const Spacer(),
                    Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: DropdownView(
                            value: currentLimit,
                            isExpanded: false,
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color),
                            items:
                                limits.map<DropdownMenuItem<int>>((int limit) {
                              return DropdownMenuItem<int>(
                                  value: limit,
                                  child: Text('$limit',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color)));
                            }).toList(),
                            onChanged: (value) =>
                                ViewModel.instance.setLimit(value!)))
                  ],
                ),
              ),
              if (orderBook != null) ...[
                if (symbolsPairs != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        column('Price',
                            subTitle: symbolsPairs.baseAsset,
                            crossAxisAlignment: CrossAxisAlignment.start),
                        column('Amounts',
                            subTitle: symbolsPairs.quoteAsset,
                            crossAxisAlignment: CrossAxisAlignment.center),
                        column('Total',
                            crossAxisAlignment: CrossAxisAlignment.end),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: List.generate(
                            orderBook.asks.length,
                            (index) => OrderView(
                                order: orderBook.asks[index],
                                color: AppColors.orange)),
                      ),
                      if (orderBook.asks.isNotEmpty &&
                          orderBook.bids.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$lowestAsk',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green),
                              ),
                              ImageView.svg(
                                  diffHigLow! > 0
                                      ? AppImages.icArrowUp
                                      : AppImages.icArrowDown,
                                  color:
                                      diffHigLow > 0 ? AppColors.green : null),
                              Text(
                                '$highestBid',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                      Column(
                        children: List.generate(
                            orderBook.bids.length,
                            (index) => OrderView(
                                order: orderBook.bids[index],
                                color: AppColors.green)),
                      )
                    ],
                  ),
                )
              ] else ...[
                const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()))
              ]
            ],
          ),
        );
      },
    );
  }

  Widget column(String title,
          {String? subTitle, required CrossAxisAlignment crossAxisAlignment}) =>
      Expanded(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodySmall!.color),
            ),
            if (subTitle != null) ...[
              Text(
                '($subTitle)',
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              )
            ]
          ],
        ),
      );
}

class Drawer extends StatelessWidget {
  final String icon;
  final bool selected;
  final void Function()? onTap;
  const Drawer(
      {required this.icon, this.selected = false, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 32,
          width: 32,
          margin: const EdgeInsets.only(right: 2.0),
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).colorScheme.secondary : null,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Center(child: ImageView.svg(icon, height: 10, width: 12))),
    );
  }
}

class OrderView extends StatelessWidget {
  final List<double> order;
  final Color color;
  const OrderView({required this.order, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '${order.first}',
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: color),
            ),
          ),
          Expanded(
            child: Text(
              '${order.last}',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              '${order.first * order.last}',
              maxLines: 1,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
