import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';

import '../../core/view_model.dart';
import '../../res/app_images.dart';
import 'custom_tab.dart';
import 'dropdown_view.dart';
import 'image_view.dart';
import 'order_books.dart';
import 'trading_board.dart';

class MarketBoard extends StatelessWidget {
  const MarketBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 591,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.symmetric(
              horizontal: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ))),
      child: const DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTab(tabs: [
                Tab(text: 'Charts'),
                Tab(text: 'Orderbook'),
                Tab(text: 'Recent trades')
              ]),
              SizedBox(
                height: 490,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ChartView(),
                    OrderBooks(),
                    EmptyWidget(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ViewModel.instance,
      builder: (BuildContext context, Widget? child) {
        final candles = ViewModel.instance.candles;
        return Column(
          children: [
            SizedBox(
              height: 32,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  children: const [IntervalView()]),
            ),
            Expanded(
              child: Candlesticks(
                  key: Key(
                      '${ViewModel.instance.currentTicker?.symbol}${ViewModel.instance.currentInterval}'),
                  candles: candles,
                  onLoadMoreCandles: ViewModel.instance.fetchMoreCandles),
            ),
          ],
        );
      },
    );
  }
}

class IntervalView extends StatelessWidget {
  const IntervalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ViewModel.instance,
      builder: (BuildContext context, Widget? child) {
        final mainIntervals = ['1h', '2h', '4h', '1d', '1w', '1M'];
        final intervals = ViewModel.instance.intervals;
        final currentInterval = ViewModel.instance.currentInterval;
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Time('Time'),
            const SizedBox(width: 5),
            for (String interval in mainIntervals) ...[
              InkWell(
                onTap: () => ViewModel.instance.setInterval(interval),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: interval == currentInterval
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Time(interval.toUpperCase())),
              )
            ],
            const SizedBox(width: 5),
            DropdownView(
                value: currentInterval,
                isExpanded: false,
                icon: Icon(Icons.keyboard_arrow_down,
                    color: Theme.of(context).textTheme.bodySmall!.color),
                items:
                    intervals.map<DropdownMenuItem<String>>((String interval) {
                  return DropdownMenuItem<String>(
                      value: interval, child: Time(interval));
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return intervals
                      .map<Widget>((String interval) => const SizedBox.shrink())
                      .toList();
                },
                onChanged: (value) => ViewModel.instance.setInterval(value!)),
            _divider(),
            const ImageView.svg(AppImages.icCandleChart, height: 20, width: 20),
            _divider(),
            const Time('Fx Indicators')
          ],
        );
      },
    );
  }

  Widget _divider() => const SizedBox(
      height: 25, child: VerticalDivider(width: 8, thickness: 1));
}

class Time extends StatelessWidget {
  final String time;
  const Time(this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(time,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodySmall!.color));
  }
}
