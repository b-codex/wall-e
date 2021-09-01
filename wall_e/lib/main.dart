import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/forgot_password/blocs/blocs.dart';
import 'package:wall_e/forgot_password/data_provider/data_provider.dart';
import 'package:wall_e/forgot_password/repository/fp_repository.dart';
import 'package:wall_e/login/blocs/blocs.dart';
import 'package:wall_e/login/data_provider/data_provider.dart';
import 'package:wall_e/login/repository/login_repository.dart';
import 'package:wall_e/register/blocs/register_bloc.dart';
import 'package:wall_e/register/data_provider/data_provider.dart';
import 'package:wall_e/register/repository/register_repository.dart';
import 'package:wall_e/routes/routes.dart';

void main() => runApp(WallE());

// ignore: must_be_immutable
class WallE extends StatelessWidget {
  // This widget is the root of your application.

  LoginRepository loginRepository =
      LoginRepository(loginProvider: LoginProvider());

  RegisterRepository registerRepository =
      RegisterRepository(registerProvider: RegisterProvider());

  FP_Repository fp_repository = FP_Repository(fp_provider: FP_Provider());

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
