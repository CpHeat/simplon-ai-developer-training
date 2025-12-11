part of 'scanner_bloc.dart';

@immutable
abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String scanResult;

  ScannerSuccess(this.scanResult);
}

class ScannerAbort extends ScannerState {}

class ScannerFailure extends ScannerState {}