// Fixed rate_bloc.dart
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/today_rate_model.dart';
import 'today_rate_event.dart';
import 'today_rate_state.dart';

class MetalRatesBloc extends Bloc<MetalRatesEvent, MetalRatesState> {
  static const String _prefsKey = 'metal_rates_list';

  MetalRatesBloc() : super(MetalRatesInitial()) {
    on<LoadMetalRates>(_onLoadMetalRates);
    on<AddMetalRate>(_onAddMetalRate);
    on<UpdateMetalRate>(_onUpdateMetalRate);
    on<DeleteMetalRate>(_onDeleteMetalRate);
    on<RefreshMetalRates>(_onRefreshMetalRates);
  }

  Future<void> _onLoadMetalRates(LoadMetalRates event, Emitter<MetalRatesState> emit) async {
    try {
      emit(MetalRatesLoading());

      final prefs = await SharedPreferences.getInstance();
      final List<String>? jsonList = prefs.getStringList(_prefsKey);

      // 🔍 Debug: Print raw JSON strings from SharedPreferences
      print("Raw JSON List from SharedPreferences: $jsonList");

      final List<MetalRate> rates = jsonList?.map((json) {
        final map = Map<String, dynamic>.from(jsonDecode(json));
        print("Decoded JSON Map: $map"); // 🔍 Debug individual map
        return MetalRate.fromMap(map);
      }).toList() ?? [];

      // 🧾 Debug: Print final list of MetalRate objects
      print("Parsed MetalRate Objects: $rates");

      emit(MetalRatesLoaded(rates: rates));
    } catch (e) {
      print("Error loading metal rates: $e"); // 🔍 Catch and print error
      emit(MetalRatesError(message: 'Failed to load metal rates: $e'));
    }
  }

  Future<void> _onAddMetalRate(AddMetalRate event, Emitter<MetalRatesState> emit) async {
    try {
      emit(MetalRatesLoading());

      final prefs = await SharedPreferences.getInstance();
      final List<String>? jsonList = prefs.getStringList(_prefsKey);

      final List<MetalRate> currentRates = jsonList?.map((json) => MetalRate.fromMap(Map<String, dynamic>.from(jsonDecode(json)))).toList() ?? [];

      final newRate = event.rate.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      currentRates.add(newRate);

      final updatedJsonList = currentRates.map((rate) {
        final jsonMap = rate.toMap();
        final jsonString = jsonEncode(jsonMap);
        print("Saving JSON: $jsonString"); // 🔍 Print each rate as JSON
        return jsonString;
      }).toList();

      await prefs.setStringList(_prefsKey, updatedJsonList);

      emit(MetalRatesLoaded(rates: currentRates));
    } catch (e) {
      emit(MetalRatesError(message: 'Failed to add rate: $e'));
    }
  }

  Future<void> _onUpdateMetalRate(UpdateMetalRate event, Emitter<MetalRatesState> emit) async {
    try {
      emit(MetalRatesLoading());

      final prefs = await SharedPreferences.getInstance();
      final List<String>? jsonList = prefs.getStringList(_prefsKey);

      final List<MetalRate> currentRates = jsonList?.map((json) => MetalRate.fromMap(Map<String, dynamic>.from(jsonDecode(json)))).toList() ?? [];

      final index = currentRates.indexWhere((rate) => rate.id == event.oldRate.id);
      if (index != -1) {
        currentRates[index] = event.newRate.copyWith(id: event.oldRate.id);
      }

      final updatedJsonList = currentRates.map((rate) => jsonEncode(rate.toMap())).toList();
      await prefs.setStringList(_prefsKey, updatedJsonList);

      emit(MetalRatesLoaded(rates: currentRates));
    } catch (e) {
      emit(MetalRatesError(message: 'Failed to update rate: $e'));
    }
  }

  Future<void> _onDeleteMetalRate(DeleteMetalRate event, Emitter<MetalRatesState> emit) async {
    try {
      emit(MetalRatesLoading());

      final prefs = await SharedPreferences.getInstance();
      final List<String>? jsonList = prefs.getStringList(_prefsKey);

      final List<MetalRate> currentRates = jsonList?.map((json) => MetalRate.fromMap(Map<String, dynamic>.from(jsonDecode(json)))).toList() ?? [];

      currentRates.removeWhere((rate) => rate.id == event.rate.id);

      final updatedJsonList = currentRates.map((rate) => jsonEncode(rate.toMap())).toList();
      await prefs.setStringList(_prefsKey, updatedJsonList);

      emit(MetalRatesLoaded(rates: currentRates));
    } catch (e) {
      emit(MetalRatesError(message: 'Failed to delete rate: $e'));
    }
  }

  Future<void> _onRefreshMetalRates(RefreshMetalRates event, Emitter<MetalRatesState> emit) async {
    await Future.delayed(Duration(milliseconds: 300));
    add(LoadMetalRates());
  }
}