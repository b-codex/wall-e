import 'package:wall_e/auth/forgot_password/data_provider/data_provider.dart';
import 'package:wall_e/auth/forgot_password/models/fp_model.dart';

class FP_Repository {
  final FP_Provider fp_provider;

  FP_Repository({required this.fp_provider});

  Future<String> ResetPassword(FP_Model fp_model) async {
    final result = await fp_provider.ResetPassword(fp_model);
    return result;
  }
}
