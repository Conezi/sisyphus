import 'package:flutter/material.dart';
import 'package:sisyphus/res/app_colors.dart';
import 'package:sisyphus/res/app_images.dart';
import 'package:sisyphus/ui/widget/image_view.dart';
import 'package:sisyphus/ui/widget/text_edit_view.dart';

import 'custom_tab.dart';
import 'market_board.dart';
import 'trading_board.dart';

class TradeBottomSheet extends StatelessWidget {
  final int initialIndex;
  const TradeBottomSheet({this.initialIndex = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: initialIndex,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTab(tabs: [
              Tab(text: 'Buy'),
              Tab(text: 'Sell'),
            ], borderColor: AppColors.green),
            Expanded(
              child: TabBarView(
                children: [
                  Buy(),
                  EmptyWidget(),
                ],
              ),
            )
          ],
        ));
  }
}

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  final _options = ['Limit', 'Market', 'Stop-Limit'];
  String _selectedOption = 'Limit';

  bool _postOnly = false;

  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  final _typeController = TextEditingController();

  static String? validate(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Required.';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_options.length, (index) {
              return InkWell(
                onTap: () => setState(() => _selectedOption = _options[index]),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        color: _selectedOption == _options[index]
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Time(_options[index])),
              );
            }),
          ),
          const SizedBox(height: 15.0),
          TextEditView(
            controller: _priceController,
            validator: validate,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Limit price',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
                const SizedBox(width: 5),
                const ImageView.svg(AppImages.icRequired)
              ],
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                '0.00 USD',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextEditView(
            controller: _amountController,
            validator: validate,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
                const SizedBox(width: 5),
                const ImageView.svg(AppImages.icRequired)
              ],
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                '0.00 USD',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextEditView(
            controller: _typeController,
            validator: validate,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Type',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
                const SizedBox(width: 5),
                const ImageView.svg(AppImages.icRequired)
              ],
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Good till cancelled',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodySmall!.color),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 12)
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _postOnly,
                onChanged: (changed) => setState(() => _postOnly = changed!),
              ),
              Text('Post Only',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              const SizedBox(width: 8),
              const ImageView.svg(AppImages.icRequired)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              Text('0.00',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color))
            ],
          ),
          const SizedBox(height: 15.0),
          Container(
            width: double.infinity,
            height: 32.0,
            decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(8.0)),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
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
          ),
          Divider(
              thickness: .2, color: Theme.of(context).shadowColor, height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total account value',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              const Spacer(),
              Text('NGN',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              const Icon(Icons.keyboard_arrow_down, size: 12)
            ],
          ),
          const SizedBox(height: 8.0),
          Text('0.00',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodySmall!.color)),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Open Orderse',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              const Spacer(),
              Text('Available',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodySmall!.color))
            ],
          ),
          const SizedBox(height: 8.0),
          Text('0.00',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodySmall!.color)),
          const SizedBox(height: 25.0),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              child: const Text(
                'Deposit',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 25.0)
        ],
      ),
    );
  }
}
