import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketChart extends StatelessWidget {
  final TrackballBehavior trackballBehavior;
  final ValueNotifier currentCoinPrice;
  final double minPrice;
  final double maxPrice;
  final List<LinearPrice> data;
  final int decimalPlaces;
  final double lastPrice;
  final ValueNotifier currentDate;
  final Color color;

  MarketChart(
      this.trackballBehavior,
      this.currentCoinPrice,
      this.minPrice,
      this.maxPrice,
      this.data,
      this.decimalPlaces,
      this.lastPrice,
      this.currentDate,
      this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        borderColor: Colors.grey.shade200,
        plotAreaBorderColor: Colors.grey.shade200,
        palette: [color],
        trackballBehavior: trackballBehavior,
        onTrackballPositionChanging: (TrackballArgs args) {
          currentCoinPrice.value = args.chartPointInfo.chartDataPoint!.yValue
              .toStringAsFixed(decimalPlaces);
          currentDate.value = DateTime.fromMillisecondsSinceEpoch(
              args.chartPointInfo.chartDataPoint!.xValue);
        },
        onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
          currentCoinPrice.value = lastPrice.toStringAsFixed(decimalPlaces);
          currentDate.value = DateTime.now();
        },
        primaryXAxis: DateTimeAxis(
          isVisible: false,
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: minPrice - minPrice * 0.01,
          maximum: maxPrice + maxPrice * 0.01,
        ),
        zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x),
        series: <SplineSeries<LinearPrice, DateTime>>[
          SplineSeries<LinearPrice, DateTime>(
            // Bind data source
            dataSource:
                data.isNotEmpty ? data : [LinearPrice(DateTime.now(), 0)],
            xValueMapper: (LinearPrice prices, _) => prices.date,
            yValueMapper: (LinearPrice prices, _) => prices.price,
          )
        ],
      ),
    );
  }
}

class LinearPrice {
  final DateTime date;
  final double price;

  LinearPrice(this.date, this.price);
}
