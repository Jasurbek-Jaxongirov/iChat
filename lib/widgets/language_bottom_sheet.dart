import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nabh_messenger/models/language_item.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  final languagesList = [
    LanguageItem(
      id: 'uz',
      title: 'O`zbekcha',
      icon: 'assets/icons/flag_uzb.svg',
      hasSelected: false,
    ),
    LanguageItem(
      id: 'ru',
      title: 'Русский',
      icon: 'assets/icons/flag_russia.svg',
      hasSelected: false,
    ),
    LanguageItem(
      id: 'en',
      title: 'English',
      icon: 'assets/icons/flag_uk.svg',
      hasSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            width: 40,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ilova tilini o`zgartirish',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      for (final item in languagesList) {
                        if (item.id == languagesList[index].id) {
                          item.hasSelected = true;
                        } else {
                          item.hasSelected = false;
                        }

                        setState(() {});
                      }
                    },
                    child: LanguageItemRadioButton(
                      title: languagesList[index].title,
                      icon: languagesList[index].icon,
                      hasSelected: languagesList[index].hasSelected,
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 0);
                },
                itemCount: languagesList.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageItemRadioButton extends StatelessWidget {
  const LanguageItemRadioButton({
    required this.title,
    required this.icon,
    required this.hasSelected,
    Key? key,
  }) : super(key: key);
  final String title;
  final String icon;
  final bool hasSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: hasSelected ? Colors.grey.shade200 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
        boxShadow: hasSelected
            ? [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(1, 2),
                  blurRadius: 1,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (hasSelected)
            SvgPicture.asset('assets/icons/radio_selected.svg')
          else
            SvgPicture.asset('assets/icons/radio_unselected.svg')
        ],
      ),
    );
  }
}
