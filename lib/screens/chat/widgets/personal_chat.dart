import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/models/chats/chats.dart';
import 'package:nabh_messenger/models/chats/message.dart';
import 'package:nabh_messenger/models/user/user.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_button.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';
import 'package:nabh_messenger/widgets/w_text_field.dart';

class PersonalChat extends StatefulWidget {
  final User user;
  final Chat chat;
  final String docId;
  const PersonalChat({
    Key? key,
    required this.user,
    required this.chat,
    required this.docId,
  }) : super(key: key);

  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _controller.clear();
      }
    });
    super.initState();
    print(widget.chat);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Color(0XFF4A6572),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: mediaQuery.padding.top),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 72,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
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
                          const SizedBox(width: 20),
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(mediaQuery.padding.top + 95),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('personal_chats')
                .doc(
                  widget.docId,
                )
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return AcceptedMessageContainer(
                    message: Message.fromJson(
                        snapshot.data!.data()!['messages'][index]),
                  );
                },
                itemCount: snapshot.data!.data()!['messages'].length,
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
                        top: 20,
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
                          WTextField(
                            key: const Key('message_input'),
                            autoFocus: true,
                            hasHeight: true,
                            hintStyle: TextStyle(
                              color: Colors.grey[350],
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            controller: _controller,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 100,
                            hasBorder: false,
                            hintText: 'Xabar yozish...',
                          ),
                          const Divider(color: Colors.white),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(10),
                                  onTap: () {
                                    Navigator.pop(_);
                                  },
                                  child: const Text('Bekor qilish'),
                                  color: Colors.redAccent,
                                ),
                              ),
                              Expanded(
                                child: WButton(
                                  margin: const EdgeInsets.all(10),
                                  onTap: () async {
                                    FirebaseFirestore.instance
                                        .collection('personal_chats')
                                        .doc(widget.docId)
                                        .update({
                                      'messages': FieldValue.arrayUnion([
                                        Message(
                                                from: context
                                                    .read<ProfileBloc>()
                                                    .state
                                                    .user
                                                    .id,
                                                to: widget.user.id,
                                                id: 1,
                                                message: _controller.text,
                                                createdAt: DateTime.now()
                                                    .toIso8601String())
                                            .toJson(),
                                      ])
                                    });
                                    Navigator.pop(_);
                                  },
                                  child: const Text('Yuborish'),
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
            if (!_focusNode.hasFocus) {
              _focusNode.requestFocus();
            }
          },
          child: const Icon(Icons.messenger_outlined),
        ),
      ),
    );
  }
}

class AcceptedMessageContainer extends StatelessWidget {
  final Message message;

  const AcceptedMessageContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: context.read<ProfileBloc>().state.user.id == message.from
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(
          bottom: 5,
          left: 10,
          right: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
          borderRadius:
              context.read<ProfileBloc>().state.user.id == message.from
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
          color: context.read<ProfileBloc>().state.user.id == message.from
              ? Colors.grey.shade500
              : AppColors.appBar,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.message,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _returnFormattedDate(message.createdAt),
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _returnFormattedDate(String date) {
    final time = DateTime.parse(date);
    if (time.year == DateTime.now().year) {
      if (time.month == DateTime.now().month) {
        if (time.day == DateTime.now().day) {
          return Jiffy(date).format('h:mm a');
        } else {
          return Jiffy(date).format('h:mm a, dd MMMM');
        }
      } else {
        return Jiffy(date).format('h:mm a, dd/MM');
      }
    } else {
      return Jiffy(date).format('h:mm a, dd/MM/yyyy');
    }
  }
}
