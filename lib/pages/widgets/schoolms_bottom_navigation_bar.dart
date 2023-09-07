import 'package:flutter/material.dart';
import 'package:schoolms/utils/schoolms_colors.dart';

class SchoolMsBottomNavigationBar extends StatefulWidget {
  const SchoolMsBottomNavigationBar({super.key, required this.onChanged});

  final void Function(int index) onChanged;

  @override
  State<SchoolMsBottomNavigationBar> createState() =>
      _SchoolMsBottomNavigationBarState();
}

class _SchoolMsBottomNavigationBarState
    extends State<SchoolMsBottomNavigationBar> {
  int currentIndex = 0;

  final List<Icon> navigationIcons = [
    const Icon(Icons.home),
    const Icon(Icons.notifications),
    const Icon(Icons.history),
    const Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: SchoolMsColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            widget.onChanged(index);
          });
        },
        backgroundColor: SchoolMsColors.primary,
        items: List.generate(
          navigationIcons.length,
          (index) {
            return BottomNavigationBarItem(
              label: "",
              icon: Column(
                children: [
                  navigationIcons[index],
                  currentIndex == index
                      ? Container(
                          width: 14,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
