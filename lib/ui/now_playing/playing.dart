import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/model/song.dart';
import '../../icons/flutter_icon_icons.dart';
import 'audio_player_manager.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.playingSong, required this.songs});

  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(
      songs: songs,
      playingSong: playingSong,
    );
  }
}

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage(
      {super.key, required this.songs, required this.playingSong});

  final Song playingSong;
  final List<Song> songs;

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimController;
  late AudioPlayerManager _audioPlayerManager;

  @override
  void initState() {
    super.initState();
    _imageAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    );
    _audioPlayerManager =
        AudioPlayerManager(songUrl: widget.playingSong.source);
    _audioPlayerManager.init();
  }

  @override
  void dispose() {
    _audioPlayerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    final radius = (screenWidth - delta) / 2;
    // return Container(
    //     decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //             colors: [
    //               Color(0XFF020E1E),
    //               Color(0XFF00384F),
    //               Color(0xFF030C1D),
    //               Color(0xFF003E57),
    //               Color(0xFF030C1E)
    //             ],
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight
    //         )
    //     ),
      // child: CupertinoPageScaffold(
      //   backgroundColor: Colors.transparent,
      //     navigationBar: CupertinoNavigationBar(
      //       middle: const Text('Now Playing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
      //       trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: Colors.white,)),
      //     ),
          return Scaffold(
            extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text('Now Playing', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                centerTitle: true,
              ),
              body: Container(
                decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0XFF020E1E),
                  Color(0XFF00384F),
                  Color(0xFF030C1D),
                  Color(0xFF003E57),
                  Color(0xFF030C1E)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // RotationTransition(
                    //   turns:
                    //       Tween(begin: 0.0, end: 1.0).animate(_imageAnimController),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/spotify.png',
                            image: widget.playingSong.image,
                            width: screenWidth - delta,
                            height: screenWidth - delta,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/spotify.png',
                                width: screenWidth - delta,
                                height: screenWidth - delta,
                              );
                            }),
                      ),
                    ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.only(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      widget.playingSong.title,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      )
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                      widget.playingSong.artist,
                                      style: const TextStyle(
                                        fontSize: 19,
                                          color: Colors.white
                                      )
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.favorite_outline, color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 32,
                        left: 24,
                        right: 24,
                        bottom: 25,
                      ),
                      child: _progressBar(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 24,
                        right: 24,
                        bottom: 30,
                      ),
                      child: _mediaButtons(),
                    )
                  ],
                ),
              )
          );
  }

  Widget _mediaButtons() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const MediaButtonControl(function: null, icon: Icons.shuffle, color: Colors.white, size: 24),
          const MediaButtonControl(function: null, icon: Icons.skip_previous, color: Colors.white, size: 36),
          _playingButton(),
          const MediaButtonControl(function: null, icon: Icons.skip_next, color: Colors.white, size: 36),
          const MediaButtonControl(function: null, icon: Icons.repeat, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
        stream: _audioPlayerManager.durationState,
        builder: (context, snapshot) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffered ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;

          return ProgressBar(
              progress: progress,
              total: total,
              buffered: buffered,
              onSeek: _audioPlayerManager.player.seek,
              baseBarColor: Colors.white,
              progressBarColor: Colors.white,
              bufferedBarColor: Colors.white,
              thumbColor: Colors.white,
              thumbGlowColor: Colors.white,
              thumbRadius: 6.0,
              timeLabelTextStyle: const TextStyle(color: Colors.white),
          );
        });
  }
  StreamBuilder<PlayerState> _playingButton() {
    return StreamBuilder(
        stream: _audioPlayerManager.player.playerStateStream,
        builder: (context, snapshot) {
          final playState = snapshot.data;
          final processingState = playState?.processingState;
          final playing = playState?.playing;
          if(processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8),
                width: 48,
                height: 48,
                child: const CircularProgressIndicator(),
              );
          }
          else if(playing != true) {
            return MediaButtonControl(
                function: (){
                  _audioPlayerManager.player.play();
                },
                icon: FlutterIcon.play_circled,
                color: Colors.white,
                size: 48);
          }
          else if(processingState != ProcessingState.completed) {
            return MediaButtonControl(
                function: (){
                  _audioPlayerManager.player.pause();
                },
                icon: FlutterIcon.pause_circled,
                color: Colors.white,
                size: 48);
          }
          else {
            return MediaButtonControl(
                function: () {
                  _audioPlayerManager.player.seek(Duration.zero);
                },
                icon: Icons.replay,
                color: Colors.white,
                size: 48);
          }
        }
    );
  }
}



class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.size,
  });

  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  State<StatefulWidget> createState() => _MediaButtonControlState();
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.function,
        icon: Icon(widget.icon, color: widget.color ?? Colors.white,),
        iconSize: widget.size,
        );
  }
}
