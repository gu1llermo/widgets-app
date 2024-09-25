import 'package:flutter/material.dart';
import 'dart:math';

class TransformAnimations4Screen extends StatefulWidget {
  const TransformAnimations4Screen({super.key});

  static const String path = '/transform_animations4';
  static const String name = 'transform_animations4_screen';

  @override
  State<TransformAnimations4Screen> createState() =>
      _TransformAnimations4ScreenState();
}

class _TransformAnimations4ScreenState
    extends State<TransformAnimations4Screen> {
  List<int> imagesIds = List<int>.generate(10, (index) => index);
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(_listener);
  }

  void _listener() {
    _currentPage = _pageController.page ?? 0;
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TransformAnimations4Screen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: PageView.builder(
            itemCount: imagesIds.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              if (index == _currentPage) {
                //final scale = max(1 - (_currentPage - index), 0.9);
                return _Imagen(
                  imagesIds: imagesIds,
                  index: index,
                );
              }
              if (index < _currentPage) {
                final scale = max(1 - (_currentPage - index), 0);
                final scaleX = max(1 - (_currentPage - index), 0.9);
                final scaleY = max(1 - (_currentPage - index), 0.8);
                final opacity = max(1 - (_currentPage - index), 0.6);
                //debugPrint('Scale1: $scale');
                return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..scale(scaleX, scaleY)
                      ..rotateY(pi * (1 - scale)),
                    child: Opacity(
                      opacity: opacity,
                      child: _Imagen(
                        imagesIds: imagesIds,
                        index: index,
                      ),
                    ));
              }
              final scaleX = max(1 - (index - _currentPage), 0.9);
              final scaleY = max(1 - (index - _currentPage), 0.8);
              final opacity = max(1 - (index - _currentPage), 0.6);
              return Transform.scale(
                  // scale: max(1 - (index - _currentPage), 0.9),
                  scaleX: scaleX,
                  scaleY: scaleY,
                  child: Opacity(
                    opacity: opacity,
                    child: _Imagen(
                      imagesIds: imagesIds,
                      index: index,
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class _Imagen extends StatelessWidget {
  const _Imagen({required this.imagesIds, required this.index});
  final List<int> imagesIds;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
          fit: BoxFit.fitHeight,
          width: double.infinity,
          height: 200,
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          image: NetworkImage(
              'https://picsum.photos/id/${imagesIds[index]}/200/200')),
    );
  }
}
