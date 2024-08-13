import 'dart:async';
import 'package:flutter/material.dart';

class Lyrics extends StatefulWidget {
  const Lyrics({
    super.key,
    required String lyrics,
  }) : _lyrics = lyrics;

  final String _lyrics;

  @override
  _LyricsState createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {
  late List<_WordDelay> _wordDelays;
  String _displayedText = '';
  int _currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    _wordDelays = _parseLyrics(widget._lyrics);
    _startDisplayingWords();
  }

  List<_WordDelay> _parseLyrics(String lyrics) {
    final regex = RegExp(r'{}');
    final matches = regex.allMatches(lyrics);

    return matches.map((match) {
      final word = match.group(1)!;
      final delay = int.parse(match.group(2)!);
      return _WordDelay(word: word, delay: delay);
    }).toList();
  }

  void _startDisplayingWords() {
    if (_currentWordIndex < _wordDelays.length) {
      final wordDelay = _wordDelays[_currentWordIndex];
      Timer(Duration(milliseconds: wordDelay.delay), () {
        setState(() {
          _displayedText += ' ${wordDelay.word}';
          _currentWordIndex++;
        });
        _startDisplayingWords();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _displayedText.trim(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

class _WordDelay {
  final String word;
  final int delay;

  _WordDelay({required this.word, required this.delay});
}
