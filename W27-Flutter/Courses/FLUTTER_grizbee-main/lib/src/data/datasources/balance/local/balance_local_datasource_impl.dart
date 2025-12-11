import 'package:grizbee/src/data/abstraction/balance_local_datasource.dart';
import 'package:grizbee/src/data/datasources/mock_balance.dart';
import 'package:grizbee/src/data/datasources/mock_constants.dart';
import 'package:grizbee/src/domain/exceptions/balance_exception.dart';

class BalanceLocalDatasourceImpl implements BalanceLocalDatasource {
  @override
  Future<double> getBalance() async {
    // Simulation : fetching data from local storage
    return Future.delayed(Duration(seconds: FetchDataDelay.local), () async {
      // Get balance from local mock
      try {
        return mockBalance;
      } catch (error) {
        throw (BalanceException());
      }
    });
  }
}
