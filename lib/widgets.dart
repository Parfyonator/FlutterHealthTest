import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';

Future<List<HealthDataPoint>> getData() async {
  List<HealthDataPoint> healthData = [];
  final now = DateTime.now();

  healthData = await HealthFactory().getHealthDataFromTypes(
    now.subtract(const Duration(seconds: 60)),
    now,
    [HealthDataType.HEART_RATE]
  );
  healthData.sort(((HealthDataPoint a, HealthDataPoint b) =>  b.dateTo.compareTo(a.dateTo)));
  print(healthData.map((e) => e.value));

  return healthData;
}

class HBPM extends StatelessWidget {
  // final now = DateTime.now();
  final health = HealthFactory();
  
  HBPM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(), // health.getHealthDataFromTypes(DateTime.now().subtract(Duration(seconds: 120)), DateTime.now(), [HealthDataType.HEART_RATE]),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( !snapshot.hasData ){
          print('Snapshot is empty.');
          return const Center(
            child: Text(
              'Snapshot is empty.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }
        
        final healthData = snapshot.data as List<HealthDataPoint>;
        if( healthData.isNotEmpty ){
          final hb = healthData.first;
          print('#####################');
          print('HBPM: ${hb.value}');
          print('#####################');
          return Center(
            child: Text(
              'HBPM: ${hb.value}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }

        print('No heartbeat data.');
        return const Center(
          child: Text(
            'No heartbeat data available',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}