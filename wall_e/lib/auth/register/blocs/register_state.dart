import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends RegisterState {}

class RegisterProgress extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;
  
  RegisterFailure({required this.message});
}

class RegisterIdle extends RegisterState {}
