import 'package:flutter/material.dart';

class ChartValidatorIncomeModel {
  final double timestamp;
  final double delegations;

  ChartValidatorIncomeModel({@required this.timestamp, @required this.delegations}) {
    assert(timestamp != null, 'timestamp is null');
    assert(delegations != null, 'delegations is null');
  }
}
