import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();

  List<SongModel> data = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPermission();
  }

  void getPermission() async {
    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      } else {
        loadMusic();
      }
    } on PlatformException catch (e) {
      print('Permission error: ${e.code}, ${e.message}, ${e.details}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  void loadMusic() async {
    data = await _onAudioQuery.querySongs();
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                print(data[0].data);
              },
              child: Text("music"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var music = data[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      tileColor: Colors.grey.shade300,
                      minTileHeight: 100,
                      title: Text(music.title, maxLines: 1),
                      leading: ElevatedButton(
                        onPressed: () async {
                          final playlist = ConcatenatingAudioSource(
                            // Start loading next item just before reaching it
                            useLazyPreparation: true,
                            // Customise the shuffle algorithm
                            shuffleOrder: DefaultShuffleOrder(
                              random: Random(data.length),
                            ),
                            // Specify the playlist items
                            children:
                                data
                                    .map(
                                      (e) => AudioSource.file(
                                        e.data,
                                        tag: MediaItem(
                                          id: e.id.toString(),
                                          title: e.title,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          );

                          await _audioPlayer.setAudioSource(
                            playlist,
                            initialIndex: 0,
                            initialPosition: Duration.zero,
                          );
                          await _audioPlayer.play();
                          // final duration = await _audioPlayer.setAudioSource(
                          //   AudioSource.file(
                          //     music.data,
                          //     tag: MediaItem(
                          //       id: music.id.toString(),
                          //       title: music.title,
                          //     ),
                          //   ),
                          // );
                          // await _audioPlayer.play();
                        },
                        child: Text('Play'),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await _audioPlayer.stop();
                        },
                        child: Text('stop'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
