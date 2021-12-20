import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nabh_messenger/models/navbar/nav_bar.dart';
import 'package:nabh_messenger/models/navbar/nav_item_enum.dart';
import 'package:nabh_messenger/screens/home/navigator.dart';
import 'package:nabh_messenger/screens/home/widgets/nav_bar_item.dart';
import 'package:nabh_messenger/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const HomeScreen(),
      );

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late double navBarWidth;
  final List<double> wavePosition = [0.0, 0.2, 0.4, 0.6, 0.8];

  late AnimationController controller;
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.main: GlobalKey<NavigatorState>(),
    NavItemEnum.iGram: GlobalKey<NavigatorState>(),
    NavItemEnum.chat: GlobalKey<NavigatorState>(),
    NavItemEnum.study: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  List<NavBar> labels = [
    const NavBar(
      id: 0,
      title: 'iTube',
      icon: Icons.video_library,
    ),
    const NavBar(
      id: 1,
      title: 'iGram',
      icon: Icons.podcasts,
    ),
    const NavBar(
      id: 2,
      title: 'Chat',
      icon: Icons.send,
    ),
    const NavBar(
      id: 3,
      title: 'Study',
      icon: Icons.cast_for_education_rounded,
    ),
    const NavBar(
      id: 4,
      title: 'Profile',
      icon: Icons.person,
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    controller.addListener(() {});
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(onTabChange);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    //TODO: Remove this code
    context.read<ProfileBloc>().add(
          UserDataTaken(
            onSuccess: () {},
            onFail: (message) {},
          ),
        );
    super.initState();
  }

  void onTabChange() {
    setState(() => _currentIndex = _controller.index);
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) => HomeTabControllerProvider(
        controller: _controller,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                    .currentState!
                    .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (NavItemEnum.values[_currentIndex] != NavItemEnum.main) {
                changePage(0);
                return false;
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color(0XFF232F34),
            bottomNavigationBar: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0XFF4A6572),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(6, 14, 34, 0.08),
                    blurRadius: 30,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    enableFeedback: true,
                    onTap: (int index) {},
                    indicator: const BoxDecoration(),
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      TabItemWidget(
                        isActive: _currentIndex == 0,
                        item: labels[0],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 1,
                        item: labels[1],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 2,
                        item: labels[2],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 3,
                        item: labels[3],
                      ),
                      TabItemWidget(
                        isActive: _currentIndex == 4,
                        item: labels[4],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPageNavigator(NavItemEnum.main),
                _buildPageNavigator(NavItemEnum.iGram),
                _buildPageNavigator(NavItemEnum.chat),
                _buildPageNavigator(NavItemEnum.study),
                _buildPageNavigator(NavItemEnum.profile),
              ],
            ),
          ),
        ),
      );
}

class HomeTabControllerProvider extends InheritedWidget {
  const HomeTabControllerProvider({
    required Widget child,
    required this.controller,
    Key? key,
  }) : super(key: key, child: child);

  final TabController controller;

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;

  static HomeTabControllerProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>()!;
}
