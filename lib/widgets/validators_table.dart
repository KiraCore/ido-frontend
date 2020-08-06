import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ValidatorsTable extends StatefulWidget {
  List tableInfo = [];

  ValidatorsTable(this.tableInfo);

  ValidatorsTableState createState() {
    return new ValidatorsTableState();
  }
}

class ValidatorsTableState extends State<ValidatorsTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 50,
        sortColumnIndex: 0,
        sortAscending: true,
        columns: [
          DataColumn(
              label: Flexible(
                child: Text(
                  'Token',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              onSort: (i, b) {
                setState(() {
                  widget.tableInfo.sort((a, b) => a.symbol.compareTo(b.symbol));
                });
              }),
          DataColumn(
            label: Flexible(
                child: Text(
              'Address ',
              style: TextStyle(fontSize: 16, color: Colors.black),
            )),
          ),
          DataColumn(
              label: Flexible(
                  child: Text(
                'Network ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),
              onSort: (i, b) {
                setState(() {
                  widget.tableInfo.sort((a, b) => a.network.compareTo(b.network));
                });
              }),
          DataColumn(
              numeric: true,
              label: Flexible(
                  child: Text(
                'Delegations',
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),
              onSort: (i, b) {
                setState(() {
                  widget.tableInfo.sort((a, b) => a.delegations.compareTo(b.delegations));
                });
              }),
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
                'Comission',
                style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
              )),
              onSort: (i, b) {
                setState(() {
                  widget.tableInfo.sort((a, b) => a.comission.compareTo(b.comission));
                });
              }),
          DataColumn(
            label: Flexible(
                child: Text(
              'Active',
              style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
            )),
          ),
        ],
        rows: widget.tableInfo
            .map((e) => DataRow(cells: [
                  DataCell(Text(e.symbol)),
                  DataCell(Text(e.address)),
                  DataCell(Text(e.network)),
                  //DataCell(Text(e.delegatorsCount.toString())),
                  DataCell(Text(e.delegationsValue.toStringAsFixed(2))),
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
