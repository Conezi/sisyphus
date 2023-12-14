import 'dart:convert';

class Ticker {
  final String symbol;
  final String priceChange;
  final String? priceChangePercent;
  final String? weightedAvgPrice;
  final String? prevClosePrice;
  final String? lastPrice;
  final String? lastQty;
  final String? bidPrice;
  final String? bidQty;
  final String? askPrice;
  final String? askQty;
  final String? openPrice;
  final String? highPrice;
  final String? lowPrice;
  final String? volume;
  final String? quoteVolume;
  final int? openTime;
  final int? closeTime;
  final int? firstId;
  final int? lastId;
  final int? count;

  Ticker({
    required this.symbol,
    required this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.prevClosePrice,
    this.lastPrice,
    this.lastQty,
    this.bidPrice,
    this.bidQty,
    this.askPrice,
    this.askQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstId,
    this.lastId,
    this.count,
  });

  Ticker copyWith({
    String? symbol,
    String? priceChange,
    String? priceChangePercent,
    String? weightedAvgPrice,
    String? prevClosePrice,
    String? lastPrice,
    String? lastQty,
    String? bidPrice,
    String? bidQty,
    String? askPrice,
    String? askQty,
    String? openPrice,
    String? highPrice,
    String? lowPrice,
    String? volume,
    String? quoteVolume,
    int? openTime,
    int? closeTime,
    int? firstId,
    int? lastId,
    int? count,
  }) =>
      Ticker(
        symbol: symbol ?? this.symbol,
        priceChange: priceChange ?? this.priceChange,
        priceChangePercent: priceChangePercent ?? this.priceChangePercent,
        weightedAvgPrice: weightedAvgPrice ?? this.weightedAvgPrice,
        prevClosePrice: prevClosePrice ?? this.prevClosePrice,
        lastPrice: lastPrice ?? this.lastPrice,
        lastQty: lastQty ?? this.lastQty,
        bidPrice: bidPrice ?? this.bidPrice,
        bidQty: bidQty ?? this.bidQty,
        askPrice: askPrice ?? this.askPrice,
        askQty: askQty ?? this.askQty,
        openPrice: openPrice ?? this.openPrice,
        highPrice: highPrice ?? this.highPrice,
        lowPrice: lowPrice ?? this.lowPrice,
        volume: volume ?? this.volume,
        quoteVolume: quoteVolume ?? this.quoteVolume,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
        firstId: firstId ?? this.firstId,
        lastId: lastId ?? this.lastId,
        count: count ?? this.count,
      );

  factory Ticker.fromJson(String str) => Ticker.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticker.fromMap(Map<String, dynamic> json) => Ticker(
        symbol: json["symbol"],
        priceChange: json["priceChange"] ?? json["price"],
        priceChangePercent: json["priceChangePercent"],
        weightedAvgPrice: json["weightedAvgPrice"],
        prevClosePrice: json["prevClosePrice"],
        lastPrice: json["lastPrice"],
        lastQty: json["lastQty"],
        bidPrice: json["bidPrice"],
        bidQty: json["bidQty"],
        askPrice: json["askPrice"],
        askQty: json["askQty"],
        openPrice: json["openPrice"],
        highPrice: json["highPrice"],
        lowPrice: json["lowPrice"],
        volume: json["volume"],
        quoteVolume: json["quoteVolume"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        firstId: json["firstId"],
        lastId: json["lastId"],
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "priceChangePercent": priceChangePercent,
        "weightedAvgPrice": weightedAvgPrice,
        "prevClosePrice": prevClosePrice,
        "lastPrice": lastPrice,
        "lastQty": lastQty,
        "bidPrice": bidPrice,
        "bidQty": bidQty,
        "askPrice": askPrice,
        "askQty": askQty,
        "openPrice": openPrice,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "volume": volume,
        "quoteVolume": quoteVolume,
        "openTime": openTime,
        "closeTime": closeTime,
        "firstId": firstId,
        "lastId": lastId,
        "count": count,
      };
}
