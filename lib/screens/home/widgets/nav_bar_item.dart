import 'package:flutter/material.dart';
import 'package:nabh_messenger/models/navbar/nav_bar.dart';

class TabItemWidget extends StatelessWidget {
  final bool isActive;
  final NavBar item;

  const TabItemWidget({
    Key? key,
    this.isActive = false,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: isActive ? const Color(0XFFF9AA33) : Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: isActive ? const Color(0XFFF9AA33) : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
}
