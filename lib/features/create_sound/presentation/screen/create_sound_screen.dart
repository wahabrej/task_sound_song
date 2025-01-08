import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ird_task/core/common/widgets/get_size_box.dart';
import 'package:ird_task/core/utils/constants/image_path.dart';
import 'package:ird_task/features/create_sound/controller/music_create_controller.dart';
import 'package:ird_task/features/create_sound/presentation/screen/sound_cards_screen.dart';

class CreateSoundScreen extends StatelessWidget {
  const CreateSoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SoundController controller = Get.put(SoundController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff09001F),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImagePath.background1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSizeBox(
                      height: 1,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.97,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 27,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent.withOpacity(0.3),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.lock,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 8),
                                    Text(
                                      "Upgrade",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Obx(() {
                                  return AnimatedOpacity(
                                    opacity:
                                        controller.isIconOne.value ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: TextField(
                                      onChanged: (query) {
                                        controller.searchQuery.value = query;
                                        controller.filterSoundData();
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Colors.transparent.withOpacity(0.3),
                                        hintText: 'Search...',
                                        prefixIcon: const Icon(Icons.search,
                                            color: Colors.white),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        // Search Icon Button
                        Positioned(
                          top: 10,
                          right: 13,
                          child: Obx(() {
                            return Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: controller.isIconOne.value
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  controller.isIconOne.value
                                      ? Icons.close
                                      : Icons.search,
                                  size: 16,
                                ),
                                color: controller.isIconOne.value
                                    ? Colors.grey
                                    : Colors.white,
                                onPressed: () {
                                  controller.toggleIcon();
                                },
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.3),
                        ),
                        child: const SizedBox(
                          height: 33,
                          child: TabBar(
                            tabs: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70),
                                child: Tab(text: "Sounds"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70),
                                child: Tab(text: "Saved"),
                              ),
                            ],
                            indicator: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff42098F),
                                Color(0xffB53FFE)
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            "All",
                            "Rain",
                            "Water",
                            "Wind",
                            "Instrument"
                          ]
                              .map((category) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 10),
                                    child: Obx(() => GestureDetector(
                                          onTap: () {
                                            controller.selectedCategory.value =
                                                category;
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            decoration: BoxDecoration(
                                              gradient: controller
                                                          .selectedCategory
                                                          .value ==
                                                      category
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Color(0xff42098F),
                                                        Color(0xffB53FFE)
                                                      ],
                                                    )
                                                  : const LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.transparent
                                                      ],
                                                    ),
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  color: controller
                                                              .selectedCategory
                                                              .value ==
                                                          category
                                                      ? Colors.white
                                                      : Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Obx(() {
                            return Wrap(
                              spacing: 28,
                              runSpacing: 16,
                              children:
                                  controller.filteredSoundData.map((item) {
                                int index = controller.soundData.indexOf(item);
                                bool isSelected =
                                    controller.selectedSoundIndex.value ==
                                        index;

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectSound(item);
                                  },
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              gradient: isSelected
                                                  ? const LinearGradient(
                                                      colors: [
                                                          Color(0xff42098F),
                                                          Color(0xffB53FFE)
                                                        ])
                                                  : const LinearGradient(
                                                      colors: [
                                                          Colors.transparent,
                                                          Colors.transparent
                                                        ]),
                                              border: Border.all(
                                                color: Colors.white24,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(
                                              _getIconData(item['icon']),
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.white24,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            item['name'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      if (item['locked'])
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white24,
                                              ),
                                              color: const Color(0xff161B36),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                              size: 9,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ),
                      Obx(() {
                        return controller.playingSounds.isNotEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff2A1D48),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                        Get.toNamed('/soundMixScreen');
                                      },
                                      icon: const Icon(Icons.tune,
                                          color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed('/soundMixScreen');
                                      },
                                      icon: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          Positioned(
                                              top: 10,
                                              left: 12,
                                              child: Container(
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.white24,
                                                        width: 1.0,
                                                      ),
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 8,
                                                  )))
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.stopAllSounds();
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
                              )
                            : const SizedBox.shrink();
                      }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                  // Saved Tab
                  const Center(child: SoundCardsScreen()),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: "Library"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle), label: "Create"),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarm"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Awards"),
          ],
          backgroundColor: const Color(0xff09001F),
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "cloud":
        return Icons.cloud;
      case "rainy":
        return Icons.beach_access;
      case "sunny":
        return Icons.wb_sunny;
      case "snowflake":
        return Icons.ac_unit;
      default:
        return Icons.radio_button_checked;
    }
  }
}
