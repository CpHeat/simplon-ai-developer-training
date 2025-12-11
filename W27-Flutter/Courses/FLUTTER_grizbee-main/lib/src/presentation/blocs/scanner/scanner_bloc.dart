import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    // Gestion de ScannerSuccessEvent
    on<ScannerSuccessEvent>((event, emit) {
      emit(ScannerSuccess(event.scannerResult));
    });

    // Gestion de ScannerFailureEvent
    on<ScannerFailureEvent>((event, emit) {
      emit(ScannerFailure());
    });

    // Gestion de ScannerAbortEvent
    on<ScannerAbortEvent>((event, emit) {
      emit(ScannerAbort());
    });
  }
}
