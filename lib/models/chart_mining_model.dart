import 'package:flutter/material.dart';

class ChartMiningModel {
  final double timestamp;
  final double hash;

  ChartMiningModel({@required this.timestamp, @required this.hash}) {
    assert(timestamp != null, 'timestamp is null');
    assert(hash != null, 'hash is null');
  }
}
