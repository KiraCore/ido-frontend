import 'dart:convert';
import 'dart:typed_data';
import 'package:IDO_Kira/models/delegator_validator_table_model.dart';
import 'package:IDO_Kira/models/validator_table_model.dart';
import 'package:bech32/bech32.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:IDO_Kira/models/chart_delegationModel.dart';
import 'package:IDO_Kira/models/chart_mining_model.dart';
import 'package:IDO_Kira/models/chart_validator_income_model.dart';

class ChartService {
  final String address;

  ChartService({this.address = ''}) {
    assert(address != null, 'ChartService is provided a null address');
  }
  List<ChartDelegationModel> chartIdoDelegation = [];
  List<ChartDelegationModel> chartDelegatorDelegation = [];
  List<ChartMiningModel> chartIdoMining = [];
  List<ChartMiningModel> chartDelegatorMining = [];
  List<ChartValidatorIncomeModel> chartIdoIncome = [];
  List<ChartValidatorIncomeModel> chartDelegatorIncome = [];

  List<ValidatorTableModel> validatorTable = [];
  List<DelegatorValidatorTableModel> delegatorValidatorTable = [];

  Future<void> getDelegatorDelegationChart({address}) async {
    var hexAddress = retrieveHex(address: address);
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$hexAddress/summary.json");
    var jsonData = json.decode(data.body);

    Map _sample = jsonData['delegations_value_report'];
    _sample.forEach((key, value) {
      ChartDelegationModel delegatorDelegationsValues = ChartDelegationModel(timestamp: double.parse(key), delegations: value);
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
      chartDelegatorDelegation.add(delegatorDelegationsValues);
    });
  }

  String retrieveHex({String address}) {
    Bech32Codec bech32codec = Bech32Codec();
    var bech32 = bech32codec.decode(address);
    //Convert address from 5 bit to 8 bit
    var converted8bitBech32 = _convertBits(bech32.data, 5, 8);
    var hexAddress = HEX.encode(converted8bitBech32);
    return hexAddress;
  }

  Future<void> getIdoDelegationChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);
    Map _sample = jsonData['delegations_report'];

    _sample.forEach((key, value) {
      ChartDelegationModel idoDelegationsValues = ChartDelegationModel(timestamp: double.parse(key), delegations: value);
      chartIdoDelegation.add(idoDelegationsValues);
    });
  }

  Future<void> getIncomeChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);
    Map _sample = jsonData['income_report'];

    _sample.forEach((key, value) {
      ChartValidatorIncomeModel idoIncomeValues = ChartValidatorIncomeModel(timestamp: (double.parse(key)), delegations: value);
      chartIdoIncome.add(idoIncomeValues);
    });
  }

  Future<void> getDelegatorIncomeChart({address}) async {
    var hexAddress = retrieveHex(address: address);
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$hexAddress/summary.json");
    var jsonData = json.decode(data.body);
    Map _sample = jsonData['validator_income_report'];

    _sample.forEach((key, value) {
      ChartValidatorIncomeModel delegatorIncomeValues = ChartValidatorIncomeModel(timestamp: (double.parse(key)), delegations: value);
      chartDelegatorIncome.add(delegatorIncomeValues);
    });
  }

  Future<void> getMinerChart() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);
    Map _sample = jsonData['mining_report'];

    _sample.forEach((key, value) {
      ChartMiningModel minerValues = ChartMiningModel(timestamp: double.parse(key), hash: value);
      chartIdoMining.add(minerValues);
    });
  }

  Future<void> getDelegatorMinerChart({address}) async {
    var hexAddress = retrieveHex(address: address);
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$hexAddress/summary.json");
    var jsonData = json.decode(data.body);
    Map _sample = jsonData['quote_mining_report'];

    _sample.forEach((key, value) {
      ChartMiningModel minerValues = ChartMiningModel(timestamp: double.parse(key), hash: value);
      chartDelegatorMining.add(minerValues);
    });
  }

  Future<void> getValidatorTable() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);
    jsonData['operators'].forEach((element) {
      ValidatorTableModel validatorIncome = ValidatorTableModel(symbol: element['symbol'], address: element['address'], network: element['network'], delegatorsCount: element['delegators_count'], delegations: element['delegations'], delegationsValue: element['delegations_value'], comission: element['comission'], active: element['active']);
      validatorTable.add(validatorIncome);
    });
  }

  Future<void> getDelegatorValidatorTable({address}) async {
    var hexAddress = retrieveHex(address: address);
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$hexAddress/summary.json");
    var jsonData = json.decode(data.body);

    jsonData['reports'].forEach((element) {
      DelegatorValidatorTableModel delegatorValidatorIncome = DelegatorValidatorTableModel(tickerBase: element['ticker_base'], priceBase: element['price_base'], address: element['validator_address'], network: element['network'], delegations: element['delegations'], undelegations: element['undelegations'], hashrate: element['hashrate'], comission: 500.0, active: false);
      delegatorValidatorTable.add(delegatorValidatorIncome);
    });
  }
}

Uint8List _convertBits(
  List<int> data,
  int from,
  int to, {
  bool pad = true,
}) {
  var acc = 0;
  var bits = 0;
  final result = <int>[];
  final maxv = (1 << to) - 1;

  for (var v in data) {
    if (v < 0 || (v >> from) != 0) {
      throw Exception();
    }
    acc = (acc << from) | v;
    bits += from;
    while (bits >= to) {
      bits -= to;
      result.add((acc >> bits) & maxv);
    }
  }

  if (pad) {
    if (bits > 0) {
      result.add((acc << (to - bits)) & maxv);
    }
  } else if (bits >= from) {
    throw Exception('illegal zero padding');
  } else if (((acc << (to - bits)) & maxv) != 0) {
    throw Exception('non zero');
  }

  return Uint8List.fromList(result);
}
