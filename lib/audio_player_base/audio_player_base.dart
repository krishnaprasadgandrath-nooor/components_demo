import 'package:audioplayers/audioplayers.dart';

const String kUninitializedPlayer = 'uninitializedPlayer';

abstract class BaseAudioPlayerService {
  ///Fields
  AudioPlayer get audioPlayer;
  Stream<Duration> get positionStream;
  Stream<Duration> get durationStream;
  Stream<PlayerState> get playerStateStream;

  ///Methods
  AudioPlayer updateAudioPlayer({required String playerId});
  Future<void> playAudio({required String playerId, required String url, Duration? position});
  Future<bool> pauseAudio({required String playerId});
}
