import 'package:flutter/material.dart';

class ChartDelegationModel {
  final double timestamp;
  final double delegations;

  ChartDelegationModel({@required this.timestamp, @required this.delegations}) {
    assert(timestamp != null, 'timestamp is null');
    assert(delegations != null, 'delegations is null');
  }
}
