import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/screens/auth/bloc/login/login_bloc.dart';
import 'package:nabh_messenger/screens/home/home.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.mailController,
    required this.passwordController,
    required this.mailFocusNode,
    required this.passwordFocusNode,
    Key? key,
  }) : super(key: key);
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final FocusNode mailFocusNode;
  final FocusNode passwordFocusNode;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isMailFocused = false;
  bool isPasswordFocused = false;
  bool isObscure = true;
  @override
  void initState() {
    super.initState();
    widget.mailFocusNode.addListener(() {
      if (widget.mailFocusNode.hasFocus) {
        setState(() {
          isMailFocused = true;
        });
      }
      if (!widget.mailFocusNode.hasFocus) {
        setState(() {
          isMailFocused = false;
        });
      }
    });
    widget.passwordFocusNode.addListener(() {
      if (widget.passwordFocusNode.hasFocus) {
        setState(() {
          isPasswordFocused = true;
        });
      }
      if (!widget.passwordFocusNode.hasFocus) {
        setState(() {
          isPasswordFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ilovamizga xush kelibsiz!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ilovaga kirish uchun ma`lumotlaringizni kiriting:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mail manzilingizni kiriting: ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: WTextField(
                controller: widget.mailController,
                hintText: 'a.baxtiyorov@gmail.com',
                fillColor: Colors.grey.shade100,
                focusNode: widget.mailFocusNode,
                isFilled: !widget.mailFocusNode.hasFocus,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Parolingizni kiritng: ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: WTextField(
                isFilled: !widget.passwordFocusNode.hasFocus,
                controller: widget.passwordController,
                hintText: '************',
                fillColor: Colors.grey.shade100,
                focusNode: widget.passwordFocusNode,
                isPassword: isObscure,
                suffix: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!isPasswordFocused) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Xatolik yuz berdi!'),
                            content: const Text(
                              'Parolni o`zgartirish funksiyasi hali ishga tushmagan. Noqulaylik uchun sizdan uzr so`raymiz!',
                            ),
                            actions: [
                              MaterialButton(
                                color: Colors.yellow,
                                onPressed: () {
                                  Navigator.pop(_);
                                },
                                child: const Text(
                                  'Yopish',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      isObscure = !isObscure;
                      setState(() {});
                    }
                  },
                  child: Container(
                    width: 120,
                    alignment: isPasswordFocused
                        ? Alignment.centerRight
                        : Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: isPasswordFocused
                        ? isObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)
                        : Text(
                            'Unutdingizmi?',
                            style: TextStyle(
                              color: Colors.blue.shade200,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            WButton(
              loading: state.status == SubmissionStatus.waiting,
              margin: const EdgeInsets.only(top: 15),
              onTap: () async {
                context.read<LoginBloc>().add(
                      UserSignInValidated(
                        email: widget.mailController.text.trim(),
                        password: widget.passwordController.text.trim(),
                        onSuccess: () {
                          context.read<LoginBloc>().add(
                                UserLoggedIn(
                                  email: widget.mailController.text.trim(),
                                  password:
                                      widget.passwordController.text.trim(),
                                  onSuccess: () {
                                    context.read<ProfileBloc>().add(
                                          UserDataTaken(
                                            onSuccess: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const HomeScreen(),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                            onFail: (message) {
                                              _showMaterialBanner(message);
                                            },
                                          ),
                                        );
                                  },
                                  onError: (message) {
                                    _showMaterialBanner(message);
                                  },
                                ),
                              );
                        },
                        onError: (message) {
                          _showMaterialBanner(message);
                        },
                      ),
                    );
              },
              color: Colors.orangeAccent,
              child: const Text(
                'Kirish',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMaterialBanner(String message) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.redAccent,
        onVisible: () {
          Timer(
            const Duration(seconds: 2),
            () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
          );
        },
        content: Text(
          message,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
