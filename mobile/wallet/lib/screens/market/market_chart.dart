import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketChart extends StatelessWidget {
  final TrackballBehavior trackballBehavior;
  final ValueNotifier currentCoinPrice;
  final double minPrice;
  final double maxPrice;
  final List<LinearPrice> data;
  final int decimalPlaces;

  MarketChart(this.trackballBehavior, this.currentCoinPrice, this.minPrice,
      this.maxPrice, this.data, this.decimalPlaces);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        trackballBehavior: trackballBehavior,
        onTrackballPositionChanging: (TrackballArgs args) {
          currentCoinPrice.value = args.chartPointInfo.chartDataPoint!.yValue
              .toStringAsFixed(decimalPlaces);
        },
        primaryXAxis: DateTimeAxis(
          isVisible: false,
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: minPrice - minPrice * 0.1,
          maximum: maxPrice + maxPrice * 0.1,
        ),
        zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true, enablePanning: true, zoomMode: ZoomMode.x),
        series: <FastLineSeries<LinearPrice, DateTime>>[
          FastLineSeries<LinearPrice, DateTime>(
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
