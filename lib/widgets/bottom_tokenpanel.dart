import 'package:IDO_Kira/models/ticker_priceModel.dart';
import 'package:flutter/material.dart';

import 'hidden_card.dart';

// ignore: must_be_immutable
class BottomTokenPanel extends StatefulWidget {
  List<TickerPriceModel> tickerInfo = [];

  BottomTokenPanel({this.tickerInfo});

  @override
  _BottomTokenPanelState createState() => _BottomTokenPanelState();
}

class _BottomTokenPanelState extends State<BottomTokenPanel> {
  final ScrollController _bottomScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return HiddenCustomCard(
        child: Column(
      children: [
        Text(
          'Token prices to mine KEK',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        SizedBox(
          height: 70,
          child: Scrollbar(
            controller: _bottomScrollController,
            isAlwaysShown: false,
            thickness: 10,
            radius: Radius.circular(35),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.tickerInfo.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 180,
                  child: ListTile(
                    title: Text(widget.tickerInfo[index].symbol),
                    subtitle: Text('\$' + widget.tickerInfo[index].tickerPriceUSD.toStringAsFixed(2)),
                    dense: false,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(widget.tickerInfo[index].iconUrl),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
