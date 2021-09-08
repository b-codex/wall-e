abstract class FP_State {}

class ResetProgress extends FP_State {}

class ResetSuccess extends FP_State {}

class ResetFailure extends FP_State {
  final String message;
  ResetFailure({required this.message});
}

class ResetIdle extends FP_State{}