import 'package:clean_music_app/features/music/presentation/widgets/heading_area.dart';
import 'package:clean_music_app/features/music/presentation/widgets/menu_button_area.dart';
import 'package:clean_music_app/features/music/presentation/widgets/menu_title_area.dart';
import 'package:clean_music_app/features/music/presentation/widgets/music_view_area.dart';
import 'package:clean_music_app/features/music/presentation/widgets/playing_and_always_play_area.dart';
import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search widget
            headingArea(context),
            // Music Playing Section
            playingAndAlwaysPlayArea(context),
            // Favorite Button
            menuButtonArea(context),
            // My Music Title
            menuTitleArea(context),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            // Music View Area
            musicViewArea(context),
          ],
        ),
      ),
    );
  }
}
