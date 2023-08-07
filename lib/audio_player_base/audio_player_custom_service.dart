import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:components_demo/audio_player_base/audio_player_base.dart';
import 'package:flutter/material.dart';

class LAudioPlayerService extends ChangeNotifier implements BaseAudioPlayerService {
  ///Fields
  String _currentPlayerId = '';
  AudioPlayer _audioPlayer = AudioPlayer(playerId: kUninitializedPlayer);

  final StreamController<Duration> _durationStreamController = StreamController<Duration>();
  final StreamController<Duration> _positionStreamController = StreamController<Duration>();
  final StreamController<PlayerState> _playerStateStreamController = StreamController<PlayerState>();

  /* final Stream<Duration> _durationStream = const Stream<Duration>.empty();
  final Stream<Duration> _positionStream = const Stream<Duration>.empty();
  final Stream<PlayerState> _playerStatestream = const Stream<PlayerState>.empty(); */

  ///Getters
  @override
  AudioPlayer get audioPlayer => _audioPlayer;

  @override
  Stream<Duration> get durationStream => _durationStreamController.stream;

  @override
  Stream<Duration> get positionStream => _positionStreamController.stream;

  @override
  Stream<PlayerState> get playerStateStream => _playerStateStreamController.stream;

  @override
  Future<bool> pauseAudio({required String playerId}) async {
    if (_currentPlayerId == playerId) {
      await _audioPlayer.pause();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> playAudio({required String playerId, required String url, Duration? position}) async {
    if (_currentPlayerId == playerId) {
      _audioPlayer.play(UrlSource(url), position: position);
      notifyListeners();
    } else {
      updateAudioPlayer(playerId: playerId);
      _audioPlayer.play(UrlSource(url), position: position);
      notifyListeners();
    }
  }

  @override
  AudioPlayer updateAudioPlayer({required String playerId}) {
    if (_audioPlayer.playerId == playerId) return _audioPlayer;
    _disposeOldPlayer();
    _initializeNewPlayer(playerId);
    notifyListeners();
    return _audioPlayer;
  }

  void _disposeOldPlayer() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
  }

  void _initializeNewPlayer(String playerId) {
    _audioPlayer = AudioPlayer(playerId: playerId);
    _currentPlayerId = _audioPlayer.playerId;

    _durationStreamController.add(Duration.zero);
    _positionStreamController.add(Duration.zero);
    _playerStateStreamController.add(PlayerState.stopped);

    _audioPlayer.onDurationChanged.listen((duration) {
      _durationStreamController.add(duration);
    });
    _audioPlayer.onPositionChanged.listen((pos) {
      _positionStreamController.add(pos);
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerStateStreamController.add(state);
    });
  }
}
