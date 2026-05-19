import 'package:flutter/material.dart';

class CircleIconWidget extends StatelessWidget {
  final IconData icon;  
  final Color backgroundColor;
  final double size;
  final Color iconColor;

  const CircleIconWidget({
    super.key, 
    required this.icon, 
    this.backgroundColor = Colors.blue, 
    this.size = 48,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.6),
    );
  }
}