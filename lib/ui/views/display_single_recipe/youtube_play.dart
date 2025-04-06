import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayerView extends StatefulWidget {
  final String youtubeUrl;

  const YoutubeVideoPlayerView({Key? key, required this.youtubeUrl}) : super(key: key);

  @override
  State<YoutubeVideoPlayerView> createState() => _YoutubeVideoPlayerViewState();
}

class _YoutubeVideoPlayerViewState extends State<YoutubeVideoPlayerView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayerController.convertUrlToId(widget.youtubeUrl);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text('Watch Recipe Video')),
          body: player,
        );
      },
    );
  }
}
