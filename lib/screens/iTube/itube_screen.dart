import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nabh_messenger/models/user/user.dart' as user;
import 'package:nabh_messenger/widgets/language_bottom_sheet.dart';
import 'package:nabh_messenger/widgets/w_progress_indicator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0XFF232F34),
        appBar: PreferredSize(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0XFF4A6572),
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
                children: const [
                  Text(
                    'iTube',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(mediaQuery.padding.top + 72),
        ),
        // body: StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder: (streamContext, streamSnapshot) {
        //     if (streamSnapshot.connectionState == ConnectionState.active) {
        //       var data = streamSnapshot.data!.docs;
        //       return ListView.builder(
        //         shrinkWrap: true,
        //         itemBuilder: (ctx, index) {
        //           print(data[index].runtimeType);
        //           return Text(
        //               '${user.User.fromJson(data[index].data() as Map<String, dynamic>)}');
        //         },
        //         itemCount: data.length,
        //       );
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: SvgPicture.asset(
                'assets/icons/undraw_not_found_-60-pq.svg',
              ),
            ),
            const Text(
              'iTube xususiyatlari hali ishga tushmagan!',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
