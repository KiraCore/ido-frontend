class KiraModel {
  final double delegationsValue;
  final int hashrate;
  final int totalSupply;
  final int mintingSupply;
  final int minedTotal;
  final double totalIncome;
  final double softCap;
  final double hardCap;

  final double price;
  final int delegatorsCount;

  final int validatorsCount;
  final double start;
  final double stop;

  KiraModel({
    this.delegationsValue,
    this.hashrate,
    this.totalSupply,
    this.mintingSupply,
    this.minedTotal,
    this.totalIncome,
    this.softCap,
    this.hardCap,
    this.price,
    this.delegatorsCount,
    this.validatorsCount,
    this.start,
    this.stop,
  }) {
    assert(delegationsValue != null || hashrate != null || totalSupply != null || mintingSupply != null || minedTotal != null || totalIncome != null || softCap != null || hardCap != null || price != null || validatorsCount != null || start != null || stop != null, 'Null value error');
  }
}
