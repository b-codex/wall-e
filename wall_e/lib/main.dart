import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/forgot_password/blocs/blocs.dart';
import 'package:wall_e/auth/forgot_password/data_provider/data_provider.dart';
import 'package:wall_e/auth/forgot_password/repository/fp_repository.dart';
import 'package:wall_e/main_features/blocs/blocs.dart';
import 'package:wall_e/main_features/blocs/favorite_bloc.dart';
import 'package:wall_e/main_features/data_provider/data_provider.dart';
import 'package:wall_e/main_features/data_provider/favorite_data_provider.dart';
import 'package:wall_e/main_features/repository/favorite_repository.dart';
import 'package:wall_e/main_features/repository/home_page_repository.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/data_provider/data_provider.dart';
import 'package:wall_e/auth/login/repository/login_repository.dart';
import 'package:wall_e/auth/register/blocs/register_bloc.dart';
import 'package:wall_e/auth/register/data_provider/data_provider.dart';
import 'package:wall_e/auth/register/repository/register_repository.dart';
import 'package:wall_e/profile/blocs/blocs.dart';
import 'package:wall_e/profile/data_provider/data_provider.dart';
import 'package:wall_e/profile/repository/profile_repository.dart';
import 'package:wall_e/routes/routes.dart';

void main() => runApp(WallE());

// ignore: must_be_immutable
class WallE extends StatelessWidget {
  // This widget is the root of your application.

  LoginRepository loginRepository = LoginRepository(
    loginProvider: LoginProvider(),
  );

  RegisterRepository registerRepository = RegisterRepository(
    registerProvider: RegisterProvider(),
  );

  FP_Repository fp_repository = FP_Repository(
    fp_provider: FP_Provider(),
  );

  HomePageRepository homePageRepository = HomePageRepository(
    homePageProvider: HomePageProvider(),
  );

  FavoriteRepository favoriteRepository = FavoriteRepository(
    favoriteDataProvider: FavoriteDataProvider(),
  );

  ProfileRepository profileRepository = ProfileRepository(
    profileDataProvider: ProfileDataProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => LoginBloc(loginRepository: loginRepository),
        ),
        BlocProvider(
          create: (ctx) => RegisterBloc(registerRepository: registerRepository),
        ),
        BlocProvider(
          create: (ctx) => FP_Bloc(fp_repository: fp_repository),
        ),
        BlocProvider(
          create: (ctx) => HomePageBloc(homePageRepository: homePageRepository),
        ),
        BlocProvider(
          create: (ctx) => FavoriteBloc(favoriteRepository: favoriteRepository),
        ),
        BlocProvider(
          create: (ctx) => ProfileBloc(profileRepository: profileRepository),
        ),
      ],
      child: RepositoryProvider.value(
        value: loginRepository,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Comfortaa",
            brightness: Brightness.dark,
          ),
          initialRoute: RouteManager.loginPage,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
