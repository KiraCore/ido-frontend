import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ido_explorer/models/table_operators.dart';

class IdoDataTable extends StatelessWidget {
  List<TableOperators> tableInfo = [];

  IdoDataTable(this.tableInfo);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columnSpacing: 50,
        columns: [
          DataColumn(
              label: Flexible(
                  child: Text(
            'Token',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
          ))),
          DataColumn(
              label: Flexible(
                  child: Text(
            'Address ',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
          ))),
          DataColumn(
              label: Flexible(
                  child: Text(
            'Network ',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
          ))),
          DataColumn(
              label: Flexible(
                  child: Text(
            'Delegations',
            style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
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
        rows: tableInfo
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
                                color: Colors.grey,
                                onPressed: () {},
                                icon: Icon(Icons.do_not_disturb_on),
                              )),
                  )),
                ]))
            .toList());
  }
}
