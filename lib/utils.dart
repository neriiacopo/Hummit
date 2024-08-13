import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:developer' as developer;

// Send audio to API
Future<List> sendAudioToAPI(
  filePath,
  instructions,
  model,
) async {
  try {
    final bytes = await File(filePath).readAsBytes();
    developer.log('Sending Instructions: ${instructions.toString()}');

    final messageContent = [
      Content.data("audio/m4a", bytes),
      Content.text(instructions.toString()),
    ];

    // Send the message to the chat session
    final response = await model.generateContent(messageContent);

    // Extract the generated lyrics from the response
    final text = response.text;
    developer.log('Receiving text: ${text.toString()}');

    final lyrics = [];
    if (text != null) {
      // var verse = {};
      var verses = text.split("|");
      // for (var i = 0; i < verses.length; i++) {
      //   var v = verses[i].trim().toString();

      //   int idx = verses[i].indexOf("]");
      //   var type = v.substring(0, idx + 1);
      //   var t = v.substring(2);
      //   verse["type"] = v[1] == "c" ? "verse" : "chorus";
      //   verse["text"] = t;

      //   lyrics.add(verse);
      // }

      // developer.log('Verses: ${verses.toString()}');
      // developer.log('Lyrics: ${lyrics.toString()}');
      // return verses.isNotEmpty ? verses : "No lyrics generated.";
      return [verses.toString()];
    } else {
      return [];
    }
  } catch (e) {
    developer.log('Error sending audio to API: $e', name: 'API');
    return [];
  }
}

// Modify the brightness of a color
Color brightenColor(Color color, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1);
  final hslColor = HSLColor.fromColor(color);
  final hslBrighter =
      hslColor.withLightness((hslColor.lightness + amount).clamp(0.0, 1.0));
  return hslBrighter.toColor();
}

// Check the height of a widget to trigger or remove scroll interaction
class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({required this.onChange, required this.child, Key? key})
      : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size size = context.size ?? Size.zero;
      if (size != _oldSize) {
        _oldSize = size;
        widget.onChange(size);
      }
    });

    return widget.child;
  }

  Size _oldSize = Size.zero;
}
