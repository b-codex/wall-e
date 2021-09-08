import 'package:wall_e/auth/forgot_password/models/fp_model.dart';

abstract class FP_Event {}

class AttemptReset extends FP_Event {
  final FP_Model fp_model;
  AttemptReset({required this.fp_model});
}
