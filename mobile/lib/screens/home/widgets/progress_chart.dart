import 'package:bitescan/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var points = [2.0, 2.3, 3.0, 3.9, 4.1, 6.0, 6.5, 8.8, 9.0, 10.0];

    if (isRTL(context)) {
      points = points.reversed.toList();
    }

    return LineChart(
      LineChartData(
        minX: 2,
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: false,
        ),
        minY: 0,
        lineTouchData: LineTouchData(
          enabled: false,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => Colors.black87,
            tooltipPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            tooltipBorder: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            tooltipRoundedRadius: 8,
            tooltipMargin: -24,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map((e) => LineTooltipItem(
                        "Now",
                        TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ))
                  .toList();
            },
          ),
        ),
        showingTooltipIndicators: [
          ShowingTooltipIndicators([
            LineBarSpot(
              LineChartBarData(),
              0,
              FlSpot(3, points[4]),
            ),
          ]),
          ShowingTooltipIndicators([
            LineBarSpot(
              LineChartBarData(),
              1,
              FlSpot(7, points[7]),
            ),
          ])
        ],
        lineBarsData: [
          LineChartBarData(
            color: Colors.black,
            spots: points
                .map((e) => FlSpot(points.indexOf(e).toDouble(), e))
                .toList(),
            isCurved: true,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              checkToShowDot: (spot, barData) {
                return spot.y > 3 && spot.y < 5 || spot.y > 8 && spot.y < 9;
              },
            ),
            belowBarData: BarAreaData(
              gradient: LinearGradient(
                begin: Alignment(0, -3.5),
                end: Alignment(0.2, 1),
                stops: [0.5, 0.9],
                transform: GradientRotation(0),
                colors: [
                  Colors.black26,
                  Colors.transparent,
                ],
              ),
              show: true,
            ),
          ),
        ],
      ),
    );
  }
}
