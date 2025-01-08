import 'package:get/get.dart';
import 'package:ird_task/features/create_sound/presentation/screen/create_sound_screen.dart';
import 'package:ird_task/features/create_sound/presentation/screen/mix_screen.dart';
import 'package:ird_task/features/create_sound/presentation/screen/sound_mix_screen.dart';

class AppRoute {
  static String createSoundScreen = "/createSoundScreen";
  static String soundMixerScreen = "/soundMixerScreen";
  static String soundMixScreen = "/soundMixScreen";

  static String getCreateSoundScreen() => createSoundScreen;
  static String getSoundMixerScreen() => soundMixerScreen;
  static String getsoundMixScreen() => soundMixScreen;

  static List<GetPage> routes = [
    GetPage(name: createSoundScreen, page: () => const CreateSoundScreen()),
    GetPage(name: soundMixerScreen, page: () => const SoundMixerScreen()),
    GetPage(name: soundMixScreen, page: () => const SoundMixScreen()),
  ];
}
