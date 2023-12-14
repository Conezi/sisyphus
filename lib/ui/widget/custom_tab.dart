import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final List<Widget> tabs;
  final bool isScrollable;
  const CustomTab({required this.tabs, this.isScrollable = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(5.0),
                indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(.2),
                          blurRadius: 2,
                          spreadRadius: 0.2,
                          offset: const Offset(0.0, 1.0))
                    ]),
                unselectedLabelColor:
                    Theme.of(context).textTheme.bodySmall!.color,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                labelColor: Theme.of(context).textTheme.bodyMedium!.color,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                isScrollable: isScrollable,
                tabs: tabs)));
  }
}
