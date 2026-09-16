import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';

/// Full-bleed, X.com/Reddit-style attachment carousel for a post card. Each
/// page is sized to that attachment's own aspect ratio; the frame animates
/// its height as you swipe between differently-shaped attachments instead of
/// forcing every attachment into one fixed frame. Dot indicators appear once
/// there's more than one attachment.
class FeedAttachmentCarousel extends StatefulWidget {
  const FeedAttachmentCarousel({super.key, required this.attachments});

  final List<Attachments> attachments;

  @override
  State<FeedAttachmentCarousel> createState() =>
      _FeedAttachmentCarouselState();
}

class _FeedAttachmentCarouselState extends State<FeedAttachmentCarousel> {
  static const double _defaultAspectRatio = 4 / 5;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Map<int, double> _resolvedRatios = {};

  double get _currentRatio =>
      _resolvedRatios[_currentPage] ?? _defaultAspectRatio;

  void _onRatioResolved(int index, double ratio) {
    if (_resolvedRatios[index] == ratio) return;
    setState(() => _resolvedRatios[index] = ratio);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attachments = widget.attachments;
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: constraints.maxWidth,
              height: constraints.maxWidth / _currentRatio,
              child: PageView.builder(
                controller: _pageController,
                itemCount: attachments.length,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final attachment = attachments[index];
                  // The backend's casing for attachmentType isn't
                  // guaranteed (some call sites elsewhere already defend
                  // against this with .toLowerCase()) - matching case
                  // sensitively here risked silently routing a video
                  // through the image renderer via the fallback branch.
                  return switch (attachment.attachmentType.trim().toLowerCase()) {
                    'video' => FeedVideoAttachment(
                      url: attachment.file,
                      attachmentId: attachment.id,
                      onAspectRatioResolved: (ratio) =>
                          _onRatioResolved(index, ratio),
                    ),
                    'image' => FeedImageAttachment(
                      url: attachment.file,
                      onAspectRatioResolved: (ratio) =>
                          _onRatioResolved(index, ratio),
                    ),
                    _ => AttachmentWidget(
                      attachment: attachment,
                      width: double.infinity,
                      height: double.infinity,
                      backgroundColor: Colors.black,
                      borderRadius: BorderRadius.zero,
                    ),
                  };
                },
              ),
            );
          },
        ),
        if (attachments.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(attachments.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
