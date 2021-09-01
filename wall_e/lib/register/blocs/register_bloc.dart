import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/register/blocs/blocs.dart';
import 'package:wall_e/register/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  RegisterBloc({required this.registerRepository}) : super(RegisterIdle());
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is AttemptRegister) {
      yield RegisterProgress();
      await Future.delayed(Duration(seconds: 2));
      final response = await registerRepository.RegisterUser(event.user);
      if (response == "Failure") {
        yield RegisterFailure(
            message: 'Registration Failed. Please Try Again Later.');
      }
      if (response == "Success") {
        yield RegisterSuccess();
      }
    }
  }
}
