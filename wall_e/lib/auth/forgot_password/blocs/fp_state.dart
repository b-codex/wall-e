import 'package:equatable/equatable.dart';

abstract class FP_State extends Equatable {}

class ResetProgress extends FP_State {
  @override
  List<Object?> get props => [];
}

class ResetSuccess extends FP_State {
  @override
  List<Object?> get props => [];
}

class ResetFailure extends FP_State {
  final String message;
  ResetFailure({required this.message});

  @override
  List<Object?> get props => [];
}

class ResetIdle extends FP_State {
  final String state = 'ResetIdle()';
  @override
  List<Object?> get props => [state];
}
