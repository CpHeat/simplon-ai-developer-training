import 'package:grizbee/src/data/abstraction/balance_local_datasource.dart';
import 'package:grizbee/src/data/abstraction/balance_remote_datasource.dart';
import 'package:grizbee/src/domain/abstraction/balance_repository.dart';
import 'package:get_it/get_it.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final balanceLocalDatasource = GetIt.instance.get<BalanceLocalDatasource>();
  final balanceRemoteDatasource = GetIt.instance.get<BalanceRemoteDatasource>();

  @override
  Future<double> getBalance() async {
    return balanceRemoteDatasource.getBalance();
  }

  @override
  Future<double> updateBalance(double amount) {
    return balanceRemoteDatasource.updateBalance(amount);
  }
}
