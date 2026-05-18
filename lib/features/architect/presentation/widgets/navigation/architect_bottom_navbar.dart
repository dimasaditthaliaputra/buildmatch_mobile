import 'package:flutter/material.dart';

class ArchitectBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const ArchitectBottomNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Icon(
            Icons.home,
            color: currentIndex == 0
                ? Colors.orange
                : Colors.grey,
          ),

          Icon(
            Icons.description,
            color: currentIndex == 1
                ? Colors.orange
                : Colors.grey,
          ),

          Icon(
            Icons.mail,
            color: currentIndex == 2
                ? Colors.orange
                : Colors.grey,
          ),

          Icon(
            Icons.person,
            color: currentIndex == 3
                ? Colors.orange
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}