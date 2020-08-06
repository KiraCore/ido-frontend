class ValidatorModel {
  final String symbol;
  final String address;
  final String network;
  final double delegatorsCount;
  final double delegations;
  final double delegationsValue;
  final double comission;
  final bool active;

  ValidatorModel({this.active, this.symbol, this.address, this.network, this.delegatorsCount, this.delegations, this.delegationsValue, this.comission}) {
    assert(active != null || symbol != null || address != null || network != null || delegatorsCount != null || delegations != null || delegationsValue != null || comission != null, 'Null value error');
  }
}
