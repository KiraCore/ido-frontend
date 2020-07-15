import 'package:http/http.dart' as http;
import 'package:ido_explorer/models/delegator.dart';
import 'dart:convert';

import 'package:ido_explorer/models/global.dart';

class ApiServices {
  final String address;
  List<Delegator> delegatorInfo = [];
  List<Global> globalInfo = [];

  ApiServices({this.address});

  Future<void> getDelegator() async {
    var data = await http
        .get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$address/summary.json");
    var jsonData = json.decode(data.body);

    Delegator delegator = Delegator(
      delegations: jsonData['reports'][0]['delegations'],
      delegationsValue: jsonData['reports'][0]['delegations_value'],
      undelegations: jsonData['reports'][0]['undelegations'],
      network: jsonData['reports'][0]['network'],
      validatorAddress: jsonData['reports'][0]['validator_address'],
      delegatorAddress: jsonData['reports'][0]['delegator_address'],
      tickerBase: jsonData['reports'][0]['ticker_base'],
      tickerQuote: jsonData['reports'][0]['ticker_quote'],
      priceBase: jsonData['reports'][0]['price_base'],
      priceQuote: jsonData['reports'][0]['price_quote'],
      claimedTotal: jsonData['reports'][0]['claimed_total'],
      hashrate: jsonData['reports'][0]['hashrate'],
      minedTotal: jsonData['mined_total'],
    );
    delegatorInfo.add(delegator);
  }

  Future<void> getGlobal() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);

    Global global = Global(
      delegationsValue: jsonData['delegations_value'],
      delegatorsCount: jsonData['delegators_count'],
      validatorsCount: jsonData['validators_count'],
      softCap: jsonData['soft_cap'],
      hardCap: jsonData['hard_cap'],
      start: jsonData['start'],
      stop: jsonData['stop'],
      hashrate: jsonData['hashrate'],
      price: jsonData['price'],
      minedTotal: jsonData['mined_total '],
      mintingSupply: jsonData['minting_supply'],
      totalSupply: jsonData['total_supply'],
      totalIncome: jsonData['total_income'],
    );
    globalInfo.add(global);
  }
}
