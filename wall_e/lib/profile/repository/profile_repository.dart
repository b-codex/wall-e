import 'package:wall_e/profile/data_provider/data_provider.dart';
import 'package:wall_e/profile/models/profile_models.dart';

class ProfileRepository {
  final ProfileDataProvider profileDataProvider;

  ProfileRepository({required this.profileDataProvider});

  Future<Object> getPersonalInfo(String username) async {
    var result = await profileDataProvider.getPersonalInfo(username)
        as Map<dynamic, dynamic>;
    if (result['status'] == 'Success') {
      return {
        'status' : result['status'],
        'fullname': result['fullname'],
        'username': result['username'],
        'password': result['password'],
      };
    } else {
      return {'status': 'Failure'};
    }
  }

  Future<String> savePersonalInfo(
      SavePersonalInfoModel savePersonalInfoModel) async {
    var result =
        await profileDataProvider.savePersonalInfo(savePersonalInfoModel);

    return result;
  }

  Future<String> changePassword(ChangePasswordModel changePasswordModel) async {
    var result = await profileDataProvider.changePassword(changePasswordModel);

    return result;
  }

  Future<String> deleteAccount(String username) async {
    var result = await profileDataProvider.deleteAccount(username);

    return result;
  }
}
