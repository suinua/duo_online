import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:duo_online/phrase.dart';
import 'package:duo_online/script.dart';
import 'package:duo_online/section.dart';

class DuoAudio {
  Section _section;
  int _playingIndex = 0;
  final AssetsAudioPlayer _player;

  DuoAudio(this._section) :  _player = AssetsAudioPlayer.newPlayer() {
    var number = _section.getPhrase(_playingIndex).phraseNumber;
    _player.open(
      Audio('assets/sounds/$number'),
      autoStart: false,
      showNotification: true,
    );
  }

  void play() {
    stop();

    var phrase = _section.getPhrase(_playingIndex);
    _player.open(
      Audio('assets/sounds/${phrase.phraseNumber}'),
      autoStart: true,
      showNotification: true,
    );
  }

  void stop() {
    _player.stop();
  }

  void skipNext() {
    if (_section.isExist(_playingIndex+1)) {
       _playingIndex++;
       play();

    } else if (_section.isLastSection()) {
      _playingIndex = 0;
      _section = Script().getSection(1);
      stop();

    } else {
      _playingIndex = 0;
      _section = Script().getSection(_section.sectionNumber + 1);
      play();
    }
  }

  void skipPrevious() {

  }
}
