class UrlConst {
  static const baseUrl = "https://api.coingecko.com/api/v3/coins/";
  static const list = "markets";
  static const chartUrl =
      'https://www.tradingview.com/widgetembed/?symbol=COINBASE:';
  static const chartQuery =
      '&interval=60&hidesidetoolbar=1&saveimage=1&toolbarbg=F1F3F6';
  static const newsUrl = "https://newsapi.org/v2/everything";
  static const queryString =
      "?q=cryptocurrency&apiKey=ddebe25ee080469d865b4ada1944ff92";
  static String getNewsByPage(int page) {
    return "?q=cryptocurrency&page=${page.toString()}&pageSize=20&apiKey=ddebe25ee080469d865b4ada1944ff92";
  }

  static String getWssMessage(String symbol) {
    return '{"type": "subscribe", "product_ids": ["$symbol-USD"], "channels": ["ticker"]}';
  }

  static const detailUrl = "wss://ws-feed.exchange.coinbase.com";
  static const favoriteUrl =
      "markets?vs_currency=usd&ids=bitcoin,ethereum&price_change_percentage=1h,24h,7d";

  static String getFavoriteCoins(List<String> names) {
    return "${baseUrl}markets?vs_currency=usd&ids=${names.join(",")}&price_change_percentage=1h,24h,7d";
  }
}
