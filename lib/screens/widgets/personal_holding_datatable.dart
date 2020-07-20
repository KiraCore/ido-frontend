import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalHoldings extends StatelessWidget {
  final String tokenName;
  final String tokenPrice;
  final String totalStaked;

  PersonalHoldings({this.tokenName = 'FakeCosmos', this.tokenPrice = '1.40', this.totalStaked = '0'});

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(
          label: Text(
        'Token Name',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      )),
      DataColumn(
          label: Text(
        'Price',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      )),
      DataColumn(
          label: Text(
        'Staked',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      )),
    ], rows: [
      DataRow(cells: [
        DataCell(ListTile(
          dense: false,
          leading: CircleAvatar(
            child: Image.network('https://s2.coinmarketcap.com/static/img/coins/200x200/3794.png'),
          ),
          title: Text(
            'Cosmos (ATOM)',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
          ),
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tokenPrice, style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            Text('(1.25%)'),
          ],
        )),
        DataCell(
          Text(totalStaked),
        ),
      ]),
      DataRow(cells: [
        DataCell(ListTile(
          dense: false,
          leading: CircleAvatar(
            child: Image.network(
              'https://pbs.twimg.com/profile_images/1267754825476907010/yFy0NuTQ.jpg',
            ),
          ),
          title: Text(
            'KIRA (KEK)',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
          ),
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tokenPrice, style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            Text('(1.25%)'),
          ],
        )),
        DataCell(
          Text(totalStaked),
        ),
      ]),
      DataRow(cells: [
        DataCell(ListTile(
          dense: false,
          leading: CircleAvatar(
            child: Image.network('https://assets.coingecko.com/coins/images/3326/large/Webp.net-resizeimage_%288%29.png?1547037927'),
          ),
          title: Text(
            'Dfinity (DFN)',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
          ),
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tokenPrice, style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            Text('(1.25%)'),
          ],
        )),
        DataCell(
          Text(totalStaked),
        ),
      ]),
      DataRow(cells: [
        DataCell(ListTile(
          dense: false,
          leading: CircleAvatar(
            child: Image.network('https://assets.coingecko.com/coins/images/3625/large/download_%287%29.png?1547038545'),
          ),
          title: Text(
            'Sentinel (SENT)',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
          ),
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tokenPrice, style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            Text('(1.25%)'),
          ],
        )),
        DataCell(
          Text(totalStaked),
        ),
      ]),
    ]);
  }
}
