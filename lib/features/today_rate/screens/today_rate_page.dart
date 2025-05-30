import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/today_rate_bloc.dart';
import '../bloc/today_rate_event.dart';
import 'today_rate_screen.dart';

class TodayRatePage extends StatelessWidget {
  const TodayRatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MetalRatesBloc()..add(LoadMetalRates()),
      child: TodayRateScreenBloc(),
    );
    // return TodayRateScreenBloc();
  }
}
