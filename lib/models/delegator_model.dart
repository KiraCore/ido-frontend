class DelegatorModel {
  final int delegations;
  final double delegationsValue;
  final int undelegations;

  final String kiraAddress;
  final String network;
  final String validatorAddress;
  final String delegatorAddress;

  final String tickerBase;
  final String tickerQuote;
  final double priceBase;
  final double priceQuote;
  final int claimedTotal;

  final int hashrate;
  final int minedTotal;

  DelegatorModel({this.kiraAddress, this.delegations, this.delegationsValue, this.undelegations, this.network, this.validatorAddress, this.delegatorAddress, this.tickerBase, this.tickerQuote, this.priceBase, this.priceQuote, this.claimedTotal, this.hashrate, this.minedTotal}) {
    assert(kiraAddress != null || delegations != null || delegationsValue != null || undelegations != null || network != null || validatorAddress != null || delegatorAddress != null || tickerBase != null || tickerQuote != null || priceBase != null || priceQuote != null || claimedTotal != null || hashrate != null || minedTotal != null, 'Null value error');
  }
}
