import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable{}

class RegisterSuccess extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterProgress extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure({required this.message});
  
  @override
  List<Object?> get props => [];
}

class RegisterIdle extends RegisterState{
  @override
  List<Object?> get props => [];
}