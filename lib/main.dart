import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'styles/theme.dart';

import "widgets/card.dart";
import "widgets/main_btn.dart";
import "widgets/lyrics.dart";
import "utils.dart";
import "recorder.dart";

void main() {
  runApp(HummitApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
}

class HummitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hummit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final GenerativeModel _model;
  final Recorder _recorder = Recorder();
  final _apiKey = "";
  var _lyrics = [];
  String _audioPath = "";

  final Map<String, String> _config = {
    "genre": "",
    "theme": "",
    "subject": "",
  };

  // Method to update the config map
  void updateConfig(String key, String value) {
    setState(() {
      _config[key] = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _recorder.initializeRecordingPath();

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  int _cardKey = 1;
  int _mainBtnState = 0;
  int _cardState = 0;

  Future<void> _startRecording() async {
    if (!_recorder.isRecording && _mainBtnState == 0) {
      await _recorder.startRecording();
      setState(() {
        // _lyrics = _recorder.error.isNotEmpty ? _recorder.error : _lyrics;
        _mainBtnState = 1;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_recorder.isRecording && _mainBtnState == 1) {
      final path = await _recorder.stopRecording();
      setState(() {
        // _lyrics = _recorder.error.isNotEmpty ? _recorder.error : _lyrics;
        _audioPath = path ?? "";
        _mainBtnState = 2;
        _cardState = 1;
      });
    }
  }

  Future<void> _getLyrics() async {
    setState(() {
      _mainBtnState = 3;
      _cardState = 0;
    });
    if (_audioPath != "") {
      // Construct the description with non-empty config elements
      StringBuffer instructions = StringBuffer(
          'Generate lyrics based on the following hummed melody audio file. Please try to capture the rhythm and emotion of the melody as best as possible. For each word in the lyrics, append the approximate time (in milliseconds) at which that word should be sung. For example, "word1{100} word2{345}". IMPORTANT: Separate each verse with | symbol. Do not include any other information.');

      // IMPORTANT: Separate the different parts lyrics with the | symbol and provide [v] or [c] respectively for verses and choruses at the beginning of each part.

      // Append non-empty config parts
      if (_config["genre"]!.isNotEmpty) {
        instructions.write(' Generate lyrics in a ${_config["genre"]} style.');
      }
      if (_config["theme"]!.isNotEmpty) {
        instructions.write(' With a theme of ${_config["theme"]}.');
      }
      if (_config["subject"]!.isNotEmpty) {
        instructions.write(' Write about ${_config["subject"]}.');
      }
      final verses = await sendAudioToAPI(_audioPath, instructions, _model);
      setState(() {
        _lyrics = verses;
        _mainBtnState = 4;
      });
    }
  }

  void _handleButtonPress() {
    if (!_recorder.isRecording && _mainBtnState != 1) {
      _startRecording();
    } else {
      _stopRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = 750;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            brightenColor(Theme.of(context).colorScheme.surface)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              if (_lyrics.isNotEmpty) Lyrics(lyrics: _lyrics[0]),
              MainCard(
                  key: ValueKey(_cardKey),
                  expanded: _cardState == 1,
                  animationDuration: t,
                  onConfigChanged: updateConfig,
                  onEnding: _getLyrics),
              _mainBtnState > 1
                  ? SizedBox(height: 0.0)
                  : SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.0,
                          ),
                          Text(
                              _mainBtnState == 0
                                  ? "Tap Gemini"
                                  : "Listening...",
                              style: TextStyle(
                                  // fontSize: 12,
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          Text(_mainBtnState == 0 ? "and hum your melody" : " ",
                              style: TextStyle(
                                  // fontSize: 12,
                                  color:
                                      Theme.of(context).colorScheme.onSurface))
                        ],
                      ),
                    ),
              Flexible(
                child: Center(
                  child: MainButton(
                      state: _mainBtnState, onPressed: _handleButtonPress),
                ),
              ),
              SizedBox(
                child: Text("Humm'it",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              SizedBox(height: 6),
              SizedBox(
                child: Text("Powered by Google Gemini",
                    style: TextStyle(fontSize: 8, color: Colors.grey[400])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
