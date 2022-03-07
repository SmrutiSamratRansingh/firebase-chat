import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  IconContent({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon),
          Container(
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
