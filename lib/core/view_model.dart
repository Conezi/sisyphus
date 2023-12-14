import 'dart:convert';
import 'dart:developer';

import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../configs/base_viewmodel.dart';
import 'data_models/candle_ticker.dart';
import 'data_models/ticker.dart';
import 'repository.dart';

class ViewModel extends BaseViewModel {
  ViewModel._();

  static final _instance = ViewModel._();
  static ViewModel get instance => _instance;

  final _repository = Repository();

  WebSocketChannel? _channel;

  String _currentInterval = "1h";
  final _intervals = [
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M'
  ];

  Ticker? _currentTicker;
  List<Ticker> _tickers = [];

  List<Candle> _candles = [];

  void setInterval(String interval) {
    _currentInterval = interval;
    updateData(_currentTicker!, _currentInterval);
  }

  void setTicker(Ticker ticker) {
    _currentTicker = ticker;
    updateData(_currentTicker!, _currentInterval);
  }

  Future<void> fetchSymbols() async {
    try {
      final tickers = await _repository.fetchSymbols();
      _tickers = tickers;
      if (tickers.isNotEmpty) {
        updateData(_tickers.first, _currentInterval);
      }
    } catch (e) {
      setViewState(ViewState.failed);
      return;
    }
  }

  Future<void> updateData(Ticker ticker, String interval) async {
    // close current channel if exists
    _closeSocketConnection();

    _candles = [];
    _currentInterval = interval;
    setViewState(ViewState.processing);
    try {
      final rtnTicker = await _repository.fetchSymbol(ticker.symbol);
      // load candles info
      final rtnCandle = await _repository.fetchCandles(
          symbol: ticker.symbol, interval: interval);
      // connect to binance stream
      _connectAndListen(ticker);
      // update candles
      _candles = rtnCandle;
      _currentInterval = interval;
      _currentTicker = rtnTicker;
      setViewState(ViewState.success);
    } catch (e) {
      setViewState(ViewState.failed);
      return;
    }
  }

  Future<void> fetchMoreCandles() async {
    try {
      // load candles info
      final data = await _repository.fetchCandles(
          symbol: _currentTicker!.symbol,
          interval: currentInterval,
          endTime: candles.last.date.millisecondsSinceEpoch);
      candles.removeLast();
      candles.addAll(data);
      setViewState(ViewState.success);
    } catch (e) {
      setViewState(ViewState.failed);
      return;
    }
  }

  void _connectAndListen(Ticker ticker) {
    _channel = _repository.establishConnection(
        ticker.symbol.toLowerCase(), _currentInterval);
    if (_channel != null) {
      _channel!.stream.listen(
        (message) {
          log(name: 'Incoming', message);
          final map = jsonDecode(message) as Map<String, dynamic>;
          if (map['e'] == 'depthUpdate') {
            //Update depth
          }
          if (map['e'] == 'kline') {
            if (candles.isEmpty) return;
            //Update candle
            final candleTicker = CandleTickerModel.fromJson(map);

            // cehck if incoming candle is an update on current last candle, or a new one
            if (candles[0].date == candleTicker.candle.date &&
                candles[0].open == candleTicker.candle.open) {
              // update last candle
              candles[0] = candleTicker.candle;
            }
            // check if incoming new candle is next candle so the difrence
            // between times must be the same as last existing 2 candles
            else if (candleTicker.candle.date.difference(candles[0].date) ==
                candles[0].date.difference(candles[1].date)) {
              // add new candle to list
              candles.insert(0, candleTicker.candle);
            }
          }
        },
        onDone: () => _closeSocketConnection(),
        onError: (error) {
          // Handle WebSocket errors
          return;
        },
      );
    }
  }

  void _closeSocketConnection() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
  }

  Stream<dynamic>? get socketStream =>
      _channel != null ? _channel!.stream : null;

  List<String> get intervals => _intervals;
  String get currentInterval => _currentInterval;

  Ticker? get currentTicker => _currentTicker;
  List<Ticker> get tickers => _tickers;

  List<Candle> get candles => _candles;
}
