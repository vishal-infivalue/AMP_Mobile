
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopPerformingChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TopPerformingChartPage({super.key});

  @override
  TopPerformingChartPageState createState() => TopPerformingChartPageState();
}

class TopPerformingChartPageState extends State<TopPerformingChartPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(minimum: 0, maximum: 40, interval: 5),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, String>>[
              BarSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: const Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}