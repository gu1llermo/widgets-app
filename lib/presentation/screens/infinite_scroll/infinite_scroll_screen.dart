import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const String name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  final scrollController = ScrollController();
  List<int> imagesIds = [1, 2, 3, 4, 5];
  bool isLoading = false;
  bool isMounted = true;

  void addFiveIMages() {
    int ultimoElemento = imagesIds.last;
    for (var i = 1; i < 6; i++) {
      imagesIds.add(ultimoElemento + i);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // scrollController.position.pixels // es la posición actual
      // scrollController.position.maxScrollExtent // es lo máximo que puede llegar ese controlador
      final currentPosition = scrollController.position.pixels;
      final maxPositionExtend = scrollController.position.maxScrollExtent;
      const double thresHold =
          500; // se le coloca ese threshold para que vaya cargando
      // con cierta anticipación
      if (currentPosition + thresHold >= maxPositionExtend) {
        // Load next page
        loadNextPage();
      }
      setState(() {});
    });
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {}); // claro aquí no hace falta, pero es un ejemplo
    // para los casos que se quiera mostrar un loading por pantalla
    // que repito no es el caso actual

    await Future.delayed(const Duration(seconds: 2));
    addFiveIMages();
    isLoading = false;
    if (!isMounted) return;
    setState(() {});
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    final currentPosition = scrollController.position.pixels;
    final maxPositionExtend = scrollController.position.maxScrollExtent;
    const double thresHold = 150;
    if (currentPosition + thresHold <= maxPositionExtend) return;

    scrollController.animateTo(currentPosition + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));
    if (!isMounted) return;

    final int lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveIMages();
    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          edgeOffset: 10,
          strokeWidth: 2,
          onRefresh: onRefresh,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  placeholder:
                      const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(
                      'https://picsum.photos/id/${imagesIds[index]}/200/300'));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: isLoading
            ? SpinPerfect(
                infinite: true, child: const Icon(Icons.refresh_rounded))
            : const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}
