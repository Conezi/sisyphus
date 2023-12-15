import 'package:flutter/material.dart';
import 'package:sisyphus/configs/theme_config.dart';

import '../core/view_model.dart';
import '../res/app_images.dart';
import 'widget/image_view.dart';
import 'widget/summary_card.dart';
import 'widget/market_board.dart';
import 'widget/trading_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ViewModel.instance.fetchSymbols();
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
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      alignment: Alignment.topRight,
                      insetPadding: const EdgeInsets.only(
                          left: 120.0, top: 24.0, right: 24.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1)), //this right here
                      child: const Menu())),
              splashRadius: 20,
              icon:
                  const ImageView.svg(AppImages.icMenu, height: 32, width: 32)),
          const SizedBox(width: 15.0)
        ],
      ),
      body: ListView(
        children: const [
          SummaryCard(),
          MarketBoard(),
          TradingBoard(),
          ButtonsCard()
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _options = ['Exchange', 'Wallet', 'Roqqu Hub'];
  String _selectedOption = 'Wallet';

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: List.generate(
              _options.length,
              (index) => ListTile(
                    dense: true,
                    selected: _selectedOption == _options[index],
                    selectedColor: Theme.of(context).textTheme.bodyLarge!.color,
                    selectedTileColor:
                        Theme.of(context).colorScheme.secondary.withOpacity(.5),
                    title: Text(_options[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    onTap: () => {
                      setState(() => _selectedOption = _options[index]),
                      Navigator.of(context).pop()
                    },
                  )),
        ),
        ListenableBuilder(
          listenable: ThemeConfig.instance,
          builder: (BuildContext context, Widget? child) {
            final themeMode = ThemeConfig.instance.themeMode;
            return ListTile(
              dense: true,
              title: const Text('Dark Mode',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    ThemeConfig.instance.setThemeMode(ThemeMode.dark);
                    return;
                  }
                  ThemeConfig.instance.setThemeMode(ThemeMode.light);
                },
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          title: const Text('Log out',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
