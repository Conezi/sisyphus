import 'package:flutter/material.dart';
import 'package:sisyphus/res/app_images.dart';
import 'package:sisyphus/ui/widget/image_view.dart';

import '../../core/view_model.dart';
import '../../res/app_colors.dart';
import 'tickers_modal.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ViewModel.instance,
      builder: (BuildContext context, Widget? child) {
        final ticker = ViewModel.instance.currentTicker;
        final symbol = ViewModel.instance.symbols;
        if (ticker == null) return const SizedBox.shrink();
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.symmetric(
                    horizontal: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0)), //this right here
                                child: const TickersModal())),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (symbol != null)
                              SizedBox(
                                height: 32,
                                width: 44,
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    CircleAvatar(
                                        radius: 12,
                                        backgroundColor: AppColors.orange,
                                        child: Text(symbol.baseAsset,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white))),
                                    Positioned(
                                        right: 1.5,
                                        child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: AppColors.green,
                                            child: Text(symbol.quoteAsset,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white))))
                                  ],
                                ),
                              ),
                            const SizedBox(width: 5),
                            Text(ViewModel.instance.pairSymbol,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0)),
                            const SizedBox(width: 5),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                      if (ticker.lastPrice != null) ...[
                        const SizedBox(width: 25),
                        Text(ticker.lastPrice!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: AppColors.green))
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  height: 48,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      children: [
                        if (ticker.priceChangePercent != null) ...[
                          TickerDetail(
                            icon: AppImages.icClock,
                            caption: '24h change',
                            value:
                                '${ticker.priceChange} + ${ticker.priceChangePercent}%',
                            valueColor:
                                double.parse(ticker.priceChangePercent!) > 0
                                    ? AppColors.green
                                    : AppColors.orange,
                          )
                        ],
                        if (ticker.highPrice != null) ...[
                          _divider(),
                          TickerDetail(
                            icon: AppImages.icArrowUp,
                            caption: '24h high',
                            value:
                                '${ticker.highPrice} + ${ticker.priceChangePercent}%',
                          )
                        ],
                        if (ticker.volume != null) ...[
                          _divider(),
                          TickerDetail(
                            icon: AppImages.icArrowUp,
                            caption: '24h volume',
                            value:
                                '${ticker.volume} + ${ticker.priceChangePercent}%',
                          ),
                        ]
                      ]),
                )
              ],
            ));
      },
    );
  }

  Widget _divider() => const SizedBox(
      height: 48, child: VerticalDivider(width: 25, thickness: 1));
}

class TickerDetail extends StatelessWidget {
  final String icon;
  final String caption;
  final String value;
  final Color? valueColor;
  const TickerDetail(
      {required this.icon,
      required this.caption,
      required this.value,
      this.valueColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageView.svg(icon, height: 16, width: 16),
              const SizedBox(width: 5),
              Text(caption,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0))
            ],
          ),
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0))
        ],
      ),
    );
  }
}
