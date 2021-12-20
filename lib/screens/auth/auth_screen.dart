import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabh_messenger/screens/auth/bloc/login/login_bloc.dart';
import 'package:nabh_messenger/screens/auth/widgets/login_page.dart';
import 'package:nabh_messenger/screens/auth/widgets/signup_page.dart';
import 'package:nabh_messenger/widgets/language_bottom_sheet.dart';
import 'package:nabh_messenger/widgets/w_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static Route route() => MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Login variables
  late TextEditingController _mailController;
  late TextEditingController _passwordController;
  late FocusNode _mailFocusNode;
  late FocusNode _passwordFocusNode;
  // Signup variables
  late TextEditingController _newUserNameController;
  late TextEditingController _newUserUsernameController;
  late TextEditingController _newUserMailController;
  late TextEditingController _newUserBioController;
  late TextEditingController _newUserPhoneController;
  late TextEditingController _newUserPasswordController;
  late FocusNode _newUserNameFocusNode;
  late FocusNode _newUserUsernameFocusNode;
  late FocusNode _newUserMailFocusNode;
  late FocusNode _newUserBioFocusNode;
  late FocusNode _newUserPhoneFocusNode;
  late FocusNode _newUserPasswordFocusNode;
  late Widget loginPage;
  late Widget signupPage;
  late LoginBloc _loginBloc;
  bool _isLogin = true;
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    _newUserNameController = TextEditingController();
    _newUserUsernameController = TextEditingController();
    _newUserMailController = TextEditingController();
    _newUserBioController = TextEditingController();
    _newUserPhoneController = TextEditingController();
    _newUserPasswordController = TextEditingController();
    _newUserNameFocusNode = FocusNode();
    _newUserUsernameFocusNode = FocusNode();
    _newUserMailFocusNode = FocusNode();
    _newUserBioFocusNode = FocusNode();
    _newUserPhoneFocusNode = FocusNode();
    _newUserPasswordFocusNode = FocusNode();
    _mailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    loginPage = LoginPage(
      mailController: _mailController,
      passwordController: _passwordController,
      mailFocusNode: _mailFocusNode,
      passwordFocusNode: _passwordFocusNode,
    );
    signupPage = SignUpPage(
      newUserNameController: _newUserNameController,
      newUserUsernameController: _newUserUsernameController,
      newUserMailController: _newUserMailController,
      newUserBioController: _newUserBioController,
      newUserPhoneController: _newUserPhoneController,
      newUserPasswordController: _newUserPasswordController,
      newUserNameFocusNode: _newUserNameFocusNode,
      newUserUsernameFocusNode: _newUserUsernameFocusNode,
      newUserBioFocusNode: _newUserBioFocusNode,
      newUserPhoneFocusNode: _newUserPhoneFocusNode,
      newUserMailFocusNode: _newUserMailFocusNode,
      newUserPasswordFocusNode: _newUserPasswordFocusNode,
    );
    _widget = loginPage;
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passwordController.dispose();
    _newUserNameController.dispose();
    _newUserUsernameController.dispose();
    _newUserMailController.dispose();
    _newUserBioController.dispose();
    _newUserPhoneController.dispose();
    _newUserPasswordController.dispose();
    _newUserNameFocusNode.dispose();
    _newUserUsernameFocusNode.dispose();
    _newUserMailFocusNode.dispose();
    _newUserBioFocusNode.dispose();
    _newUserPhoneFocusNode.dispose();
    _newUserPasswordFocusNode.dispose();
    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _loginBloc,
        ),
      ],
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(top: mediaQuery.padding.top),
              child: Container(
                height: 72,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'iChat Ilovasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      // color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: false,
                          backgroundColor: Colors.transparent,
                          context: context,
                          useRootNavigator: true,
                          builder: (_) {
                            return const LanguageBottomSheet();
                          },
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.language),
                          SizedBox(width: 5),
                          Text('O`zbek tili'),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(mediaQuery.padding.top + 72),
          ),
          body: Container(
            height: mediaQuery.size.height -
                (mediaQuery.padding.top + mediaQuery.padding.bottom + 72),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _widget,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _isLogin
                                ? 'Ilovada yangimisiz?'
                                : 'Allaqachon ro`yxatdan o`tganmisiz?',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        WButton(
                          margin: const EdgeInsets.only(top: 10),
                          onTap: () {
                            setState(() {
                              if (_isLogin) {
                                _widget = signupPage;
                              } else {
                                _widget = loginPage;
                              }

                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? 'Ro`yxatdan o`tish' : 'Ilovaga kirish',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.orangeAccent.shade100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
