import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:money_manager/widgets/indicators.dart';

import 'package:provider/provider.dart';
import '../models/chart_model.dart';

class PieChartWidget extends StatefulWidget {
  final List<ChartModel> chartData;
  final double total;
  const PieChartWidget({super.key, required this.chartData, required this.total});

  @override
  State<StatefulWidget> createState() => PieChartWidgetState();
}

class PieChartWidgetState extends State <PieChartWidget>{
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    TransactionViewModel vm = context.read<TransactionViewModel>();
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(vm),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.chartData.map((e) => Column(
                children: [
                  Indicator(
                    color: vm.colors[widget.chartData.indexOf(e)],
                    text: '${e.title}',
                    isSquare: true,
                  ),
                ],
              ) ).toList()

          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(TransactionViewModel vm) {
    return
      List.generate(widget.chartData.length, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        return PieChartSectionData(
          color: vm.colors[i],
          value: (widget.chartData[i].value! / widget.total) * 100 ,
          title: '${((widget.chartData[i].value! / widget.total) * 100) .toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      }
      );
  }
}