import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  final List<ChartData> spots;
  final bool isLoading;

  const ChartCard({
    super.key,
    required this.spots,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              _buildLoadingChart()
            else
              SizedBox(
                height: 350.h,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  plotAreaBorderColor: Colors.transparent,
                  backgroundColor: const Color(0xFF000014).withOpacity(0.8),
                  primaryXAxis: DateTimeAxis(
                    title: const AxisTitle(
                      text: 'Time',
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    dateFormat: DateFormat('MMM-yyyy'),
                  ),
                  primaryYAxis: const NumericAxis(
                    title: AxisTitle(
                      text: 'Orders',
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  palette: [Color(0xFF64b4f0)],
                  series: [
                    LineSeries<ChartData, DateTime>(
                      dataSource: spots,
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.value,
                      initialIsVisible: true,
                      markerSettings: const MarkerSettings(isVisible: false),
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingChart() {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// Data model for the chart
class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}
