import 'package:flutter/material.dart';

import '../core/view_model.dart';
import '../res/app_images.dart';
import 'widget/image_view.dart';
import 'widget/summary_card.dart';
import 'widget/trading_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ViewModel _viewModel = ViewModel.instance;

  @override
  void initState() {
    _viewModel.fetchSymbols();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageView.svg(AppImages.icLogo,
            color: Theme.of(context).iconTheme.color, fit: BoxFit.fitWidth),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon: const ImageView.asset(AppImages.avatar,
                  height: 32, width: 32)),
          IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon: const ImageView.svg(AppImages.icGlobe,
                  height: 24, width: 24)),
          IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon:
                  const ImageView.svg(AppImages.icMenu, height: 32, width: 32)),
          const SizedBox(width: 15.0)
        ],
      ),
      body: ListView(
        children: const [SummaryCard(), TradingBoard()],
      ),
    );
  }
}
