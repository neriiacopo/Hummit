// lib/widgets/animated_section.dart
import 'package:flutter/material.dart';
import '../styles/app_styles.dart'; // Import styles
// import '../styles/theme.dart'; // Import the theme
import 'carousel.dart'; // Import the carousel

class MainCard extends StatefulWidget {
  final bool expanded;
  final int animationDuration;
  final Function(String, String) onConfigChanged;

  final VoidCallback onEnding;
  // final ValueChanged<int> onEndinging;

  const MainCard(
      {Key? key,
      required this.expanded,
      this.animationDuration = 300,
      required this.onConfigChanged,
      required this.onEnding})
      : super(key: key);

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  bool _isCarouselComplete = false;
  bool _triggerOpacity = false;

  @override
  void didUpdateWidget(MainCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        Future.delayed(Duration(milliseconds: widget.animationDuration * 2),
            () {
          setState(() {
            _triggerOpacity = true;
          });
        });
      } else {
        setState(() {
          _triggerOpacity = false;
        });
      }
    }
  }

  // Ending Carousel
  void _onCarouselComplete() {
    setState(() {
      _isCarouselComplete = true;
      widget.onEnding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.animationDuration * 2),
      curve: Curves.easeInOut,
      height: widget.expanded ? MediaQuery.of(context).size.height * 0.6 : 0.0,
      decoration: AppStyles.glassDecor,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: widget.animationDuration),
        curve: Curves.easeIn,
        opacity: _triggerOpacity ? 1.0 : 0.0,
        child: TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: widget.animationDuration),
          tween: Tween<double>(begin: 0.0, end: _triggerOpacity ? 50.0 : 0.0),
          builder: (context, elevation, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: AppStyles.defaultBorderRadius,
              ),
              child: Material(
                elevation: 0,
                borderRadius: AppStyles.defaultBorderRadius,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Carousel(
                    onCarouselComplete: _onCarouselComplete,
                    onConfigChanged: widget.onConfigChanged,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
