import 'dart:async';

import 'package:duo_online/phrase.dart';
import 'package:duo_online/script.dart';
import 'package:duo_online/section.dart';
import 'package:just_audio/just_audio.dart';

class DuoAudio {
  Section _section;
  StreamController<Phrase> currentPhraseStream;
  final AudioPlayer _player;

  static DuoAudio? _instance;

  DuoAudio._internal()
      : _player = AudioPlayer(),
        _section = Script().getSection(1),
        currentPhraseStream = StreamController<Phrase>() {
    seekSectionTo(1);
    _player.currentIndexStream.listen((event) {
      if (event == null) return;
      currentPhraseStream.add(_section.getPhrase(event));
    });
  }

  factory DuoAudio() {
    _instance ??= DuoAudio._internal();
    return _instance!;
  }

  void onClick() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void skipNext() {
    if (_section.isExist(_player.currentIndex! + 1)) {
      _player.seekToNext();
    } else if (_section.isLastSection()) {
      seekSectionTo(1);
    } else {
      seekSectionTo(_section.sectionNumber + 1);
    }
  }

  void skipPrevious() {
    if (_section.isExist(_player.currentIndex! - 1)) {
      _player.seekToPrevious();
    } else if (_section.isFirstSection()) {
      _player.seekToPrevious(); //再生時間を0に戻す
    } else {
      seekSectionTo(_section.sectionNumber - 1);
    }
  }

  void seekSectionTo(int number) {
    _player.pause();
    _section = Script().getSection(number);
    var children = _section
        .getAllPhrase()
        .map((e) =>
            AudioSource.uri(Uri.parse('asset:///sounds/${e.phraseNumber}.mp3')))
        .toList();

    _player.setAudioSource(
      ConcatenatingAudioSource(
          useLazyPreparation: false, shuffleOrder: null, children: children),
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
  }
}
