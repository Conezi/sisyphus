import 'package:flutter/material.dart';
import 'package:sisyphus/core/view_model.dart';
import 'package:sisyphus/ui/widget/text_edit_view.dart';

class SymbolsSearchModal extends StatefulWidget {
  const SymbolsSearchModal({Key? key}) : super(key: key);

  @override
  State<SymbolsSearchModal> createState() => _SymbolSearchModalState();
}

class _SymbolSearchModalState extends State<SymbolsSearchModal> {
  String symbolSearch = "";
  @override
  Widget build(BuildContext context) {
    final tickers = ViewModel.instance.tickers
        .where(
            (t) => t.symbol.toLowerCase().contains(symbolSearch.toLowerCase()))
        .toList();
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          height: MediaQuery.of(context).size.height * 0.75,
          color: Theme.of(context).canvasColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextEditView(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      symbolSearch = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: tickers.length,
                  separatorBuilder: (context, index) => Divider(
                      thickness: .2, color: Theme.of(context).shadowColor),
                  itemBuilder: (context, index) {
                    final e = tickers[index];
                    return RawMaterialButton(
                      onPressed: () {
                        ViewModel.instance.setTicker(e);
                        Navigator.of(context).pop();
                      },
                      child: Text(e.symbol),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
