// lib/widgets/animated_section.dart
import 'package:flutter/material.dart';
import '../styles/app_styles.dart'; // Import styles
import '../styles/theme.dart'; // Import the theme

class MainCard extends StatelessWidget {
  final bool expanded;
  final int animationDuration;

  const MainCard({
    Key? key,
    required this.expanded,
    this.animationDuration = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: animationDuration),
      curve: Curves.easeIn,
      opacity: expanded ? 1.0 : 0.0,
      child: TweenAnimationBuilder<double>(
        duration: Duration(
            milliseconds:
                animationDuration * 2), // Control timing for elevation
        tween: Tween<double>(begin: 0.0, end: expanded ? 50.0 : 0.0),
        builder: (context, elevation, child) {
          return Material(
            elevation: elevation,
            shadowColor: Colors.red,
            color: AppTheme.darkTheme.colorScheme.surface,
            borderRadius: AppStyles.defaultBorderRadius,
            child: AnimatedContainer(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeInOut,
              height: expanded ? MediaQuery.of(context).size.height * 0.6 : 0.0,
              decoration: AppStyles.glassDecor,
              child: Container(
                child: const Center(
                  child: Text(
                    'Content of d1',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
