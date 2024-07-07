import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(isDarkModeProvider.notifier).update(
                    (state) => !state,
                  );
            },
            // icon: const Icon(Icons.light_mode_outlined),
            icon: Icon(isDarkMode
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
          )
        ],
      ),
      body: Center(
          child: Text(
        'Valor: $clickCounter',
        style: Theme.of(context).textTheme.titleLarge,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;

          // ref.read(counterProvider.notifier).update((state) => state + 1);// ésta opción me gusta
          // porque puedo llamar una función que tiene como parámetro de entrada
          // la variable que me interesa, le hago la operación que quiero
          // y luego retorno su valor y ese valor será actualizado
          // sin embargo el profesor Fernando vá a utilizar la primera opción
          // me imagino que es porque es la más sencilla y se aplica fácilmente
          // a éste ejemplo del contador
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
