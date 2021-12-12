import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;
  final num minPrice;
  final num maxPrice;

  SimpleLineChart(this.seriesList, this.animate, this.maxPrice, this.minPrice);

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      behaviors: [new charts.PanAndZoomBehavior()],
      primaryMeasureAxis: charts.NumericAxisSpec(
        viewport: charts.NumericExtents(minPrice, maxPrice),
      ),
    );
  }
}
