import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iti_moqaf/core/logic/tts/translate.dart';

import '../../../featuers/map/data/models/route_response.dart';

class VoiceNavigationCubit extends Cubit<void> {
  VoiceNavigationCubit() : super(null) {
    _initTts();
  }

  final FlutterTts tts = FlutterTts();
  bool _isStopped = false;

  Future<void> _initTts() async {
    await tts.setEngine("com.google.android.tts");
    await tts.setLanguage("ar-EG");
    await tts.setSpeechRate(0.45);
    await tts.setPitch(1.0);
    await tts.setQueueMode(1); // Android

    await tts.awaitSpeakCompletion(true);
  }

  Future<void> speakDirections(List<Step> steps) async {
    _isStopped = false;
    await tts.stop();

    if (_isStopped) return;
    await tts.speak("بداية الرحلة");

    for (int i = 0; i < steps.length; i++) {
      if (_isStopped) return;

      final step = steps[i];
      final text =
          '${translateInstruction(step.instruction)} لمسافة ${step.distance.round()} متر';

      await tts.speak(text);

      if (i != 0) {
        await Future.delayed(
          Duration(seconds: (step.duration / 2).round()),
        );
      }
    }

    if (!_isStopped) {
      await tts.speak("وصلت إلى وجهتك");
    }
  }

  Future<void> stopVoice() async {
    _isStopped = true;
    await tts.stop();
  }

  @override
  Future<void> close() async {
    _isStopped = true;
    await tts.stop();
    return super.close();
  }
}
