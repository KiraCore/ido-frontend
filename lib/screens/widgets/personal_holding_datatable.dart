import 'package:flutter/material.dart';

class PersonalHoldings extends StatelessWidget {
  final String tokenName;
  final String tokenPrice;
  final String totalStaked;

  PersonalHoldings({this.tokenName = 'FakeCosmos', this.tokenPrice = 'FakePrice', this.totalStaked = '0'});

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(label: Text('Token Name')),
      DataColumn(label: Text('Price')),
      DataColumn(label: Text('Token Staked ')),
    ], rows: [
      DataRow(cells: [
        DataCell(ListTile(
          dense: false,
          leading: CircleAvatar(
            child: Image.asset(
              'assets/ido_logo.png',
              height: 10,
            ),
          ),
          title: Text(tokenName),
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tokenPrice),
            Text(tokenPrice),
          ],
        )),
        DataCell(
          Text(totalStaked),
        ),
      ]),
    ]);
  }
}
