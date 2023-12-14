import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../res/app_endpoints.dart';
import 'data_models/ticker.dart';

class Repository {
  Future<List<Candle>> fetchCandles(
      {required String symbol, required String interval, int? endTime}) async {
    final uri = Uri.parse(AppEndpoints.candlesUrl(
        symbol: symbol, interval: interval, endTime: endTime));
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<Ticker>> fetchSymbols() async {
    final uri = Uri.parse(AppEndpoints.symbolsUrl);
    final res = await http.get(uri);
    return List<Ticker>.from(
        (jsonDecode(res.body) as List<dynamic>).map((x) => Ticker.fromMap(x)));
  }

  Future<Ticker> fetchSymbol(String symbol) async {
    final uri = Uri.parse(AppEndpoints.symbolUrl(symbol));
    final res = await http.get(uri);
    return Ticker.fromJson(res.body);
  }

  WebSocketChannel establishConnection(String symbol, String interval,
      [int limit = 100]) {
    final channel = WebSocketChannel.connect(
      Uri.parse(AppEndpoints.establishConnectionUrl),
    );
    channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["$symbol@kline_$interval"],
          "id": 1
        },
      ),
    );
    /*channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["$symbol@depth@${limit}ms"],
          "id": 2
        },
      ),
    );*/
    return channel;
  }
}
