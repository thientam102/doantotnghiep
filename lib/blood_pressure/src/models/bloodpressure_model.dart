import 'package:flutter/material.dart';

enum Classification {
  low,
  isolatedDiastolic,
  optimal,
  normal,
  high,
  grade1,
  grade2,
  grade3,
  isolatedSystolic
}

class BloodPressure {
  double systolic;
  double diastolic;
  double map; //mean arterial pressure
  double pulse; //pulse pressure
  Classification classification;

  BloodPressure(
      this.diastolic, this.systolic, this.map, this.pulse, this.classification);

  @override
  String toString() {
    return "$classification \nSystolic: $systolic mmHg \nDiastolic: $diastolic mmHg \nMAP: $map mmHg \nPulse: $pulse mmHg";
  }
}

final resultsMap = <Classification, Map<String, dynamic>>{
  Classification.low: {'text': 'Huyết áp thấp', 'color': Colors.red},
  Classification.isolatedDiastolic: {
    'text': 'Hạ huyết áp tâm trương',
    'color': Colors.red
  },
  Classification.optimal: {'text': 'Huyết áp tối ưu', 'color': Colors.green},
  Classification.normal: {
    'text': 'Huyết áp bình thường',
    'color': Colors.green
  },
  Classification.high: {'text': 'Tiền tăng huyết áp', 'color': Colors.orange},
  Classification.grade1: {
    'text': 'Tăng huyết áp cấp độ 1',
    'color': Colors.deepOrange
  },
  Classification.grade2: {
    'text': 'Tăng huyết áp cấp độ 2',
    'color': Colors.red
  },
  Classification.grade3: {
    'text': 'Tăng huyết áp cấp độ 3',
    'color': Colors.red[700]
  },
  Classification.isolatedSystolic: {
    'text': 'Tăng huyết áp tâm thu',
    'color': Colors.red
  },
};
