import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ird_task/features/create_sound/controller/music_controller.dart';

class SoundCardsScreen extends StatelessWidget {
  const SoundCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicController musicController = Get.put(MusicController());

    return Scaffold(
      backgroundColor: const Color(0xff09001F),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildSoundCard(
                    musicController: musicController,
                    index: 0,
                    title: "Meditation",
                    subtitle: "Rain • Thunder",
                    icons: [
                      Icons.water_drop,
                      Icons.air,
                      Icons.snowing,
                      Icons.add,
                      Icons.wb_sunny,
                    ],
                  ),
                  buildSoundCard(
                    musicController: musicController,
                    index: 1,
                    title: "Magic Moon",
                    subtitle: "Wind • Instrument",
                    icons: [
                      Icons.water_drop,
                      Icons.air,
                    ],
                  ),
                  buildSoundCard(
                    musicController: musicController,
                    index: 2,
                    title: "Sleep",
                    subtitle: "Rain • Wind ",
                    icons: [
                      Icons.water_drop,
                      Icons.air,
                      Icons.snowing,
                      Icons.add,
                      Icons.wb_sunny,
                      Icons.cloud,
                      Icons.wb_sunny,
                      Icons.wb_sunny,
                    ],
                  ),
                  buildSoundCard(
                    musicController: musicController,
                    index: 3,
                    title: "Happy Place",
                    subtitle: "Rain • Wind",
                    icons: [
                      Icons.cloud,
                      Icons.wb_sunny,
                      Icons.cloud,
                      Icons.wb_sunny,
                      Icons.cloud,
                    ],
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            bool isAnyPlaying =
                List.generate(4, (i) => musicController.isPlaying(i))
                    .contains(true);

            if (isAnyPlaying) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2A1D48),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff531DAB),
                              Color(0xff531DAB),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(
                          Icons.pause,
                          size: 15,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/soundMixerScreen');
                      },
                      icon: const Icon(Icons.tune, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        for (int i = 0; i < 4; i++) {
                          musicController.togglePlayPause(i);
                        }
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white24,
                              width: 1.0,
                            ),
                            color: Colors.grey,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.close,
                            size: 11, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget buildSoundCard({
    required MusicController musicController,
    required int index,
    required String title,
    required String subtitle,
    required List<IconData> icons,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1B1136),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(8, (i) {
                if (i < icons.length) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff2A1D48),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icons[i],
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                } else {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 59, 47, 87),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }
              }),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Obx(() => GestureDetector(
                      onTap: () => musicController.togglePlayPause(index),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff531DAB),
                              Color(0xff531DAB),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          musicController.isPlaying(index)
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 15,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: SoundCardsScreen()));
}
