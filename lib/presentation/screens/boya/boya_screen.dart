import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BoyaScreen extends StatelessWidget {
  const BoyaScreen({super.key});

  static const String path = '/boya';
  static const String name = 'boya_screen';

  void _showOtherMarkerPopup(
      {required BuildContext context, required OtherMarker marker}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Información del marcador'),
          content: Column(
            children: [
              Text('Nombre: ${marker.nombreReal}'),
              Text('Institución: ${marker.institucion}'),
              Text('Estación: ${marker.estacion}'),
              Text('Latitud: ${marker.location.latitude}'),
              Text('Longitud: ${marker.location.longitude}'),
              const AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: BoyaChart(data: [1.0, 2.5, 1.8, 3.0, 2.2])),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BoyaScreen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _showOtherMarkerPopup(
                      context: context,
                      marker: OtherMarker(location: Location()));
                },
                child: const Text('Open BoyaChart')),
            // BoyaChart(data: [1.0, 2.5, 1.8, 3.0, 2.2]),
          ],
        ),
      ),
    );
  }
}

class BoyaChart extends StatelessWidget {
  final List<double> data;

  const BoyaChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: true,
              barWidth: 2,
              color: Colors.blue,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherMarker {
  final String nombreReal;
  final String institucion;
  final String estacion;
  final Location location;

  OtherMarker({
    this.nombreReal = 'Joen Doe',
    this.institucion = 'Alabama',
    this.estacion = 'Spring',
    required this.location,
  });
}

class Location {
  final String latitude;
  final String longitude;

  Location({this.latitude = '1.2.3', this.longitude = '4.5.6'});
}
