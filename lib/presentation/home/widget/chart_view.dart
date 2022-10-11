import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../values/values.dart';

class ChartView extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartView({Key? key, required this.chartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: spacingContainer,
              right: spacingContainer,
              top: spacingContainer),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text("Historical Chart", style: mediumLargeTextStyle)),
        ),
        Padding(
          padding: const EdgeInsets.all(spacingContainer),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(decimalPlaces: 6),
                  enableAxisAnimation: true,
                  selectionType: SelectionType.series,
                  tooltipBehavior: TooltipBehavior(
                      enable: true, header: '', decimalPlaces: 6),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ])),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
