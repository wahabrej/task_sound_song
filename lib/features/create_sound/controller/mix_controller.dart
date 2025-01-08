import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoundMixerController extends GetxController {
  var sounds = <RxMap<String, dynamic>>[
    {
      'name': 'Typhoon',
      'icon': Icons.storm,
      'value': 0.5.obs,
      'isPlaying': true.obs,
    }.obs,
    {
      'name': 'Sleet',
      'icon': Icons.ac_unit,
      'value': 0.3.obs,
      'isPlaying': true.obs,
    }.obs,
    {
      'name': 'Desert Wind',
      'icon': Icons.air,
      'value': 0.8.obs,
      'isPlaying': true.obs,
    }.obs,
    {
      'name': 'Starry Night',
      'icon': Icons.nightlight_round,
      'value': 0.7.obs,
      'isPlaying': true.obs,
    }.obs,
    {
      'name': 'Tribal Drums',
      'icon': Icons.music_note,
      'value': 0.6.obs,
      'isPlaying': true.obs,
    }.obs,
  ].obs;

  void togglePlayPause(int index) {
    sounds[index]['isPlaying']?.value = !(sounds[index]['isPlaying']?.value);
  }

  void updateSlider(int index, double value) {
    sounds[index]['value']?.value = value;
  }

  void pauseAll() {
    for (var sound in sounds) {
      sound['isPlaying']?.value = false;
    }
  }

  void clearAll() {
    sounds.clear();
  }
}
