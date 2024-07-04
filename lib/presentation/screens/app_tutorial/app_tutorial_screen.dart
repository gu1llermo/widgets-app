import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imgUrl;

  SlideInfo(this.title, this.caption, this.imgUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      'Busca la comida',
      'Aliquip nisi dolor enim cillum ex consectetur duis Lorem enim eiusmod.',
      'assets/images/1.png'),
  SlideInfo(
      'Entrega rápida',
      'Laborum sit incididunt exercitation voluptate nostrud.',
      'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Cupidatat aliquip ex nostrud sunt.',
      'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {
  static const String name = 'app_tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
      // endReached = page >= slides.length - 1 ? true : false;
      if (page >= slides.length - 1 && !endReached)
        setState(() {
          endReached = true;
          print('Pasé por el set state');
        });
      print('page: $page');
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              controller: pageViewController,
              physics: const BouncingScrollPhysics(),
              children: slides
                  .map((slideData) => _Slide(
                      title: slideData.title,
                      caption: slideData.caption,
                      imgUrl: slideData.imgUrl))
                  .toList(),
            ),
            Positioned(
                top: 50,
                right: 20,
                child: TextButton(
                  child: const Text('Skip'),
                  onPressed: () => context.pop(),
                )),
            endReached
                ? Positioned(
                    bottom: 30,
                    right: 30,
                    child: FadeInRight(
                      from: 15,
                      delay: const Duration(seconds: 1),
                      child: FilledButton(
                        child: const Text('Comenzar'),
                        onPressed: () => context.pop(),
                      ),
                    ))
                : const SizedBox(),
          ],
        ));
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imgUrl;

  const _Slide(
      {required this.title, required this.caption, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imgUrl)),
            const SizedBox(height: 20),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
