import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ido_explorer/models/chart_delegation.dart';
import 'package:ido_explorer/models/chart_income.dart';
import 'package:ido_explorer/models/chart_mining.dart';
import 'package:ido_explorer/models/table_operators.dart';

class APIChartService {
  List<ChartDelegation> chartDelegation = [];
  List<ChartMining> chartMining = [];
  List<ChartIncome> chartIncome = [];

  List<TableOperators> tableOperators = [];

  Future<void> getDelegationsChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");

    var jsonData = json.decode(data.body);

    Map _sample = jsonData['delegations_report'];
//double.parse(key)
    _sample.forEach((key, value) {
      ChartDelegation delegationsValues = ChartDelegation(double.parse(key), value);
      //print("$key : $value");
      //print(key.runtimeType);
      //print(value.runtimeType);

      //String formateDate(DateTime date) => new DateFormat("MMM d").format(date);
      //print(formateDate.toString());
      //print(DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000));

      //DateTime dateValue = DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000);
      //DateTime pastMonth = dateValue.subtract(Duration(days: 10));
      //print(pastMonth);
      //print(dateValue);

      //String now = key;
      //print(now);
      chartDelegation.add(delegationsValues);
    });
  }

  Future<void> getIncomeChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");

    var jsonData = json.decode(data.body);

    Map _sample = jsonData['income_report'];
//double.parse(key)
    _sample.forEach((key, value) {
      ChartIncome incomeValues = ChartIncome(double.parse(key), value);
      //print("$key : $value");
      //print(key.runtimeType);
      //print(value.runtimeType);

      //String formateDate(DateTime date) => new DateFormat("MMM d").format(date);
      //print(formateDate.toString());
      //print(DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000));

      //DateTime dateValue = DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000);
      //DateTime pastMonth = dateValue.subtract(Duration(days: 10));
      //print(pastMonth);
      //print(dateValue);

      //String now = key;
      //print(now);
      chartIncome.add(incomeValues);
    });
  }

  Future<void> getMinerChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");

    var jsonData = json.decode(data.body);

    Map _sample = jsonData['mining_report'];
//double.parse(key)
    _sample.forEach((key, value) {
      ChartMining minerValues = ChartMining(double.parse(key), value);
      //print("$key : $value");
      //print(key.runtimeType);
      //print(value.runtimeType);

      //String formateDate(DateTime date) => new DateFormat("MMM d").format(date);
      //print(formateDate.toString());
      //print(DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000));

      //DateTime dateValue = DateTime.fromMicrosecondsSinceEpoch(int.parse(key) * 1000);
      //DateTime pastMonth = dateValue.subtract(Duration(days: 10));
      //print(pastMonth);
      //print(dateValue);

      //String now = key;
      //print(now);
      chartMining.add(minerValues);
    });
  }

  Future<void> getOperatorsTable() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");

    var jsonData = json.decode(data.body);
    jsonData['operators'].forEach((element) {
      TableOperators operatorsValues = TableOperators(
          symbol: element['symbol'],
          address: element['address'],
          network: element['network'],
          delegatorsCount: element['delegators_count'],
          delegations: element['delegations'],
          delegationsValue: element['delegations_value'],
          comission: element['comission'],
          active: element['active']);
      tableOperators.add(operatorsValues);
    });
  }
}
