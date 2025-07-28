import 'dart:ui';

import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AttachmentWidget extends StatelessWidget {
  final Attachment attachment;
  const AttachmentWidget({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    switch (attachment.attachmentType) {
      case 'image':
        return CachedNetworkImage(
          imageUrl: attachment.file,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.broken_image),
          fit: BoxFit.contain,
        );
      case 'video':
        return _VideoPlayerWidget(videoUrl: attachment.file);
      
      default:
        return SizedBox.shrink();
    }
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const _VideoPlayerWidget({required this.videoUrl});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 200,
            color: Colors.black12,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }
}

// class AttachmentWidget extends StatelessWidget {
//   final Attachment attachment;
//   const AttachmentWidget({super.key, required this.attachment});

//   @override
//   Widget build(BuildContext context) {
//     switch (attachment.attachmentType) {
//       case 'image':
//         return _BlurredMediaContainer(
//           mediaUrl: attachment.file,
//           child: CachedNetworkImage(
//             imageUrl: attachment.file,
//             fit: BoxFit.contain,
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.broken_image),
//           ),
//         );
//       case 'video':
//         return _VideoPlayerWidget(videoUrl: attachment.file);
//       case 'audio':
//         return Container(
//           padding: EdgeInsets.all(8),
//           color: Colors.black12,
//           child: Row(
//             children: [
//               Icon(Icons.audiotrack),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Text("Audio File", overflow: TextOverflow.ellipsis),
//               ),
//             ],
//           ),
//         );
//       default:
//         return SizedBox.shrink();
//     }
//   }
// }

// class _BlurredMediaContainer extends StatelessWidget {
//   final String mediaUrl;
//   final Widget child;

//   const _BlurredMediaContainer({required this.mediaUrl, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           CachedNetworkImage(imageUrl: mediaUrl, fit: BoxFit.cover),
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//             child: Container(color: Colors.black.withAlpha(30)),
//           ),
//           Center(child: child),
//         ],
//       ),
//     );
//   }
// }

// class _VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//   const _VideoPlayerWidget({required this.videoUrl});

//   @override
//   State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _initialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() => _initialized = true);
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _initialized
//         ? _BlurredMediaContainer(
//             mediaUrl: widget.videoUrl,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 VideoPlayer(_controller),
//                 VideoProgressIndicator(_controller, allowScrubbing: true),
//                 Positioned(
//                   bottom: 8,
//                   right: 8,
//                   child: IconButton(
//                     icon: Icon(
//                       _controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _controller.value.isPlaying
//                             ? _controller.pause()
//                             : _controller.play();
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : Container(
//             height: 200,
//             color: Colors.black12,
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           );
//   }
// }
