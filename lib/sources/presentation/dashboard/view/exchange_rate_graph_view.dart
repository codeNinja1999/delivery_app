import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/dashboard_bloc.dart';
import '../model/exchange_rate_history_view_model.dart';

DateTime parseDate(String date) => DateFormat("yyyy-MM-dd").parse(date);

class ExchangeRateGraphView extends StatefulWidget {
  const ExchangeRateGraphView({super.key});

  @override
  State<ExchangeRateGraphView> createState() => _ExchangeRateGraphViewState();
}

class _ExchangeRateGraphViewState extends State<ExchangeRateGraphView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
      padding: const EdgeInsets.all(AppSize.viewSpacing),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.60, color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(AppSize.cornerRadius),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: const Column(
        children: [
          ExRateView(),
          SizedBox(height: AppSize.inset * 2),
          GraphView(),
          SizedBox(height: AppSize.inset),
        ],
      ),
    );
  }
}

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<double> stops = [0.0, 1.0];
    final List<Color> color = <Color>[
      Theme.of(context).colorScheme.primary.withOpacity(0.25),
      HexColor('#D9D9D9').withOpacity(0.0)
    ];
    final graphWidth = AppSize.screenWidth - AppSize.inset * 5;

    final LinearGradient gradientColors = LinearGradient(
      colors: color,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: stops,
    );
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.exchangeRateHistoryViewModel != current.exchangeRateHistoryViewModel,
      builder: (context, state) {
        return SizedBox(
          width: graphWidth,
          height: graphWidth * 0.75,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            title: const ChartTitle(),
            margin: EdgeInsets.zero,
            legend: const Legend(isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
            primaryXAxis: DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat.MMMd(),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                minimum: state.exchangeRateHistoryViewModel?.min,
                maximum: state.exchangeRateHistoryViewModel?.max,
                interval: state.exchangeRateHistoryViewModel?.interval,
                rangePadding: ChartRangePadding.none,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(color: Colors.transparent)),
            series: <SplineAreaSeries<ChartData, DateTime>>[
              SplineAreaSeries<ChartData, DateTime>(
                cardinalSplineTension: 0.1,
                dataSource: state.exchangeRateHistoryViewModel?.chartData ?? [],
                xValueMapper: (ChartData sales, _) => sales.date,
                yValueMapper: (ChartData sales, _) => sales.rate,
                name: "Rate",
                borderWidth: 3,
                gradient: gradientColors,
                borderColor: theme.colorScheme.outlineVariant,
              )
            ],
            trackballBehavior: TrackballBehavior(
              tooltipSettings: InteractiveTooltip(
                color: theme.colorScheme.primary,
                canShowMarker: true,
              ),
              lineDashArray: [10, 10],
              enable: true,
              lineColor: theme.colorScheme.primary,
              tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
              lineWidth: 1.5,
              activationMode: ActivationMode.singleTap,
              markerSettings: TrackballMarkerSettings(
                markerVisibility: TrackballVisibilityMode.visible,
                color: theme.colorScheme.primary,
                borderWidth: 4,
                height: 10,
                width: 10,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ExRateView extends StatelessWidget {
  const ExRateView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.exchangeRateHistoryViewModel != current.exchangeRateHistoryViewModel,
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            state.exchangeRateHistoryViewModel?.exchangeRate ?? "",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            LocaleKeys.today.value,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
          trailing: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoute.changeCurrency,
            ).then((value) {
              final receivingCountry = value as ReceivingCountry;
              context.read<DashboardBloc>().add(GetExchangeRateHistoryList(receivingCountry.id));
            }),
            child: Container(
              padding: const EdgeInsets.only(
                top: AppSize.cornerRadiusMedium * 0.75,
                bottom: AppSize.cornerRadiusMedium * 0.75,
                left: AppSize.cornerRadiusMedium,
                right: AppSize.cornerRadiusSmall,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.viewMargin),
                color: theme.colorScheme.tertiary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (state.exchangeRateHistoryViewModel?.receivingCountryFlag != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SvgPicture.network(
                            state.exchangeRateHistoryViewModel!.receivingCountryFlag!,
                            height: AppSize.smallIconHeight,
                            placeholderBuilder: (context) => Container(color: theme.colorScheme.tertiary),
                          ),
                        )
                      : Container(),
                  const SizedBox(width: AppSize.cornerRadiusSmall),
                  Text(
                    state.exchangeRateHistoryViewModel?.counterCurrencyCode ?? "",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: AppSize.cornerRadiusMedium),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.primaryColor,
                    size: AppSize.smallIconHeight,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
