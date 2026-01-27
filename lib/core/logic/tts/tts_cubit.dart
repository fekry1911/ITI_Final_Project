import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iti_moqaf/core/logic/tts/translate.dart';

import '../../../featuers/map/data/models/route_response.dart';

class VoiceNavigationCubit extends Cubit<void> {
  VoiceNavigationCubit() : super(null) {
    _initTts();
  }

  final FlutterTts tts = FlutterTts();

  Future<void> _initTts() async {
    await tts.setEngine("com.google.android.tts");

    await tts.setLanguage("ar-EG");

    await tts.setSpeechRate(0.45);
    await tts.setPitch(1.0);

    await tts.setQueueMode(1); // Android
  }

  Future<void> speakDirections(List<Step> steps) async {
    await tts.stop();

    await tts.speak("بدايه الرحلة");

    for (var entry in steps.asMap().entries) {
      int index = entry.key;
      var step = entry.value;
      final text =
          '${translateInstruction(step.instruction)} لمسافة ${step.distance.round()} متر';

      print(text);
      await tts.awaitSpeakCompletion(true); // يجعل speak ينتظر فعليًا

      await tts.speak(text);
      print(step.duration);
      if (index !=0) {
        await Future.delayed(Duration(seconds: (step.duration / 2).round()));
      }
    }
    await tts.speak("وصلت إلى وجهتك");
  }

  @override
  Future<void> close() {
    tts.stop();
    return super.close();
  }
}
