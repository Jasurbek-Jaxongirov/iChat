import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/models/user/user.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';
import 'package:nabh_messenger/widgets/w_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);
  // static Route route() => MaterialPageRoute(
  //       builder: (_) => EditProfileScreen(user: ,),
  //     );
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  File? image;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username);
    _bioController = TextEditingController(text: widget.user.bio);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.appBar,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: mediaQuery.padding.top),
            child: Container(
              height: 74,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Profil ma`lumotlarini tahrirlash',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(mediaQuery.padding.top + 74),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        var file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            image = File.fromUri(
                              Uri(path: file.path),
                            );
                          });
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: image == null
                                  ? CachedNetworkImage(
                                      imageUrl: state.user.imageUrl,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return state.user.isMale
                                            ? Image.asset(
                                                'assets/images/male avatar.png')
                                            : Image.asset(
                                                'assets/images/female avatar.png');
                                      },
                                      progressIndicatorBuilder:
                                          (_, url, download) {
                                        if (download.progress != null) {
                                          return Center(
                                            child: CircularPercentIndicator(
                                              radius: 50,
                                              percent: download.progress!,
                                              animation: true,
                                              arcType: ArcType.FULL,
                                              fillColor: AppColors.background,
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              progressColor: Colors.green,
                                            ),
                                          );
                                        }
                                        return const WProgressIndicator();
                                      },
                                    )
                                  : Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 200,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: AppColors.appBar.withOpacity(0.7),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: FaIcon(
                                    FontAwesomeIcons.edit,
                                    color: AppColors.secondary,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'To`liq ism: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      WTextField(
                        controller: _nameController,
                        fillColor: Colors.grey.shade100,
                        isFilled: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Foydalanuvchi nomi: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      WTextField(
                        controller: _usernameController,
                        fillColor: Colors.grey.shade100,
                        isFilled: true,
                        keyboardType: TextInputType.name,
                        hintText: 'abulhaasuub',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'O`zingiz haqingizda qisqacha ma`lumot kiriting: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      WTextField(
                        controller: _bioController,
                        keyboardType: TextInputType.multiline,
                        hintText:
                            '21 y.o ~ Student at INHA University in Tashkent',
                        fillColor: Colors.grey.shade100,
                        minLines: 3,
                        maxLines: 8,
                        isFilled: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Telefon raqamingizni kiriting: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      WTextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: '+998 (99) 474-66-28',
                        fillColor: Colors.grey.shade100,
                        isFilled: true,
                      ),
                    ],
                  ),
                  WButton(
                    loading: state.submissionStatus == SubmissionStatus.waiting,
                    margin: const EdgeInsets.only(top: 40),
                    onTap: () async {
                      var link = '';
                      print(image == null);
                      if (image != null) {
                        final reference = FirebaseStorage.instance
                            .ref()
                            .child('user_avatars')
                            .child(state.user.id);
                        await reference
                            .putFile(
                              image!,
                            )
                            .whenComplete(() {});
                        link = await reference.getDownloadURL();
                      }

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(state.user.id)
                          .update(
                            User(
                              id: state.user.id,
                              imageUrl: link.isEmpty ? state.user.imageUrl : link,
                              isMale: state.user.isMale,
                              joinedAt: state.user.joinedAt,
                              mahrams: state.user.mahrams,
                              mail: state.user.mail,
                              posts: state.user.posts,
                              name: _nameController.text.trim().isEmpty
                                  ? state.user.name
                                  : _nameController.text.trim(),
                              username: _usernameController.text.trim(),
                              bio: _bioController.text.trim(),
                              phoneNumber: _phoneController.text.trim(),
                            ).toJson(),
                          );
                      context.read<ProfileBloc>().add(
                            UserDataTaken(
                              onFail: (message) {
                                _showMaterialBanner(message);
                              },
                              onSuccess: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                    },
                    color: Colors.orangeAccent,
                    child: const Text(
                      'Profil ma`lumotlarini tahrirlash',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
