import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final String? iconPath;
  final String? description;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const GradientButton({
    Key? key,
    required this.label,
    this.iconPath,
    this.description,
    required this.index,
    required this.selectedIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: isSelected
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                width: 1.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.0),
              ),
            ),
            onPressed: () {
              onSelected(index);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.0,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (description != null)
                  Text(
                    description!,
                    style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal),
                  ),
                if (iconPath != null)
                  Image.asset(
                    iconPath!,
                    height: 24.0,
                    width: 24.0,
                    color: isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onSurface,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
