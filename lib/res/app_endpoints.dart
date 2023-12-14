class AppEndpoints {
  static String establishConnectionUrl = "wss://stream.binance.com:9443/ws";
  static String symbolsUrl = "https://api.binance.com/api/v3/ticker/price";
  static String symbolUrl(String symbol) =>
      "https://api.binance.com/api/v3/ticker/24hr?symbol=$symbol";
  static String candlesUrl(
          {required String symbol, required String interval, int? endTime}) =>
      "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}";
  static String orderBooksUrl({required String symbol, required int limit}) =>
      "https://api.binance.com/api/v3/depth?symbol=$symbol&limit=$limit";
  static String exchangeInfoUrl(String symbol) =>
      "https://api.binance.com/api/v3/exchangeInfo?symbol=$symbol";
}
