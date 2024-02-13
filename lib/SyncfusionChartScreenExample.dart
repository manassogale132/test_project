import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SyncfusionChartScreenExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stacked Column Chart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Stacked Column Chart'),
        ),
        body: Center(
          child: Container(
            height: 300,
            child: _buildStackedColumnChart(),
          ),
        ),
      ),
    );
  }

  Widget _buildStackedColumnChart() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          width: 500, // Set the width of the chart container
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0), // Hide the major gridlines
              labelIntersectAction: AxisLabelIntersectAction.rotate45, // Rotate the x-axis labels
            ),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.compact(), // Change the format of y-axis labels
            ),
            series: _getStackedColumnSeries(),
          ),
        ),
      ],
    );
  }

  List<StackedColumnSeries<_ChartData, String>> _getStackedColumnSeries() {
    final List<_ChartData> chartData = [
      _ChartData('Jan', 80, 10, 20),
      _ChartData('Feb', 35, 28, 22),
      _ChartData('Mar', 40, 30, 25),
      _ChartData('Apr', 38, 32, 27),
      _ChartData('May', 42, 35, 30),
      _ChartData('Jun', 48, 40, 35),
      _ChartData('Jul', 48, 40, 35),
    ];

    return <StackedColumnSeries<_ChartData, String>>[
      StackedColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.month,
        yValueMapper: (_ChartData sales, _) => sales.sales1,
        name: 'Product A',
      ),
      StackedColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.month,
        yValueMapper: (_ChartData sales, _) => sales.sales2,
        name: 'Product B',
      ),
      StackedColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.month,
        yValueMapper: (_ChartData sales, _) => sales.sales3,
        name: 'Product C',
      ),
    ];
  }
}

class _ChartData {
  _ChartData(this.month, this.sales1, this.sales2, this.sales3);

  final String month;
  final double sales1;
  final double sales2;
  final double sales3;
}
