import 'dart:convert';

class OrderBook {
  final int? firstUpdateId;
  final int? lastUpdateId;
  final List<List<double>> bids;
  final List<List<double>> asks;

  OrderBook({
    this.firstUpdateId,
    this.lastUpdateId,
    required this.bids,
    required this.asks,
  });

  OrderBook copyWith({
    int? firstUpdateId,
    int? lastUpdateId,
    List<List<double>>? bids,
    List<List<double>>? asks,
  }) =>
      OrderBook(
        firstUpdateId: firstUpdateId ?? this.firstUpdateId,
        lastUpdateId: lastUpdateId ?? this.lastUpdateId,
        bids: bids ?? this.bids,
        asks: asks ?? this.asks,
      );

  factory OrderBook.fromJson(String str) => OrderBook.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderBook.fromMap(Map<String, dynamic> json) => OrderBook(
        firstUpdateId: json["firstUpdateId"] ?? json["U"],
        lastUpdateId: json["lastUpdateId"] ?? json["u"],
        bids: List<List<double>>.from((json["bids"] ?? json["b"])
            .map((x) => List<double>.from(x.map((x) => double.parse(x))))),
        asks: List<List<double>>.from((json["asks"] ?? json["a"])
            .map((x) => List<double>.from(x.map((x) => double.parse(x))))),
      );

  Map<String, dynamic> toMap() => {
        "firstUpdateId": firstUpdateId,
        "lastUpdateId": lastUpdateId,
        "bids": List<dynamic>.from(
            bids.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "asks": List<dynamic>.from(
            asks.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class ExchangeSymbol {
  final String symbol;
  final String baseAsset;
  final String quoteAsset;

  ExchangeSymbol(
      {required this.symbol,
      required this.baseAsset,
      required this.quoteAsset});

  ExchangeSymbol copyWith(
          {String? symbol, String? baseAsset, String? quoteAsset}) =>
      ExchangeSymbol(
          symbol: symbol ?? this.symbol,
          baseAsset: baseAsset ?? this.baseAsset,
          quoteAsset: quoteAsset ?? this.quoteAsset);

  factory ExchangeSymbol.fromJson(String str) =>
      ExchangeSymbol.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeSymbol.fromMap(Map<String, dynamic> json) => ExchangeSymbol(
      symbol: json["symbol"],
      baseAsset: json["baseAsset"],
      quoteAsset: json["quoteAsset"]);

  Map<String, dynamic> toMap() => {
        "symbol": symbol,
        "baseAsset": baseAsset,
        "quoteAsset": quoteAsset,
      };
}
