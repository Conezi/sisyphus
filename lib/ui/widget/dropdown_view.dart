import 'package:flutter/material.dart';

class DropdownView<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?> onChanged;
  final bool isExpanded;
  final bool isDense;
  final Widget? icon;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final Color? dropdownColor;

  const DropdownView(
      {Key? key,
      required this.value,
      required this.items,
      this.isDense = true,
      this.icon = const Icon(Icons.keyboard_arrow_down),
      required this.onChanged,
      this.isExpanded = true,
      this.selectedItemBuilder,
      this.dropdownColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
        isExpanded: isExpanded,
        value: value,
        icon: icon,
        iconSize: 24,
        elevation: 5,
        dropdownColor: dropdownColor,
        selectedItemBuilder: selectedItemBuilder,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 14),
        underline: Container(
          height: 0,
        ),
        onChanged: onChanged,
        items: items);
  }
}
