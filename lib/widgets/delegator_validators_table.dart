import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DelegatorValidatorsTable extends StatefulWidget {
  List tableInfo = [];

  DelegatorValidatorsTable(this.tableInfo);

  DelegatorValidatorsTableState createState() {
    return new DelegatorValidatorsTableState();
  }
}

class DelegatorValidatorsTableState extends State<DelegatorValidatorsTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 50,
        sortColumnIndex: 0,
        sortAscending: true,
        columns: [
          /*
          DataColumn(
              label: Flexible(
                  child: Text(
            'Token',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ))),
          */
          DataColumn(
              label: Flexible(
                  child: Text(
            'Validator Address',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ))),
          /*
          DataColumn(
              label: Flexible(
                  child: Text(
            'Network ',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ))),
          */
          DataColumn(
              numeric: true,
              label: Flexible(
                  child: Text(
                'Delegations',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ))),
          DataColumn(
              numeric: true,
              label: Flexible(
                  child: Text(
                'Undelegation',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ))),
          /*
          DataColumn(
              label: Flexible(
                  child: Text(
            'Delegations',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
          ))),
          */
          DataColumn(
              numeric: true,
              label: Flexible(
                  child: Text(
                'Hashrate',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ))),
          DataColumn(
              numeric: true,
              label: Flexible(
                  child: Text(
                'Comission',
                style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
              ))),
          DataColumn(
              label: Flexible(
                  child: Text(
            'Active',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
          ))),
        ],
        rows: widget.tableInfo
            .map((e) => DataRow(cells: [
                  //DataCell(Text(e.tickerBase)),
                  DataCell(Text(e.address)),
                  //DataCell(Text(e.network)),
                  //DataCell(Text(e.delegatorsCount.toString())),
                  DataCell(Text(e.delegations.toStringAsFixed(2))),
                  DataCell(Text(e.undelegations.toStringAsFixed(2))),
                  DataCell(Text(e.hashrate.toStringAsFixed(2))),
                  DataCell(Text(e.comission.toStringAsFixed(2) + '%')),
                  DataCell(Card(
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: e.active
                            ? IconButton(
                                color: Colors.green,
                                onPressed: () {},
                                icon: Icon(Icons.done_outline),
                              )
                            : IconButton(
                                color: Colors.red,
                                onPressed: () {},
                                icon: Icon(Icons.do_not_disturb_on),
                              )),
                  )),
                ]))
            .toList());
  }
}
