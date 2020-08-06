import 'package:IDO_Kira/models/validator_table_model.dart';
import 'package:IDO_Kira/widgets/validators_table.dart';
import 'package:flutter/material.dart';

class ValidatorTable extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ValidatorTable({
    Key key,
    @required this.tableInfo,
  }) : super(key: key);

  final List<ValidatorTableModel> tableInfo;

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
              child: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: false,
                radius: Radius.circular(35),
                thickness: 10,
                child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: ValidatorsTable(tableInfo)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
