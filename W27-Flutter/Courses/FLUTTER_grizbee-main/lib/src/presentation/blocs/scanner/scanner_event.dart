part of 'scanner_bloc.dart';

@immutable
abstract class ScannerEvent {}

class ScannerSuccessEvent extends ScannerEvent {
  final String scannerResult;

  ScannerSuccessEvent(this.scannerResult);
}

class ScannerAbortEvent extends ScannerEvent {}

class ScannerFailureEvent extends ScannerEvent {}
