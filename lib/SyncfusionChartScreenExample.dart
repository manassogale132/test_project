import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SyncfusionChartScreenExample extends StatefulWidget {
  const SyncfusionChartScreenExample({super.key});

  @override
  State<SyncfusionChartScreenExample> createState() =>
      _SyncfusionChartScreenExampleState();
}

class _SyncfusionChartScreenExampleState
    extends State<SyncfusionChartScreenExample> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('China', 20000, 33000, 43000, 10000),
      ChartData('USA', 13000, 9000, 20000, 38000),
      ChartData('UK', 42000, 22000, 26000, 37000),
      ChartData('Brazil', 48000, 38000, 48000, 34000),
      ChartData('India', 26000, 5000, 35000, 43000)
    ];

    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(12.0),
          child: SfCartesianChart(
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
            ),
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'Countries'),
              majorGridLines: MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Investments'),
              minorGridLines: MinorGridLines(width: 0),
              //numberFormat: NumberFormat.currency(locale: 'en_In', symbol: "₹"),
              numberFormat: NumberFormat.compact(),
              maximumLabels: 3,
            ),
            palette: <Color>[
              Colors.greenAccent,
              Colors.pinkAccent,
              Colors.amberAccent,
              Colors.blue,
            ],
            series: <CartesianSeries>[
              StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1),
              StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y2),
              StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y3),
              StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y4)
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);

  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
}
