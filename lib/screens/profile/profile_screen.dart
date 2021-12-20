import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/screens/home/home.dart';
import 'package:nabh_messenger/screens/profile/widgets/app_post_screen.dart';
import 'package:nabh_messenger/screens/profile/widgets/edit_profile_screen.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'bloc/profile/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _key = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
        key: _key,
        backgroundColor: const Color(0XFF232F34),
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
              height: 72,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      (_key.currentState as ScaffoldState).openEndDrawer();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Profile',
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
          preferredSize: Size.fromHeight(mediaQuery.padding.top + 72),
        ),
        endDrawer: WDrawer(mediaQuery: mediaQuery),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.submissionStatus == SubmissionStatus.pure ||
                state.submissionStatus == SubmissionStatus.waiting) {
              return const Center(
                child: WProgressIndicator(),
              );
            } else if (state.submissionStatus == SubmissionStatus.succed) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state.user.imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return state.user.isMale
                                    ? Image.asset(
                                        'assets/images/male avatar.png')
                                    : Image.asset(
                                        'assets/images/female avatar.png');
                              },
                              progressIndicatorBuilder: (_, url, download) {
                                if (download.progress != null) {
                                  return Center(
                                    child: CircularPercentIndicator(
                                      radius: 50,
                                      percent: download.progress!,
                                    ),
                                  );
                                }
                                return const WProgressIndicator();
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                    state.user.bio,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                                WButton(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EditProfileScreen(user: state.user),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Profil ma`lumotlarini tahrirlash',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(2),
                                  color: AppColors.secondary,
                                  onTap: () {},
                                  child: const Text('Mahramlar'),
                                ),
                              ),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(2),
                                  color: AppColors.secondary,
                                  onTap: () {
                                    HomeTabControllerProvider.of(context)
                                        .controller
                                        .animateTo(2);
                                  },
                                  child: const Text('Chat'),
                                ),
                              ),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(2),
                                  color: AppColors.secondary,
                                  onTap: () {},
                                  child: const Text('Saqlanganlar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: [
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (_, index) {
                              return Center(
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    index.toString(),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.user.posts.length,
                          ),
                          ListView.builder(
                            itemBuilder: (_, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: double.maxFinite,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      index.toString(),
                                    ),
                                  ),
                                  const Text('Lorem ipsum dolor sit amet!'),
                                ],
                              );
                            },
                            itemCount: state.user.posts.length,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state.submissionStatus == SubmissionStatus.failed) {
              return Column(
                children: const [
                  Center(
                    child: Center(
                      child: Text('Failed'),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          onPressed: () async {
            Navigator.of(context).push(
              AddPostScreen.route(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class WDrawer extends StatelessWidget {
  const WDrawer({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            decoration: const BoxDecoration(
              color: AppColors.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Ilovadan chiqish',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
