import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ird_task/features/create_sound/controller/mix_controller.dart';
import 'package:ird_task/features/create_sound/presentation/widget/custom_progress.dart';

class SoundMixerScreen extends StatelessWidget {
  const SoundMixerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SoundMixerController controller = Get.put(SoundMixerController());

    return Scaffold(
      backgroundColor: const Color(0xFF0D031E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Meditation ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "Mix",
                    style: TextStyle(
                      color: Color(0xff531DAB),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.sounds.length,
                  itemBuilder: (context, index) {
                    var sound = controller.sounds[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomProgressBar(
                              name: sound['name'],
                              icon: sound['icon'],
                              value: sound['value'].value,
                              onChanged: (value) =>
                                  controller.updateSlider(index, value),
                            ),
                          ),
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1.0,
                                ),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: () =>
                                  controller.sounds.removeAt(index),
                              icon: const Icon(Icons.close,
                                  size: 13, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white24,
                            width: 1.0,
                          ),
                          color: Colors.grey,
                          shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          _showRenameDialog(context, controller);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ),
                    const Text(
                      "Rename",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: controller.pauseAll,
                      icon: const Icon(Icons.pause, color: Colors.white),
                    ),
                    const Text(
                      "Pause",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white24,
                          ),
                          color: Colors.grey,
                          shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: controller.clearAll,
                        icon: const Icon(
                            size: 13, Icons.clear, color: Colors.white),
                      ),
                    ),
                    const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameDialog(
      BuildContext context, SoundMixerController controller) {
    TextEditingController textController = TextEditingController();
    final RxString inputText = ''.obs; // Declare RxString for input

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0C112E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Rename this ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "mix?",
                      style: TextStyle(
                        color: Color(0xff531DAB),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: textController,
                  onChanged: (value) {
                    inputText.value = value; // Update observable value
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Write mix name",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xff161B36),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Obx(() {
                    return OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          inputText.isNotEmpty
                              ? const Color.fromARGB(
                                  255, 124, 9, 223) // Active color
                              : Colors.grey.withOpacity(0.7), // Inactive color
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: inputText.isNotEmpty
                          ? () {
                              _showRenameDialog1(context, controller);
                            }
                          : null,
                      child: const Text(
                        "Save Change",
                        style: TextStyle(color: Color(0xffFFFFFF)),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRenameDialog1(
      BuildContext context, SoundMixerController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0C112E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Remove all active ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "soinds?",
                      style: TextStyle(
                        color: Color(0xff531DAB),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  onChanged: (value) {},
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded edges
                        ),
                      ), // Background color
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff531DAB)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded edges
                        ),
                      ), // Background color
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Color(0xffFFFFFF)), // Text color
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(home: SoundMixerScreen()));
}
