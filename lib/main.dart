import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabh_messenger/bloc/connectivity/connectivity_bloc.dart';
import 'package:nabh_messenger/data/singletons/storage.dart';
import 'package:nabh_messenger/repositories/auth.dart';
import 'package:nabh_messenger/repositories/user.dart';
import 'package:nabh_messenger/screens/auth/auth_screen.dart';
import 'package:nabh_messenger/screens/auth/bloc/auth/auth_bloc.dart';
import 'package:nabh_messenger/screens/home/home.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uz'),
        Locale('ar'),
        Locale('en'),
        Locale('ru'),
      ],
      path: 'resources/lang',
      fallbackLocale: const Locale('uz'),
      assetLoader: const CodegenLoader(),
      child: App(
        authenticationRepository: AuthenticationRepository(),
        userRepository: UserRepository(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 0),
    ).then((value) {});
  }

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: (context) => widget.authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authenticationRepository: widget.authenticationRepository,
              userRepository: widget.userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => ConnectivityBloc()
              ..add(
                CheckConnection(),
              ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              userRepository: widget.userRepository,
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'iChat',
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              bodyText2: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          navigatorKey: _navigatorKey,
          // builder: (context, child) {
          //   return BlocListener<AuthBloc, AuthState>(
          //     listener: (context, state) async {
          //       switch (state.status) {
          //         case AuthenticationStatus.authenticated:
          //           context.read<ProfileBloc>().add(
          //                 UserDataTaken(
          //                   onSuccess: () {},
          //                   onFail: () {},
          //                 ),
          //               );
          //           _navigator.pushAndRemoveUntil<void>(
          //             HomeScreen.route(),
          //             (route) => false,
          //           );
          //           break;
          //         case AuthenticationStatus.unauthenticated:
          //           if (StorageRepository.getString('token', defValue: '') ==
          //               '') {
          //             if (StorageRepository.getBool(
          //               'wizard',
          //               defValue: false,
          //             )) {
          //               _navigator.pushAndRemoveUntil<void>(
          //                 AuthScreen.route(),
          //                 (route) => false,
          //               );
          //             } else {
          //               _navigator.pushAndRemoveUntil<void>(
          //                 SplashScreen.route(),
          //                 (route) => false,
          //               );
          //             }
          //           } else {
          //             context.read<AuthBloc>().add(
          //               AuthenticationGetStatus(
          //                 () {
          //                   _navigator.pushAndRemoveUntil<void>(
          //                     AuthScreen.route(),
          //                     (route) => false,
          //                   );
          //                 },
          //               ),
          //             );
          //           }
          //           break;
          //         default:
          //           _navigator.pushAndRemoveUntil<void>(
          //             SplashScreen.route(),
          //             (route) => false,
          //           );
          //           break;
          //       }
          //     },
          //     child: child,
          //   );
          // },
          // onGenerateRoute: (_) => SplashScreen.route(),
          home: StreamBuilder<User?>(
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                if (StorageRepository.getBool(
                  'wizard',
                  defValue: true,
                )) {
                  return const AuthScreen();
                } else {
                  return const SplashScreen();
                }
              }
            },
            stream: FirebaseAuth.instance.authStateChanges(),
          ),
        ),
      ),
    );
  }
}
