import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(true);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'Angkara.wav',
      'attack.wav',
      'collect.wav',
      'hit.wav',
      'jump.wav',
      'landing.wav',
      'ui_pause.wav',
      'ui_unpause.wav',
    ]);
  }

  static void playSfx(String file, double volume) {
    if (sfx.value) {
      FlameAudio.play(file, volume: volume);
    }
  }

  static void playBgm(String file, double volume) {
    if (bgm.value) {
      FlameAudio.bgm.play(file, volume: volume);
    }
  }

  static void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  static void resumeBgm() {
    if (bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  static void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
