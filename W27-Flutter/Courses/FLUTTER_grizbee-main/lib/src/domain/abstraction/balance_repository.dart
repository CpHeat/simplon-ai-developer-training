abstract class BalanceRepository {
  Future<double> getBalance();
  Future<double> updateBalance(double amount);
}