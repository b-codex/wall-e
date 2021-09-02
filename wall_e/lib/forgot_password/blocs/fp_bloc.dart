import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/forgot_password/blocs/blocs.dart';
import 'package:wall_e/forgot_password/repository/fp_repository.dart';

class FP_Bloc extends Bloc<FP_Event, FP_State> {
  final FP_Repository fp_repository;
  FP_Bloc({required this.fp_repository}) : super(ResetIdle());
  @override
  Stream<FP_State> mapEventToState(FP_Event event) async* {
    if (event is AttemptReset) {
      yield ResetProgress();
      await Future.delayed(Duration(seconds: 2));
      final response = await fp_repository.ResetPassword(event.fp_model);
      if (response == "Failure") {
        yield ResetFailure(message: "Password Reset Failed.");
      }
      if (response == "Success") {
        yield ResetSuccess();
      }
    }
  }
}
