class TableOperators {
  final String symbol;
  final String address;
  final String network;
  final double delegatorsCount;
  final double delegations;
  final double delegationsValue;
  final double comission;
  final bool active;

  TableOperators({this.active, this.symbol, this.address, this.network, this.delegatorsCount, this.delegations, this.delegationsValue, this.comission});
}

//Validator address, network, delegations & their value
//reports[<index>].delegations/symbol/validator_address/symbol ...
