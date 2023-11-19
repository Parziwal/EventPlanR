import 'package:event_planr_app/domain/models/common/chart_spot.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore_for_file: prefer_const_declarations

class SoldTicketDiagram extends StatefulWidget {
  const SoldTicketDiagram({
    required this.chartSpots,
    required this.perMonth,
    super.key,
  });

  final List<ChartSpot> chartSpots;
  final bool perMonth;

  @override
  State<SoldTicketDiagram> createState() => _SoldTicketDiagramState();
}

class _SoldTicketDiagramState extends State<SoldTicketDiagram> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Column(
      children: [
        Text(
          l10n.eventStatistics_SoldTickets,
          style: theme.textTheme.titleLarge,
        ),
        AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              _mainData(context),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData _mainData(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final showSideTiles = false;

    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onSurface,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: theme.colorScheme.onSurface,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: showSideTiles),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: showSideTiles),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            getTitlesWidget: _leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: theme.colorScheme.onSurface),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) => [
            LineTooltipItem(
              'Datetime: ${DateFormat.Md(l10n.localeName).format(
                _flSpotToDateTime(touchedSpots.first.x),
              )}'
              ' Count: ${touchedSpots.first.y}',
              theme.textTheme.titleMedium!,
            ),
          ],
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            ...widget.chartSpots.map(
              (spot) => FlSpot(
                _dateTimeToFlSpot(spot.dateTime),
                spot.count.toDouble(),
              ),
            ),
          ],
          color: theme.colorScheme.primary,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final l10n = context.l10n;

    final dateTime = _flSpotToDateTime(value);
    String sideTitle;
    if (widget.perMonth) {
      sideTitle = DateFormat.MMM(l10n.localeName).format(dateTime);
    } else {
      sideTitle = DateFormat.Md(l10n.localeName).format(dateTime);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -45,
      child: Text(sideTitle, style: style),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Text(value.toString(), style: style, textAlign: TextAlign.left);
  }

  DateTime _flSpotToDateTime(double value) {
    if (widget.perMonth) {
      return DateTime(
        value ~/ 100,
        (value % 100).toInt(),
      );
    } else {
      return DateTime(
        value ~/ 10000,
        (value / 100 % 100).toInt(),
        (value % 100).toInt(),
      );
    }
  }

  double _dateTimeToFlSpot(DateTime dateTime) {
    if (widget.perMonth) {
      return (dateTime.month * 100 + dateTime.month).toDouble();
    } else {
      return (dateTime.year * 10000 + dateTime.month * 100 + dateTime.day)
          .toDouble();
    }
  }
}
