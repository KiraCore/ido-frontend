import 'dart:convert';
import 'dart:typed_data';

import 'package:IDO_Kira/models/delegator_model.dart';
import 'package:IDO_Kira/models/ticker_priceModel.dart';
import 'package:bech32/bech32.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;

import 'package:IDO_Kira/models/kira_model.dart';

class InfoService {
  List<KiraModel> kiraInfo = [];
  List<TickerPriceModel> tickerInfo = [];
  List<DelegatorModel> delegatorInfo = [];

  Future<void> getKiraInfo() async {
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/offering/summary.json");
    var jsonData = json.decode(data.body);

    KiraModel kira = KiraModel(
      delegationsValue: jsonData['delegations_value'],
      delegatorsCount: jsonData['delegators_count'],
      validatorsCount: jsonData['validators_count'],
      softCap: jsonData['soft_cap'],
      hardCap: jsonData['hard_cap'],
      start: jsonData['start'], //INT
      stop: jsonData['stop'], //INT
      hashrate: jsonData['hashrate'], //DOUBLE
      price: jsonData['price'],
      minedTotal: jsonData['mined_total '],
      mintingSupply: jsonData['minting_supply'],
      totalSupply: jsonData['total_supply'],
      totalIncome: jsonData['total_income'],
    );
    kiraInfo.add(kira);
  }

  Future<void> getTickerInfo() async {
    var data = await http.get("https://oracle.kiracore.com/tickers/summary.json");

    var jsonData = json.decode(data.body);

    jsonData['tickers'].forEach((element) {
      TickerPriceModel token = TickerPriceModel(iconUrl: element['icon'], symbol: element['coin']['symbol'], tickerPriceUSD: element['price_usd'], tickerPriceBTC: element['price_btc']);
      tickerInfo.add(token);
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

  Future<void> getDelegatorInfo({address}) async {
    var hexAddress = retrieveHex(address: address);
    var data = await http.get("https://ido-test.kiracore.com/KIRA-IDO-TEST/delegators/$hexAddress/summary.json");
    var jsonData = json.decode(data.body);
    //print('$address');
    DelegatorModel delegator = DelegatorModel(
      kiraAddress: jsonData['kira_address'],
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
