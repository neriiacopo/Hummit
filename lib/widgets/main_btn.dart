import 'dart:ui'; // Import the dart:ui library for ImageFilter
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final Function() onPressed;
  final int state; // Add a new parameter for the state

  const MainButton({
    Key? key,
    required this.onPressed,
    required this.state,
  }) : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize the animation with a Tween and attach it to the controller
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = 72.0;
    final double padding = 48.0;

    // Shadow and glow effect container based on state
    Widget shadowContainer;
    switch (widget.state) {
      case 0:
        // State 0: Light border and small shadow
        shadowContainer = Container(
          width: iconSize + padding * 2,
          height: iconSize + padding * 2,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(1000.0),
            border: Border.all(color: Colors.grey.shade700, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        );
        break;

      case 1:
        // State 1: Light border and animated glow effect
        shadowContainer = AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: iconSize + padding * 2,
              height: iconSize + padding * 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(1000.0),
                border: Border.all(color: Colors.grey.shade700, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(_animation.value),
                    blurRadius: _animation.value * 20 + 5,
                    spreadRadius: _animation.value * 10 + 2,
                  ),
                ],
              ),
            );
          },
        );
        break;

      case 2:
        // State 2: No shadow, no glow, no border
        shadowContainer = SizedBox.shrink();
        break;

      case 3:
        // State 3: Glow effect around the image contour
        shadowContainer = AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: _animation.value * 50 + 5,
                sigmaY: _animation.value * 50 + 5,
              ),
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(_animation.value),
                      blurRadius: 5,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;

      case 4:
        // State 4: Whole button is half the size
        shadowContainer = Container(
          width: (iconSize + padding * 2) / 2,
          height: (iconSize + padding * 2) / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(1000.0),
            border: Border.all(color: Colors.grey.shade700, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        );
        break;

      default:
        shadowContainer = SizedBox.shrink();
        break;
    }

    // Main icon button
    Widget iconButton = Container(
      child: IconButton(
        padding: EdgeInsets.all(widget.state == 4 ? padding / 2 : padding),
        icon: Image.asset(
          'assets/gemini.png',
          width: widget.state == 4 ? iconSize / 2 : iconSize,
          height: widget.state == 4 ? iconSize / 2 : iconSize,
        ),
        enableFeedback: widget.state < 2 || widget.state == 4 ? true : false,
        onPressed:
            widget.state < 2 || widget.state == 4 ? widget.onPressed : null,
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        shadowContainer,
        iconButton,
      ],
    );
  }
}
