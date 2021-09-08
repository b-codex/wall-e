import 'package:wall_e/profile/data_provider/data_provider.dart';

class ProfileRepository {
  final ProfileDataProvider profileDataProvider;

  ProfileRepository({required this.profileDataProvider});

  Future<Object> getPersonalInfo(String username) async {
    var result = await profileDataProvider.getPersonalInfo(username)
        as Map<dynamic, dynamic>;
    if (result['status'] == 'Success') {
      return {
        'fullname': result['fullname'],
        'username': result['username'],
        'password': result['password'],
      };
    } else {
      return {'status': 'Failure'};
    }
  }

  Future<String> savePersonalInfo(
      String fullname, String username, String password) async {
    var result = await profileDataProvider.savePersonalInfo(
      fullname,
      username,
      password,
    );

    return result;
  }

  Future<String> changePassword(
      String username, String password, String secret_key) async {
    var result = await profileDataProvider.changePassword(
        username, password, secret_key);

    return result;
  }

  Future<String> deleteAccount(String username) async {
    var result = await profileDataProvider.deleteAccount(username);

    return result;
  }
}
