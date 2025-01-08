import 'package:get/get.dart';

class SoundController extends GetxController {
  var soundData = <Map<String, dynamic>>[].obs;
  var filteredSoundData = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var selectedCategory = "All".obs; // Observable for selected category

  var selectedSound = Rxn<Map<String, dynamic>>();
  var playingSounds = <int>[].obs;
  var selectedSoundIndex = Rxn<int>();
  var isIconOne = false.obs;

  @override
  void onInit() {
    super.onInit();
    soundData.value = [
      {"icon": "cloud", "name": "Typhoon", "locked": false},
      {"icon": "rainy", "name": "Sleet", "locked": false},
      {"icon": "sunny", "name": "Heavenly Drift", "locked": false},
      {"icon": "snowflake", "name": "Snowy Winter", "locked": false},
      {"icon": "cloud", "name": "Cloudiness", "locked": true},
      {"icon": "windy", "name": "Desert Wind", "locked": true},
      {"icon": "nightlight", "name": "Starry Nights", "locked": true},
      {"icon": "thunderstorm", "name": "Storm Surge", "locked": false},
      {"icon": "foggy", "name": "Misty Dawn", "locked": false},
      {"icon": "forest", "name": "Jungle Echo", "locked": false},
      {"icon": "fire", "name": "Crackling Fire", "locked": true},
      {"icon": "waterfall", "name": "Cascading Falls", "locked": false},
      {"icon": "foggy", "name": "Misty Dawn", "locked": false},
      {"icon": "forest", "name": "Jungle Echo", "locked": false},
      {"icon": "fire", "name": "Crackling Fire", "locked": true},
      {"icon": "waterfall", "name": "Cascading Falls", "locked": false},
    ];
    filteredSoundData.value = List.from(soundData);
  }

  void toggleIcon() {
    isIconOne.value = !isIconOne.value;
  }

  void filterSoundData() {
    String query = searchQuery.value.toLowerCase();
    filteredSoundData.value = searchQuery.value.isEmpty
        ? List.from(soundData)
        : soundData
            .where((sound) =>
                sound['name']?.toLowerCase().contains(query) ?? false)
            .toList();
  }

  void selectSound(Map<String, dynamic> sound) {
    if (sound['locked'] == true) {
      Get.snackbar("Locked Sound", "This sound is locked.");
      return;
    }
    int soundIndex = soundData.indexOf(sound);
    if (!playingSounds.contains(soundIndex)) {
      playingSounds.add(soundIndex);
    }
    selectedSound.value = sound;
    selectedSoundIndex.value = soundIndex;
  }

  void togglePlayPause(int soundIndex) {
    if (playingSounds.contains(soundIndex)) {
      playingSounds.remove(soundIndex);
    } else {
      playingSounds.add(soundIndex);
    }
  }

  bool isPlaying(int soundIndex) {
    return playingSounds.contains(soundIndex);
  }

  void unlockSound(String soundName) {
    var sound = soundData.firstWhereOrNull((s) => s['name'] == soundName);
    if (sound != null) {
      sound['locked'] = false;
      soundData.refresh();
    }
  }

  void stopAllSounds() {
    playingSounds.clear();
  }
}
