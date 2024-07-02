import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const String name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI controls + Titles')),
      body: const _UiControlsView(),
    );
  }
}

enum Transportation { car, submarine, boat, plane }

class _UiControlsView extends StatefulWidget {
  const _UiControlsView({
    super.key,
  });

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool wantsDinner = false;
  bool wantsBreakfast = false;
  bool wantsLunch = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper,
          onChanged: (value) => setState(() {
            isDeveloper = value;
          }),
        ),
        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              title: const Text('By Car'),
              subtitle: const Text('viajar por carro'),
              value: Transportation.car,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('By Boat'),
              subtitle: const Text('viajar por bote'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              title: const Text('By Submarine'),
              subtitle: const Text('viajar por submarino'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
            RadioListTile(
              title: const Text('By Plane'),
              subtitle: const Text('viajar por avión'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Cena?'),
          subtitle: const Text('comida sabrosa'),
          value: wantsDinner,
          onChanged: (value) => setState(() {
            wantsDinner = value ?? wantsDinner;
          }),
        ),
        CheckboxListTile(
          title: const Text('Almuerzo?'),
          subtitle: const Text('lunch'),
          value: wantsLunch,
          onChanged: (value) => setState(() {
            wantsLunch = value ?? wantsLunch;
          }),
        ),
        CheckboxListTile(
          title: const Text('Desayuno?'),
          subtitle: const Text('Breakfast'),
          value: wantsBreakfast,
          onChanged: (value) => setState(() {
            wantsBreakfast = value ?? wantsBreakfast;
          }),
        ),
      ],
    );
  }
}
