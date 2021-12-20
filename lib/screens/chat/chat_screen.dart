import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabh_messenger/app/colors.dart';
import 'package:nabh_messenger/models/chats/chats.dart';
import 'package:nabh_messenger/models/submission_status/submission_status.dart';
import 'package:nabh_messenger/models/user/user.dart';
import 'package:nabh_messenger/repositories/chat.dart';
import 'package:nabh_messenger/screens/chat/bloc/chat/chat_bloc.dart';
import 'package:nabh_messenger/screens/chat/widgets/personal_chat.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> _tabs = const [
    Tab(
      height: 20,
      icon: Icon(
        Icons.person,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.people,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.source_rounded,
      ),
    ),
    Tab(
      child: Icon(
        Icons.home,
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBloc(
            chatRepository: ChatRepository(),
          )..add(
              ChattedUsersFetched(
                onSuccess: () {},
                onError: () {},
              ),
            ),
        ),
      ],
      child: AnnotatedRegion(
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'NABH Messenger',
                              style: TextStyle(
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
                  TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    unselectedLabelColor: Colors.white,
                    labelColor: const Color(0XFFF9AA33),
                    indicatorColor: const Color(0XFFF9AA33),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(mediaQuery.padding.top + 95),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.submissionStatus == SubmissionStatus.succed) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          if (state.users[index].id ==
                              context.read<ProfileBloc>().state.user.id) {
                            return const SizedBox();
                          }
                          return UserItem(
                            name: state.users[index].name,
                            user: state.users[index],
                          );
                        },
                        itemCount: state.users.length,
                      );
                    } else if (state.submissionStatus ==
                            SubmissionStatus.pure ||
                        state.submissionStatus == SubmissionStatus.waiting) {
                      return const WProgressIndicator();
                    } else if (state.submissionStatus ==
                        SubmissionStatus.failed) {
                      return const Text(
                        'Foydalanuvchilarni yuklash muvaffaqiyatsiz yakunlandi!',
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    WProgressIndicator(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    WProgressIndicator(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    WProgressIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  final String name;
  final User user;
  const UserItem({
    required this.name,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        Chat chat;
        String docId;
        var response = await FirebaseFirestore.instance
            .collection('personal_chats')
            .doc(widget.user.id + context.read<ProfileBloc>().state.user.id)
            .get();
        print(response.data());
        var response2 = await FirebaseFirestore.instance
            .collection('personal_chats')
            .doc(context.read<ProfileBloc>().state.user.id + widget.user.id)
            .get();
        print(response2.data());
        if (response.data() != null) {
          docId = widget.user.id + context.read<ProfileBloc>().state.user.id;
          chat = Chat.fromJson(response.data()!);
        } else if (response2.data() != null) {
          docId = context.read<ProfileBloc>().state.user.id + widget.user.id;
          chat = Chat.fromJson(response2.data()!);
        } else {
          await FirebaseFirestore.instance
              .collection('personal_chats')
              .doc(widget.user.id + context.read<ProfileBloc>().state.user.id)
              .set(
                Chat(
                  id: widget.user.id +
                      context.read<ProfileBloc>().state.user.id,
                  from: widget.user.id,
                  to: context.read<ProfileBloc>().state.user.id,
                  createdAt: Timestamp.now().toString(),
                  messages: const [],
                ).toJson(),
              );

          var response3 = await FirebaseFirestore.instance
              .collection('personal_chats')
              .doc(widget.user.id + context.read<ProfileBloc>().state.user.id)
              .get();
          print(response3.data());
          chat = Chat.fromJson(response3.data()!);
          docId = widget.user.id + context.read<ProfileBloc>().state.user.id;
        }
        print('This is chat: $chat');
        print('This is doc id: $docId');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PersonalChat(
              user: widget.user,
              chat: chat,
              docId: docId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: widget.user.imageUrl.isEmpty
                  ? widget.user.isMale
                      ? Image.asset('assets/images/male avatar.png')
                      : Image.asset('assets/images/female avatar.png')
                  : Image.network(
                      widget.user.imageUrl,
                    ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '',
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
