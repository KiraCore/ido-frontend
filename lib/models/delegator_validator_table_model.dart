class DelegatorValidatorTableModel {
  final String symbol;
  final String tickerBase;
  final double priceBase;
  final String address;
  final String network;
  final double delegations;
  final double undelegations;
  final double hashrate;
  final double comission;
  final bool active;

  DelegatorValidatorTableModel({this.symbol, this.tickerBase, this.priceBase, this.address, this.network, this.delegations, this.undelegations, this.hashrate, this.comission, this.active}) {
    assert(symbol != null || tickerBase != null || priceBase != null || address != null || network != null || delegations != null || undelegations != null || hashrate != null || comission != null || active != null, 'Null value error');
  }
}
