import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';

import '../../core/view_model.dart';

class TradingBoard extends StatelessWidget {
  const TradingBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 591,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.symmetric(
              horizontal: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ))),
      child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(5.0),
                        indicator: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 0.2,
                                  offset: const Offset(0.0, 1.0))
                            ]),
                        unselectedLabelColor:
                            Theme.of(context).textTheme.bodySmall!.color,
                        unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        labelColor:
                            Theme.of(context).textTheme.bodyMedium!.color,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        isScrollable: true,
                        tabs: const [
                          Tab(text: 'Charts'),
                          Tab(text: 'Orderbook'),
                          Tab(text: 'Recent trades')
                        ],
                      ))),
              SizedBox(
                height: 400,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ChartView(),
                    Text('2'),
                    Text('3'),
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
            Expanded(
              child: Candlesticks(
                key: Key(
                    '${ViewModel.instance.currentTicker?.symbol}${ViewModel.instance.currentInterval}'),
                candles: candles,
                onLoadMoreCandles: ViewModel.instance.fetchMoreCandles,
                actions: [],
              ),
            ),
          ],
        );
      },
    );
  }
}
