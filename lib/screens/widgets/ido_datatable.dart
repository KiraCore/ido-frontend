import 'package:flutter/material.dart';


class IdoDataTable extends StatelessWidget {
  final String validatorName;
  final String stakedIn;
  final String delegators;
  final String comission;
  final String active;
  final String delegateNow;

  IdoDataTable(
      {this.validatorName = 'One',
      this.stakedIn = '1000',
      this.delegators = "11",
      this.comission = "100%",
      this.active = "YES",
      this.delegateNow = "TRUE"});

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(label: Flexible(child: Text('Monikor'))),
      DataColumn(label: Flexible(child: Text('Staked Bonded in '))),
      DataColumn(label: Flexible(child: Text('Delegators '))),
      DataColumn(label: Flexible(child: Text('Comission'))),
      DataColumn(label: Flexible(child: Text('Active'))),
      DataColumn(label: Flexible(child: Text('Start Mining'))),
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
