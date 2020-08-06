import 'package:flutter/material.dart';

class TickerPriceModel {
  final String symbol;
  final String iconUrl;
  final double tickerPriceUSD;
  final double tickerPriceBTC;

  TickerPriceModel({@required this.symbol, this.iconUrl, this.tickerPriceUSD = 0, this.tickerPriceBTC = 0}) {
    assert(symbol != null, 'symbol is null');
    assert(iconUrl != null, 'iconUrl is null');
    assert(tickerPriceUSD != null, 'tickerPriceUSD is null');
    assert(tickerPriceBTC != null, 'tickerPriceBTC is null');
  }
}
