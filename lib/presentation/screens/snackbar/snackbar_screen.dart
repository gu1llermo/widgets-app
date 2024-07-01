import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const String name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) async {
    final respuesta = await showDialog<bool>(
      barrierDismissible: false,
      // barrierColor: Colors.amber.withOpacity(0.3),
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Estás seguro?'),
        content: const Text(
            'Ut amet labore reprehenderit est fugiat aute non laborum fugiat occaecat. Elit duis esse labore quis exercitation commodo. Aute adipisicing eiusmod elit eiusmod minim qui consectetur adipisicing culpa. Est do velit et incididunt ad ut. Sunt ullamco exercitation in est aliquip enim excepteur cupidatat non. Duis pariatur sit tempor qui. Deserunt elit mollit laboris do aliqua nulla sunt et officia cillum.'),
        actions: [
          ElevatedButton(
              onPressed: () => context.pop(true), child: const Text('Yes')),
          ElevatedButton(
              onPressed: () => context.pop(false), child: const Text('No')),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
    print(respuesta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SnackBar y diálogos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                // 555fsf
                // 666fsf
                // 666fsf
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Exercitation id aliquip anim enim culpa tempor nostrud commodo proident aliqua do. Elit cupidatat incididunt pariatur nulla esse fugiat veniam nulla magna sunt irure eu ut eu. Dolor exercitation commodo aute ut deserunt magna est voluptate elit. Irure fugiat eu do laboris excepteur Lorem reprehenderit esse ex. Commodo ad dolore mollit nostrud ipsum occaecat aliqua anim ea do amet nostrud. Irure commodo est nostrud sunt amet pariatur minim ex eiusmod quis ea id est. Ipsum ad non aliquip ullamco quis sunt commodo ad ea Lorem fugiat aute sit ex.')
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () => openDialog(context),
                child: const Text('Mostrar diálogo de pantalla')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
        label: const Text('Mostrar snackbar'),
      ),
    );
  }
}
