import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';

import 'package:nabh_messenger/models/user/user.dart' as user;
import 'package:nabh_messenger/screens/auth/bloc/login/login_bloc.dart';
import 'package:nabh_messenger/screens/home/home.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
    required this.newUserNameController,
    required this.newUserMailController,
    required this.newUserUsernameController,
    required this.newUserBioController,
    required this.newUserPhoneController,
    required this.newUserPasswordController,
    required this.newUserNameFocusNode,
    required this.newUserMailFocusNode,
    required this.newUserBioFocusNode,
    required this.newUserPhoneFocusNode,
    required this.newUserPasswordFocusNode,
    required this.newUserUsernameFocusNode,
  }) : super(key: key);
  final TextEditingController newUserNameController;
  final TextEditingController newUserMailController;
  final TextEditingController newUserBioController;
  final TextEditingController newUserPhoneController;
  final TextEditingController newUserPasswordController;
  final TextEditingController newUserUsernameController;
  final FocusNode newUserNameFocusNode;
  final FocusNode newUserMailFocusNode;
  final FocusNode newUserUsernameFocusNode;
  final FocusNode newUserBioFocusNode;
  final FocusNode newUserPhoneFocusNode;
  final FocusNode newUserPasswordFocusNode;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isMailFocused = false;
  bool isPasswordFocused = false;
  bool isObscure = true;
  bool? isMale;
  @override
  void initState() {
    super.initState();
    widget.newUserNameController.addListener(
      () {
        if (widget.newUserNameFocusNode.hasFocus) {}
        if (!widget.newUserNameFocusNode.hasFocus) {}
      },
    );
    widget.newUserPasswordFocusNode.addListener(
      () {
        if (widget.newUserPasswordFocusNode.hasFocus) {
          setState(() {
            isPasswordFocused = true;
          });
        }
        if (!widget.newUserPasswordFocusNode.hasFocus) {
          setState(() {
            isPasswordFocused = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'iChat ilovasidan ro`yxatdan o`ting!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ilovadan ro`yxatdan o`tish uchun ma`lumotlarni kiriting:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'To`liq ismingizni kiriting: ',
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
              controller: widget.newUserNameController,
              keyboardType: TextInputType.name,
              hintText: 'Jaxongirov Jasurbek',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserNameFocusNode,
              isFilled: !widget.newUserNameFocusNode.hasFocus,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Foydalanuvchi nomini kiriting: ',
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
              controller: widget.newUserUsernameController,
              keyboardType: TextInputType.name,
              hintText: 'abulhaasuub',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserUsernameFocusNode,
              isFilled: !widget.newUserUsernameFocusNode.hasFocus,
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
              controller: widget.newUserMailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'abulhaasuub@gmail.com',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserMailFocusNode,
              isFilled: !widget.newUserMailFocusNode.hasFocus,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'O`zingiz haqingizda qisqacha ma`lumot kiriting: ',
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
              controller: widget.newUserBioController,
              keyboardType: TextInputType.multiline,
              hintText: '21 y.o ~ Student at INHA University in Tashkent',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserBioFocusNode,
              isFilled: !widget.newUserBioFocusNode.hasFocus,
              minLines: 3,
              maxLines: 8,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Telefon raqamingizni kiriting: ',
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
              controller: widget.newUserPhoneController,
              keyboardType: TextInputType.phone,
              hintText: '+998 (99) 474-66-28',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserPhoneFocusNode,
              isFilled: !widget.newUserPhoneFocusNode.hasFocus,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Jinsingizni kiriting: ',
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
            child: DropdownButton<bool>(
              onTap: () {},
              onChanged: (value) {
                setState(() {
                  isMale = value;
                });
              },
              hint: Text(isMale == null
                  ? 'Jinsni tanlash...'
                  : isMale!
                      ? 'Erkak'
                      : 'Ayol'),
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Row(
                    children: const [
                      Icon(Icons.male),
                      SizedBox(width: 15),
                      Text('Erkak'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Row(
                    children: const [
                      Icon(Icons.female),
                      SizedBox(width: 15),
                      Text('Ayol'),
                    ],
                  ),
                ),
              ],
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
              isFilled: !widget.newUserPasswordFocusNode.hasFocus,
              controller: widget.newUserPasswordController,
              hintText: '************',
              fillColor: Colors.grey.shade100,
              focusNode: widget.newUserPasswordFocusNode,
              isPassword: isObscure,
              keyboardType: TextInputType.visiblePassword,
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
                  child: isObscure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(
                          Icons.visibility,
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
                    UserSignUpValidated(
                      name: widget.newUserNameController.text.trim(),
                      username: widget.newUserNameController.text.trim(),
                      email: widget.newUserMailController.text.trim(),
                      bio: widget.newUserBioController.text.trim(),
                      phoneNumber: widget.newUserPhoneController.text.trim(),
                      isMale: isMale,
                      password: widget.newUserPasswordController.text.trim(),
                      onSuccess: () {
                        context.read<LoginBloc>().add(
                              UserSignedUp(
                                email: widget.newUserMailController.text.trim(),
                                password: widget.newUserPasswordController.text
                                    .trim(),
                                onSuccess: (id) {
                                  context.read<ProfileBloc>().add(
                                        UserCreated(
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
                                          onError: (message) {
                                            _showMaterialBanner(message);
                                          },
                                          email: widget
                                              .newUserMailController.text
                                              .trim(),
                                          password: widget
                                              .newUserPasswordController.text
                                              .trim(),
                                          user: user.User(
                                            id: id,
                                            name: widget
                                                .newUserNameController.text
                                                .trim(),
                                            username: widget
                                                .newUserUsernameController.text
                                                .trim(),
                                            bio: widget
                                                .newUserBioController.text
                                                .trim(),
                                            isMale: isMale ?? true,
                                            mahrams: const [],
                                            phoneNumber: widget
                                                .newUserPhoneController.text
                                                .trim(),
                                            mail: widget
                                                .newUserMailController.text
                                                .trim(),
                                            imageUrl: '',
                                            posts: const [],
                                            joinedAt:
                                                Timestamp.now().toString(),
                                          ),
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
              'Ro`yxatdan o`tish',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
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
