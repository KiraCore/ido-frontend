class Delegator {
  final int delegations;
  final double delegationsValue;
  final int undelegations;

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

  Delegator(
      {this.delegations,
      this.delegationsValue,
      this.undelegations,
      this.network,
      this.validatorAddress,
      this.delegatorAddress,
      this.tickerBase,
      this.tickerQuote,
      this.priceBase,
      this.priceQuote,
      this.claimedTotal,
      this.hashrate,
      this.minedTotal});
}
