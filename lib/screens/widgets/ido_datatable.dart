import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdoDataTable extends StatelessWidget {
  final String validatorName;
  final String stakedIn;
  final String delegators;
  final String comission;
  final String active;
  final String delegateNow;

  IdoDataTable({this.validatorName = 'One', this.stakedIn = '1000', this.delegators = "11", this.comission = "100%", this.active = "YES", this.delegateNow = "TRUE"});

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(
          label: Flexible(
              child: Text(
        'Monikor',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Staked Bonded in ',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Delegators ',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      ))),
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
      DataColumn(
          label: Flexible(
              child: Text(
        'Start Mining',
        style: GoogleFonts.sourceSansPro(textStyle: TextStyle(fontSize: 16, color: Colors.black)),
      ))),
    ], rows: [
      DataRow(cells: [
        DataCell(
          Text(validatorName),
        ),
        DataCell(
          Text(stakedIn),
        ),
        DataCell(
          Text(delegators),
        ),
        DataCell(
          Text(comission),
        ),
        DataCell(active == 'YES'
            ? Icon(
                Icons.done_outline,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              )),
        DataCell(RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.white,
          highlightColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Delegate now',
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        )),
      ])
    ]);
  }
}
