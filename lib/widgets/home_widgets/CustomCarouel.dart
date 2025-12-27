import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/utils/quotes.dart';
import 'package:my_app/widgets/safewebview.dart';

final List<String> dummyUrls = [
  'https://flutter.dev',
  'https://dart.dev',
  'https://www.google.com',
  'https://www.wikipedia.org',
];

class Customcarousel extends StatefulWidget {
  const Customcarousel({Key? key}) : super(key: key);

  @override
  State<Customcarousel> createState() => _CustomcarouselState();
}

class _CustomcarouselState extends State<Customcarousel> {
  late PageController _pageController;
  Timer? _timer;

  final int _initialPage = 1000;
  int _currentPage = 1000;

  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: _initialPage,
    );

    // ✅ Fix initial oversized cards on first render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_initialPage);
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_isUserScrolling) return;

      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170, // ✅ requested height
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _isUserScrolling = true;
          } else if (notification is ScrollEndNotification) {
            _isUserScrolling = false;
            _currentPage = _pageController.page!.round();
          }
          return false;
        },
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            final realIndex = index % imageSliders.length;

            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double scale = 1.0;

                if (_pageController.position.haveDimensions) {
                  scale = (_pageController.page! - index).abs();
                  scale = (1 - scale * 0.4).clamp(0.75, 1.0);
                }

                return Center(
                  child: Transform.scale(
                    scale: scale,
                    child: child,
                  ),
                );
              },
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SafeWebview(
                        url: dummyUrls[realIndex % dummyUrls.length],
                      ),
                    ),
                  );
                },
                child: AspectRatio(
                  aspectRatio: 16 / 9, // ✅ rectangular banner look
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imageSliders[realIndex],
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, left: 8),
                              child: Text(
                                articleTitle[realIndex],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.055,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
