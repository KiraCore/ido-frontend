import 'package:IDO_Kira/models/delegator_validator_table_model.dart';
import 'package:IDO_Kira/widgets/delegator_validators_data_Table.dart';
import 'package:flutter/material.dart';

class DelegatorValidatorTable extends StatefulWidget {
  final List<DelegatorValidatorTableModel> tableInfo;
  const DelegatorValidatorTable({
    Key key,
    @required this.tableInfo,
  }) : super(key: key);

  @override
  _DelegatorValidatorTableState createState() => _DelegatorValidatorTableState();
}

class _DelegatorValidatorTableState extends State<DelegatorValidatorTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DelegatorValidatorDataTable(widget.tableInfo)),
            ),
          )
        ],
      ),
    );
  }
}
