// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clean_music_app/features/music/data/datasources/local/local_datasource.dart';
import 'package:clean_music_app/injection.dart';

import 'package:on_audio_query/on_audio_query.dart';

void main() async {
  await LocalDatasourceImpl(
    sl<OnAudioQuery>(),
    sl(instanceName: 'always'),
    sl(instanceName: 'favorite'),
  ).getAlwaysPlayMusic();
}
