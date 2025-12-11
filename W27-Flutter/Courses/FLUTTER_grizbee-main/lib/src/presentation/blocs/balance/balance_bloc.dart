import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/src/domain/abstraction/balance_repository.dart';
import 'package:grizbee/src/domain/exceptions/balance_exception.dart';
import 'package:grizbee/src/domain/exceptions/deposit_exception.dart';

part 'balance_event.dart';

part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final balanceRepository = GetIt.instance.get<BalanceRepository>();

  BalanceBloc() : super(BalanceInitial()) {
    // Gestion de GetBalanceEvent
    on<GetBalanceEvent>((event, emit) async {
      try {
        emit(BalanceLoading());
        final balance = await balanceRepository.getBalance();
        emit(BalanceLoaded(balance));
      } catch (error) {
        if (error is BalanceException) {
          emit(BalanceFailure(error.message));
        }
      }
    });

    // Gestion de DepositFundsEvent
    on<DepositFundsEvent>((event, emit) async {
      try {
        emit(FundsDepositProcessing());
        final amount = event.amount;
        final balance = await balanceRepository.updateBalance(amount);
        emit(FundsDepositProceeded(balance));
      } catch (error) {
        if (error is DepositException) {
          emit(FundsDepositFailure(error.message));
        }
      }
    });
  }
}
