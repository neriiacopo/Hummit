import 'package:flutter/material.dart';
import "gradient_btn.dart";

class Carousel extends StatefulWidget {
  final VoidCallback onCarouselComplete;
  final Function(String, String) onConfigChanged;

  Carousel({
    required this.onCarouselComplete,
    required this.onConfigChanged,
  });

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int? _selectedGenreIndex;
  int? _selectedThemeIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    // Check if the last page is reached
    if (page == 3) {
      widget.onCarouselComplete(); // Trigger the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar with title and slide number
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getTitleForPage(_currentPage),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                _currentPage != 4 ? '${_currentPage + 1}/3' : '',
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        // Carousel slides
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildGenreSlide(),
              _buildTopicsSlide(),
              _buildSubjectSlide(),
              _buildLastSlide(),
            ],
          ),
        ),
        // Bottom bar with slide instruction
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_currentPage != 4 ? 'Swipe right to skip' : '',
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600])),
        ),
      ],
    );
  }

  Widget _buildGenreSlide() {
    final List<Map<String, String>> genres = [
      {'icon': "assets/icons/pop.png", 'label': 'Pop'},
      {'icon': "assets/icons/rock.png", 'label': 'Rock'},
      {'icon': "assets/icons/hiphop.png", 'label': 'Hip-Hop'},
      {'icon': "assets/icons/folk.png", 'label': 'Folk'},
      {'icon': "assets/icons/rb.png", 'label': 'R&B'},
      {'icon': "assets/icons/electronic.png", 'label': 'Electronic'},
    ];

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: genres.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> genre = entry.value;

            return GradientButton(
              label: genre['label']!,
              iconPath: genre['icon']!,
              index: index,
              selectedIndex: _selectedGenreIndex ?? -1,
              onSelected: (selIndex) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
                widget.onConfigChanged(
                    "genre", genres[selIndex]["label"] ?? "");
                setState(() {
                  _selectedGenreIndex = selIndex;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildTopicsSlide() {
    final List<Map<String, String>> themes = [
      {'description': "passionate", 'label': 'Love'},
      {'description': "tranquil", 'label': 'Nature'},
      {'description': "powerful", 'label': 'Social Justice'},
      {'description': "exciting", 'label': 'Adventure'},
      {'description': "introspective", 'label': 'Spirituality'},
      {'description': "heartbreaking", 'label': 'Loss'},
      {'description': "uplifting", 'label': 'Hope'},
      {'description': "exuberant", 'label': 'Joy'},
      {'description': "clever", 'label': 'Humor'},
      {'description': "unsettling", 'label': 'Darkness'},
    ];
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scrollbar(
          thumbVisibility: true,
          thickness: 4.0,
          radius: Radius.circular(10.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0,
                  0.0), // remove this space in case of no scrollbar
              child: Column(
                children: themes.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> genre = entry.value;

                  return GradientButton(
                    label: genre['label']!,
                    description: genre['description']!,
                    index: index,
                    selectedIndex: _selectedThemeIndex ?? -1,
                    onSelected: (selIndex) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                      widget.onConfigChanged(
                          "theme", themes[selIndex]["label"] ?? "");
                      setState(() {
                        _selectedThemeIndex = selIndex;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildSubjectSlide() {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: TextField(
  //           textAlignVertical: TextAlignVertical.top,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder().copyWith(
  //                 borderRadius: BorderRadius.circular(24.0),
  //                 borderSide: BorderSide(
  //                     color: Colors.white.withOpacity(0.1), width: 1.0)),
  //             labelText: 'Write about ..',
  //             labelStyle: TextStyle(color: Colors.grey[600]),
  //           ),
  //           maxLines: 50,
  //           onChanged: (value) => widget.onConfigChanged("subject", value),
  //           onSubmitted: (v) => _pageController.nextPage(
  //                 duration: Duration(milliseconds: 600),
  //                 curve: Curves.easeInOut,
  //               )),
  //     ),
  //   );
  // }

  Widget _buildSubjectSlide() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          maxLines: 50,
          textAlignVertical:
              TextAlignVertical.top, // Align placeholder text to the top
          decoration: InputDecoration(
            hintText: 'Write about ..', // Use hintText instead of labelText
            hintStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1.0, // Border width when not focused
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0, // Border width when focused
              ),
            ),
          ),
          onChanged: (value) => widget.onConfigChanged("subject", value),

          onSubmitted: (value) {
            FocusScope.of(context).unfocus(); // Hide the keyboard
            _pageController.nextPage(
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
          textInputAction: TextInputAction
              .done, // Set action button on the keyboard to 'Done'
        ),
      ),
    );
  }

  Widget _buildLastSlide() {
    return Center(child: null);
  }

  String _getTitleForPage(int page) {
    switch (page) {
      case 0:
        return 'Genre';
      case 1:
        return 'Topic';
      case 2:
        return 'Story';
      default:
        return '';
    }
  }
}
