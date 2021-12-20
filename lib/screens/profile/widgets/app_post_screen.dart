import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/models/chats/message.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_text_field.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (_) => const AddPostScreen());
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int index = 0;
  late CarouselController _carouselController;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  List<File?> images = [];
  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _textEditingController.clear();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
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
                      'Post Yaratish',
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
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.appBar,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      options: CarouselOptions(onPageChanged: (value, reason) {
                        setState(() {
                          index = value;
                        });
                      }),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                        margin: const EdgeInsets.all(5),
                        width: double.maxFinite,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSmoothIndicator(
                      activeIndex: index,
                      count: 3,
                      effect: const ExpandingDotsEffect(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mavzuning O`rni',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' iChat ilovasi orqali hozircha qo`yiladigan postlarning ko`rinishi shunday bo`ladi!\n Siz postni yozib boravering va biz uni takomillashtirib boramiz...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              useRootNavigator: true,
              isScrollControlled: true,
              isDismissible: false,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (_) {
                return Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(_).padding.top + 30,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: 10,
                        right: 10,
                        bottom: MediaQuery.of(_).viewInsets.bottom + 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.90),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: WButton(
                              width: 40,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              onTap: () {
                                Navigator.pop(_);
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              color: Colors.redAccent,
                            ),
                          ),
                          WTextField(
                            key: const Key('post_input'),
                            autoFocus: true,
                            hasHeight: true,
                            hintStyle: TextStyle(
                              color: Colors.grey[350],
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            controller: _textEditingController,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 100,
                            hasBorder: false,
                            hintText: 'Matn yozish...',
                          ),
                          const Divider(color: Colors.white),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WButton(
                                onTap: () {
                                  // Navigator.pop(_);
                                },
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(5),
                                width: 40,
                                child: const Icon(
                                  Icons.male,
                                  color: Colors.white,
                                ),
                                color: Colors.green,
                              ),
                              WButton(
                                onTap: () {
                                  // Navigator.pop(_);
                                },
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(5),
                                width: 40,
                                child: const Icon(
                                  Icons.female,
                                  color: Colors.white,
                                ),
                                color: Colors.green,
                              ),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(5),
                                  onTap: () {
                                    Navigator.pop(_);
                                  },
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(5),
                                  onTap: () {
                                    Navigator.pop(_);
                                  },
                                  child: const Icon(
                                    Icons.article,
                                    color: Colors.white,
                                  ),
                                  color: Colors.greenAccent,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(5),
                                  onTap: () {
                                    Navigator.pop(_);
                                  },
                                  child: const Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                  ),
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: AppColors.secondary,
          child: const Icon(
            Icons.create,
          ),
        ),
      ),
    );
  }
}
