import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../configs/base_viewmodel.dart';
import 'data_models/candle_ticker.dart';
import 'data_models/order_book.dart';
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

  int _currentLimit = 5;
  final _limits = [5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  Ticker? _currentTicker;
  List<Ticker> _tickers = [];

  List<Candle> _candles = [];

  OrderBook? _orderBook;
  ExchangeSymbol? _symbols;

  void setInterval(String interval) =>
      updateData(_currentTicker!, interval: interval);

  void setLimit(int limit) => updateData(_currentTicker!, limit: limit);

  void setTicker(Ticker ticker) {
    _currentTicker = null;
    _symbols = null;
    updateData(ticker, interval: _currentInterval, limit: _currentLimit);
  }

  Future<void> fetchSymbols() async {
    try {
      final tickers = await _repository.fetchSymbols();
      _tickers = tickers;
      if (tickers.isNotEmpty) {
        updateData(_tickers.first,
            interval: _currentInterval, limit: _currentLimit);
      }
    } catch (e) {
      setViewState(ViewState.failed);
      return;
    }
  }

  Future<void> updateData(Ticker ticker, {String? interval, int? limit}) async {
    // close current channel if exists
    _closeSocketConnection();

    if (interval != null) {
      _candles = [];
      _currentInterval = interval;
    }
    if (limit != null) {
      _orderBook = null;
      _currentLimit = limit;
    }
    setViewState(ViewState.processing);

    try {
      final rtnTicker = await _repository.fetchSymbol(ticker.symbol);
      _currentTicker = rtnTicker;

      final rtnSymbol = await _repository.fetchExchangeInfo(ticker.symbol);
      _symbols = rtnSymbol;
      // load candles info
      final rtnCandle = await _repository.fetchCandles(
          symbol: ticker.symbol, interval: _currentInterval);
      _candles = rtnCandle;

      final rtnOrderBook = await _repository.fetchOrderBook(
          symbol: ticker.symbol, limit: _currentLimit);
      _orderBook = rtnOrderBook;

      // connect to binance stream
      _connectAndListen(ticker);
      // update candles

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
        ticker.symbol.toLowerCase(), _currentInterval, _currentLimit);
    if (_channel != null) {
      _channel!.stream.listen(
        (message) {
          //log(name: 'Incoming', message);
          final map = jsonDecode(message) as Map<String, dynamic>;
          if (map['e'] == 'depthUpdate') {
            if (_orderBook == null) return;
            //Update order book
            final orderBook = OrderBook.fromMap(map);
            _orderBook = orderBook;
          }
          if (map['e'] == 'kline') {
            if (_candles.isEmpty) return;
            //Update candle
            final candleTicker = CandleTickerModel.fromJson(map);

            // cehck if incoming candle is an update on current last candle, or a new one
            if (_candles[0].date == candleTicker.candle.date &&
                _candles[0].open == candleTicker.candle.open) {
              // update last candle
              _candles[0] = candleTicker.candle;
            }
            // check if incoming new candle is next candle so the difrence
            // between times must be the same as last existing 2 candles
            else if (candleTicker.candle.date.difference(_candles[0].date) ==
                _candles[0].date.difference(_candles[1].date)) {
              // add new candle to list
              _candles.insert(0, candleTicker.candle);
            }
          }
          setViewState(ViewState.idle);
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

  List<int> get limits => _limits;
  int get currentLimit => _currentLimit;

  Ticker? get currentTicker => _currentTicker;
  List<Ticker> get tickers => _tickers;

  List<Candle> get candles => _candles;

  OrderBook? get orderBook => _orderBook;
  ExchangeSymbol? get symbols => _symbols;

  String get pairSymbol => symbols != null
      ? '${symbols!.baseAsset}/${symbols!.quoteAsset}'
      : currentTicker!.symbol;
}
