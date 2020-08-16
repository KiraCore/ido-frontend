import 'package:IDO_Kira/models/ticker_priceModel.dart';
import 'package:flutter/material.dart';

import 'hidden_card.dart';

// ignore: must_be_immutable
class SideTokensPanel extends StatefulWidget {
  List<TickerPriceModel> tickerInfo = [];

  SideTokensPanel({this.tickerInfo});
  final ScrollController _sideScrollController = ScrollController();

  @override
  _SideTokensPanelState createState() => _SideTokensPanelState();
}

class _SideTokensPanelState extends State<SideTokensPanel> {
  @override
  Widget build(BuildContext context) {
    return HiddenCustomCard(
        child: Column(
      children: [
        Text(
          'Token prices to mine KEX',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        SizedBox(
            height: 300,
            child: Scrollbar(
              isAlwaysShown: false,
              thickness: 5,
              radius: Radius.circular(360),
              controller: widget._sideScrollController,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.tickerInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(widget.tickerInfo[index].symbol),
                    subtitle: Text('\$' + widget.tickerInfo[index].tickerPriceUSD.toStringAsFixed(2)),
                    dense: false,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(widget.tickerInfo[index].iconUrl),
                    ),
                  );
                },
              ),
            ))
      ],
    ));
  }
}
