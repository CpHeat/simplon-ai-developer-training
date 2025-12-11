abstract class BalanceRemoteDatasource {
  Future<double> getBalance();
  Future<double> updateBalance(double amount);
}